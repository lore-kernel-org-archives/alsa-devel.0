From: Bernhard Kaindl <bk@suse.de>
Subject: aseqnet fixes for alsa-lib-0.9.0_cvs20020320
Date: Fri, 22 Mar 2002 01:53:21 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0203212236590.18527-300000@Wotan.suse.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="168427776-894725621-1016758401=:18527"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: ALSA Hackers <alsa-devel@lists.sourceforge.net>
Cc: Takashi Iwai <tiwai@suse.de>, "Dr. Matthias Nagorni" <mana@suse.de>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--168427776-894725621-1016758401=:18527
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,
   I've had problems with aseqnet, especially in client mode,
using it to send local seq events to a remote aseqnet server.

The first problem was that it called poll() without properly initializing
the struct pollid.events to POLLIN, so the poll never returned.

Fix for the first problem:

--- alsa-utils/seq/aseqnet/aseqnet.c	2002/03/21 21:39:27	1.1
+++ alsa-utils/seq/aseqnet/aseqnet.c	2002/03/21 22:02:13
@@ -420,7 +426,7 @@
 	for (;;) {
 		memset(pollfds, 0, pollfds_count * sizeof(struct pollfd));
 		seqifd_ptr = 0;
-		memcpy(pollfds, seqifds, width = seqifds_count);
+		memcpy(pollfds, seqifds, sizeof(*seqifds)*(width = seqifds_count));
 		if (server_mode) {
 			sockfd_ptr = width;
 			pollfds[width].fd = sockfd;

At this point to seq input pollfds are copied to the common pollfds struct,
the init with memset(..., 0, count * sizeof) is ok, but the cp of the pollfds
was only done with the count, without the sizeof, so only the first byte was
copied ;-)

The second problem was that copy_local_to_remote() was reading the local
events in a read loop but the seq was set to blocking mode so the loop
has never finished and data was not sent to the remote side.

Obviosly, the assumption copy_local_to_remote() assumes that we are in
nonblocking mode and that it can loop loop until all data has been read.

As this is the only place where local events are read, it' safe to enable
nonblocking mode, it works with 1, maybe the 0 was just a thinko:

@@ -234,7 +240,7 @@
        err = snd_seq_poll_descriptors(handle, seqofds, counto, POLLOUT);
        assert(err == counto);

-       snd_seq_nonblock(handle, 0);
+       snd_seq_nonblock(handle, 1);

        /* set client info */
        if (server_mode)

A third, smaller problem was that when the poll was interrupted due to
signals (e.g. SIGSTOP/CONT), do_loop() immediately exited witht message.

At this place it's ok to check for EINTR and call poll again until a
real error occurs and use perror() to show what has happend:

@@ -435,9 +441,13 @@
                                width++;
                        }
                }
-               rc = poll(pollfds, width, -1);
-               if (rc <= 0)
+               do
+                       rc = poll(pollfds, width, -1);
+               while (rc <= 0 && errno == EINTR);
+               if (rc <= 0) {
+                       perror("poll");
                        exit(1);
+               }
                if (server_mode) {
                        if (pollfds[sockfd_ptr].revents & (POLLIN|POLLOUT))
                                start_connection();

The last problem is that aseqnet uses struct snd_seq_event directly for
transferring data over the net but it includes a union with elements that
are dependent of the word size. One (obviosly unused) is snd_seq_ev_ipcshm:

/** external stored data - IPC shared memory */
typedef struct snd_seq_ev_ipcshm {
        size_t len;                     /**< length of data */
        key_t ipc;                      /**< IPC key */
} snd_seq_ev_ipcshm_t;

size_t is 8 bytes on 64bit so this causes sizeof(snd_seq_event_t) to be
32 on 64-bit while it's 28 (4 less) on 32bit. I think we could remove
snd_seq_ev_ipcshm but snd_seq_ev_ext, which is really used is the real
problem:

/** external stored data */
typedef struct snd_seq_ev_ext {
        size_t len;               /**< length of data */
        void *ptr;                /**< pointer to data (note: can be 64-bit) */
} snd_seq_ev_ext_t;

While it shouln't be a problem to declare len as int (would limit the
external event data to 2GB also on 64bit which shoun't be a problem),
the data pointer needs to be 64-bit in the real memory struct. For the
network transfer it isn't used, the data is just appended afte the
28 bytes of sturct snd_seq_event.

A quick hack to make aseqnet also working between 64 and 32bit machines
would be to set the network size of  sturct snd_seq_event to 28 octets
fixed:

@@ -543,8 +577,14 @@

        while (count > 0) {
                ev = (snd_seq_event_t*)buf;
-               buf += sizeof(snd_seq_event_t);
-               count -= sizeof(snd_seq_event_t);
+               if (sizeof(size_t) == 4) {
+                       buf += sizeof(snd_seq_event_t);
+                       count -= sizeof(snd_seq_event_t);
+               } else {
+                       buf += 28;   // Hack alarm: size differs because of
+                       count -= 28; // size_t and void* used in seq_ev_ext
+               }
+               // this works only with 64-bit bigendian if ext.len is int:
                if (snd_seq_ev_is_variable(ev) && ev->data.ext.len > 0) {
                        ev->data.ext.ptr = buf;
                        buf += ev->data.ext.len;

If this is done and ext.len(snd_seq_ev_ext_t.len) is declared as int, it works
also between 32-bit little endian and 64-bit bigendian.

- thanks to the luck that the union which uses snd_seq_ev_ext_t is last in
  struct snd_seq_event and len is first in snd_seq_ev_ext_t, the len should
  be read correctly...

Maybe it's better to have a #define SEQ_EVENT_SETSIZE or so to define
a fixed number of octets which are used then event data is transferred
over the net or stored on disk.

aseqnet-fixes.diff with the patche above is attached.

Also attached aseqnet.c.dif which also adds an -i/--info option
to aseqnet which prints some of the reveived events.
It's just a minor thing but a handy debugging helper.

All the best,
Bernd

--168427776-894725621-1016758401=:18527
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="aseqnet-fixes.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0203220153210.18527@Wotan.suse.de>
Content-Description: 
Content-Disposition: attachment; filename="aseqnet-fixes.diff"

LS0tIGFzZXFuZXQuYwkyMDAyLzAzLzIxIDIxOjM5OjI3CTEuMQ0KKysrIGFz
ZXFuZXQuYwkyMDAyLzAzLzIyIDAwOjE4OjU1DQpAQCAtMjM0LDcgKzI0MCw3
IEBADQogCWVyciA9IHNuZF9zZXFfcG9sbF9kZXNjcmlwdG9ycyhoYW5kbGUs
IHNlcW9mZHMsIGNvdW50bywgUE9MTE9VVCk7DQogCWFzc2VydChlcnIgPT0g
Y291bnRvKTsNCiANCi0Jc25kX3NlcV9ub25ibG9jayhoYW5kbGUsIDApOw0K
KwlzbmRfc2VxX25vbmJsb2NrKGhhbmRsZSwgMSk7DQogDQogCS8qIHNldCBj
bGllbnQgaW5mbyAqLw0KIAlpZiAoc2VydmVyX21vZGUpDQpAQCAtNDIwLDcg
KzQyNiw3IEBADQogCWZvciAoOzspIHsNCiAJCW1lbXNldChwb2xsZmRzLCAw
LCBwb2xsZmRzX2NvdW50ICogc2l6ZW9mKHN0cnVjdCBwb2xsZmQpKTsNCiAJ
CXNlcWlmZF9wdHIgPSAwOw0KLQkJbWVtY3B5KHBvbGxmZHMsIHNlcWlmZHMs
IHdpZHRoID0gc2VxaWZkc19jb3VudCk7DQorCQltZW1jcHkocG9sbGZkcywg
c2VxaWZkcywgc2l6ZW9mKCpzZXFpZmRzKSood2lkdGggPSBzZXFpZmRzX2Nv
dW50KSk7DQogCQlpZiAoc2VydmVyX21vZGUpIHsNCiAJCQlzb2NrZmRfcHRy
ID0gd2lkdGg7DQogCQkJcG9sbGZkc1t3aWR0aF0uZmQgPSBzb2NrZmQ7DQpA
QCAtNDM1LDkgKzQ0MSwxMyBAQA0KIAkJCQl3aWR0aCsrOw0KIAkJCX0NCiAJ
CX0NCi0JCXJjID0gcG9sbChwb2xsZmRzLCB3aWR0aCwgLTEpOw0KLQkJaWYg
KHJjIDw9IDApDQorCQlkbw0KKwkJCXJjID0gcG9sbChwb2xsZmRzLCB3aWR0
aCwgLTEpOw0KKwkJd2hpbGUgKHJjIDw9IDAgJiYgZXJybm8gPT0gRUlOVFIp
Ow0KKwkJaWYgKHJjIDw9IDApIHsNCisJCQlwZXJyb3IoInBvbGwiKTsNCiAJ
CQlleGl0KDEpOw0KKwkJfQ0KIAkJaWYgKHNlcnZlcl9tb2RlKSB7DQogCQkJ
aWYgKHBvbGxmZHNbc29ja2ZkX3B0cl0ucmV2ZW50cyAmIChQT0xMSU58UE9M
TE9VVCkpDQogCQkJCXN0YXJ0X2Nvbm5lY3Rpb24oKTsNCkBAIC01NDMsOCAr
NTc3LDE0IEBADQogDQogCXdoaWxlIChjb3VudCA+IDApIHsNCiAJCWV2ID0g
KHNuZF9zZXFfZXZlbnRfdCopYnVmOw0KLQkJYnVmICs9IHNpemVvZihzbmRf
c2VxX2V2ZW50X3QpOw0KLQkJY291bnQgLT0gc2l6ZW9mKHNuZF9zZXFfZXZl
bnRfdCk7DQorCQlpZiAoc2l6ZW9mKHNpemVfdCkgPT0gNCkgew0KKwkJCWJ1
ZiArPSBzaXplb2Yoc25kX3NlcV9ldmVudF90KTsNCisJCQljb3VudCAtPSBz
aXplb2Yoc25kX3NlcV9ldmVudF90KTsNCisJCX0gZWxzZSB7DQorCQkJYnVm
ICs9IDI4OyAgIC8vIEhhY2sgYWxhcm06IHNpemUgZGlmZmVycyBiZWNhdXNl
IG9mDQorCQkJY291bnQgLT0gMjg7IC8vIHNpemVfdCBhbmQgdm9pZCogdXNl
ZCBpbiBzZXFfZXZfZXh0DQorCQl9DQorCQkvLyB0aGlzIHdvcmtzIG9ubHkg
d2l0aCA2NC1iaXQgYmlnZW5kaWFuIGlmIGV4dC5sZW4gaXMgaW50Og0KIAkJ
aWYgKHNuZF9zZXFfZXZfaXNfdmFyaWFibGUoZXYpICYmIGV2LT5kYXRhLmV4
dC5sZW4gPiAwKSB7DQogCQkJZXYtPmRhdGEuZXh0LnB0ciA9IGJ1ZjsNCiAJ
CQlidWYgKz0gZXYtPmRhdGEuZXh0LmxlbjsNCg==
--168427776-894725621-1016758401=:18527
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="aseqnet.c.dif"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0203220153211.18527@Wotan.suse.de>
Content-Description: 
Content-Disposition: attachment; filename="aseqnet.c.dif"

LS0tIGFzZXFuZXQuYwkyMDAyLzAzLzIxIDIxOjM5OjI3CTEuMQ0KKysrIGFz
ZXFuZXQuYwkyMDAyLzAzLzIyIDAwOjE4OjU1DQpAQCAtNzIsNiArNzIsNyBA
QA0KIA0KIHN0YXRpYyBpbnQgc2VydmVyX21vZGU7DQogc3RhdGljIGludCB2
ZXJib3NlID0gMDsNCitzdGF0aWMgaW50IGluZm8gPSAwOw0KIA0KIA0KIC8q
DQpAQCAtODQsNiArODUsNyBAQA0KIAl7ImRlc3QiLCAxLCBOVUxMLCAnZCd9
LA0KIAl7ImhlbHAiLCAwLCBOVUxMLCAnaCd9LA0KIAl7InZlcmJvc2UiLCAw
LCBOVUxMLCAndid9LA0KKwl7ImluZm8iLCAwLCBOVUxMLCAnaSd9LA0KIAl7
TlVMTCwgMCwgTlVMTCwgMH0sDQogfTsNCiANCkBAIC05Myw3ICs5NSw3IEBA
DQogCWludCBwb3J0ID0gREVGQVVMVF9QT1JUOw0KIAljaGFyICpzb3VyY2Ug
PSBOVUxMLCAqZGVzdCA9IE5VTEw7DQogDQotCXdoaWxlICgoYyA9IGdldG9w
dF9sb25nKGFyZ2MsIGFyZ3YsICJwOnM6ZDp2IiwgbG9uZ19vcHRpb24sIE5V
TEwpKSAhPSAtMSkgew0KKwl3aGlsZSAoKGMgPSBnZXRvcHRfbG9uZyhhcmdj
LCBhcmd2LCAicDpzOmQ6dmkiLCBsb25nX29wdGlvbiwgTlVMTCkpICE9IC0x
KSB7DQogCQlzd2l0Y2ggKGMpIHsNCiAJCWNhc2UgJ3AnOg0KIAkJCWlmIChp
c2RpZ2l0KCpvcHRhcmcpKQ0KQEAgLTExMCw2ICsxMTIsOSBAQA0KIAkJY2Fz
ZSAndic6DQogCQkJdmVyYm9zZSsrOw0KIAkJCWJyZWFrOw0KKwkJY2FzZSAn
aSc6DQorCQkJaW5mbysrOw0KKwkJCWJyZWFrOw0KIAkJZGVmYXVsdDoNCiAJ
CQl1c2FnZSgpOw0KIAkJCWV4aXQoMSk7DQpAQCAtMTU3LDYgKzE2Miw3IEBA
DQogCWZwcmludGYoc3RkZXJyLCAiICAtcywtLXNvdXJjZSBhZGRyIDogcmVh
ZCBmcm9tIGdpdmVuIGFkZHIgKGNsaWVudDpwb3J0KVxuIik7DQogCWZwcmlu
dGYoc3RkZXJyLCAiICAtZCwtLWRlc3QgYWRkciA6IHdyaXRlIHRvIGdpdmVu
IGFkZHIgKGNsaWVudDpwb3J0KVxuIik7DQogCWZwcmludGYoc3RkZXJyLCAi
ICAtdiwgLS12ZXJib3NlIDogcHJpbnQgdmVyYm9zZSBtZXNzYWdlc1xuIik7
DQorCWZwcmludGYoc3RkZXJyLCAiICAtaSwgLS1pbmZvIDogcHJpbnQgY2Vy
dGFpbiByZWNlaXZlZCBldmVudHNcbiIpOw0KIH0NCiANCiANCkBAIC0yMzQs
NyArMjQwLDcgQEANCiAJZXJyID0gc25kX3NlcV9wb2xsX2Rlc2NyaXB0b3Jz
KGhhbmRsZSwgc2Vxb2ZkcywgY291bnRvLCBQT0xMT1VUKTsNCiAJYXNzZXJ0
KGVyciA9PSBjb3VudG8pOw0KIA0KLQlzbmRfc2VxX25vbmJsb2NrKGhhbmRs
ZSwgMCk7DQorCXNuZF9zZXFfbm9uYmxvY2soaGFuZGxlLCAxKTsNCiANCiAJ
Lyogc2V0IGNsaWVudCBpbmZvICovDQogCWlmIChzZXJ2ZXJfbW9kZSkNCkBA
IC00MjAsNyArNDI2LDcgQEANCiAJZm9yICg7Oykgew0KIAkJbWVtc2V0KHBv
bGxmZHMsIDAsIHBvbGxmZHNfY291bnQgKiBzaXplb2Yoc3RydWN0IHBvbGxm
ZCkpOw0KIAkJc2VxaWZkX3B0ciA9IDA7DQotCQltZW1jcHkocG9sbGZkcywg
c2VxaWZkcywgd2lkdGggPSBzZXFpZmRzX2NvdW50KTsNCisJCW1lbWNweShw
b2xsZmRzLCBzZXFpZmRzLCBzaXplb2YoKnNlcWlmZHMpKih3aWR0aCA9IHNl
cWlmZHNfY291bnQpKTsNCiAJCWlmIChzZXJ2ZXJfbW9kZSkgew0KIAkJCXNv
Y2tmZF9wdHIgPSB3aWR0aDsNCiAJCQlwb2xsZmRzW3dpZHRoXS5mZCA9IHNv
Y2tmZDsNCkBAIC00MzUsOSArNDQxLDEzIEBADQogCQkJCXdpZHRoKys7DQog
CQkJfQ0KIAkJfQ0KLQkJcmMgPSBwb2xsKHBvbGxmZHMsIHdpZHRoLCAtMSk7
DQotCQlpZiAocmMgPD0gMCkNCisJCWRvDQorCQkJcmMgPSBwb2xsKHBvbGxm
ZHMsIHdpZHRoLCAtMSk7DQorCQl3aGlsZSAocmMgPD0gMCAmJiBlcnJubyA9
PSBFSU5UUik7DQorCQlpZiAocmMgPD0gMCkgew0KKwkJCXBlcnJvcigicG9s
bCIpOw0KIAkJCWV4aXQoMSk7DQorCQl9DQogCQlpZiAoc2VydmVyX21vZGUp
IHsNCiAJCQlpZiAocG9sbGZkc1tzb2NrZmRfcHRyXS5yZXZlbnRzICYgKFBP
TExJTnxQT0xMT1VUKSkNCiAJCQkJc3RhcnRfY29ubmVjdGlvbigpOw0KQEAg
LTQ5Miw2ICs1MDIsMjggQEANCiAJcmV0dXJuIGJ1ZjsNCiB9DQogDQorc3Rh
dGljIHZvaWQgcHJpbnRfZXZlbnQoc25kX3NlcV9ldmVudF90ICpldikNCit7
DQorCXN3aXRjaCAoZXYtPnR5cGUpIHsNCisJY2FzZSBTTkRfU0VRX0VWRU5U
X0NPTlRST0xMRVI6IA0KKwkJcHJpbnRmKCJDaGFubmVsICUyZDogQ29udHJv
bCBldmVudCA6ICU1ZFxuIiwNCisJCQlldi0+ZGF0YS5jb250cm9sLmNoYW5u
ZWwsIGV2LT5kYXRhLmNvbnRyb2wudmFsdWUpOw0KKwkJYnJlYWs7DQorCWNh
c2UgU05EX1NFUV9FVkVOVF9QSVRDSEJFTkQ6DQorCQlwcmludGYoIkNoYW5u
ZWwgJTJkOiBQaXRjaGJlbmRlciAgIDogJTVkXG4iLCANCisJCQlldi0+ZGF0
YS5jb250cm9sLmNoYW5uZWwsIGV2LT5kYXRhLmNvbnRyb2wudmFsdWUpOw0K
KwkJYnJlYWs7DQorCWNhc2UgU05EX1NFUV9FVkVOVF9OT1RFT046DQorCQlw
cmludGYoIkNoYW5uZWwgJTJkOiBOb3RlIE9uIGV2ZW50IDogJTVkXG4iLA0K
KwkJCWV2LT5kYXRhLmNvbnRyb2wuY2hhbm5lbCwgZXYtPmRhdGEubm90ZS5u
b3RlKTsNCisJCWJyZWFrOyAgICAgICAgDQorCWNhc2UgU05EX1NFUV9FVkVO
VF9OT1RFT0ZGOiANCisJCXByaW50ZigiQ2hhbm5lbCAlMmQ6IE5vdGUgT2Zm
IGV2ZW50OiAlNWRcbiIsICAgICAgICAgDQorCQkJZXYtPmRhdGEuY29udHJv
bC5jaGFubmVsLCBldi0+ZGF0YS5ub3RlLm5vdGUpOyAgICAgICAgICAgDQor
CQlicmVhazsgICAgICAgIA0KKwl9DQorfQ0KKw0KIC8qDQogICogY29weSBl
dmVudHMgZnJvbSBzZXF1ZW5jZXIgdG8gcG9ydChzKQ0KICAqLw0KQEAgLTUx
Nyw2ICs1NDksOCBAQA0KIAkJCWJ1ZiA9IGdldF93cml0ZWJ1ZihzaXplb2Yo
c25kX3NlcV9ldmVudF90KSk7DQogCQkJbWVtY3B5KGJ1ZiwgZXYsIHNpemVv
ZihzbmRfc2VxX2V2ZW50X3QpKTsNCiAJCX0NCisJCWlmIChpbmZvKQ0KKwkJ
CXByaW50X2V2ZW50KGV2KTsNCiAJCXNuZF9zZXFfZnJlZV9ldmVudChldik7
DQogCX0NCiAJZmx1c2hfd3JpdGVidWYoKTsNCkBAIC01NDMsOCArNTc3LDE0
IEBADQogDQogCXdoaWxlIChjb3VudCA+IDApIHsNCiAJCWV2ID0gKHNuZF9z
ZXFfZXZlbnRfdCopYnVmOw0KLQkJYnVmICs9IHNpemVvZihzbmRfc2VxX2V2
ZW50X3QpOw0KLQkJY291bnQgLT0gc2l6ZW9mKHNuZF9zZXFfZXZlbnRfdCk7
DQorCQlpZiAoc2l6ZW9mKHNpemVfdCkgPT0gNCkgew0KKwkJCWJ1ZiArPSBz
aXplb2Yoc25kX3NlcV9ldmVudF90KTsNCisJCQljb3VudCAtPSBzaXplb2Yo
c25kX3NlcV9ldmVudF90KTsNCisJCX0gZWxzZSB7DQorCQkJYnVmICs9IDI4
OyAgIC8vIEhhY2sgYWxhcm06IHNpemUgZGlmZmVycyBiZWNhdXMgb2YNCisJ
CQljb3VudCAtPSAyODsgLy8gc2l6ZV90IGFuZCB2b2lkKiB1c2VkIGluIHNl
cV9ldl9leHQNCisJCX0NCisJCS8vIHRoaXMgd29ya3Mgb25seSB3aXRoIDY0
LWJpdCBiaWdlbmRpYW4gaWYgZXh0LmxlbiBpcyBpbnQ6DQogCQlpZiAoc25k
X3NlcV9ldl9pc192YXJpYWJsZShldikgJiYgZXYtPmRhdGEuZXh0LmxlbiA+
IDApIHsNCiAJCQlldi0+ZGF0YS5leHQucHRyID0gYnVmOw0KIAkJCWJ1ZiAr
PSBldi0+ZGF0YS5leHQubGVuOw0KQEAgLTU1Myw2ICs1OTMsOCBAQA0KIAkJ
c25kX3NlcV9ldl9zZXRfZGlyZWN0KGV2KTsNCiAJCXNuZF9zZXFfZXZfc2V0
X3NvdXJjZShldiwgc2VxX3BvcnQpOw0KIAkJc25kX3NlcV9ldl9zZXRfc3Vi
cyhldik7DQorCQlpZiAoaW5mbykNCisJCQlwcmludF9ldmVudChldik7DQog
CQlzbmRfc2VxX2V2ZW50X291dHB1dChoYW5kbGUsIGV2KTsNCiAJfQ0KIA0K

--168427776-894725621-1016758401=:18527--

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
