From: Dave Dillow <dave@thedillows.org>
Subject: speaker-test stalls
Date: Sat, 08 Dec 2007 15:58:40 -0500
Message-ID: <1197147520.3588.38.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Y3NdjqNqaNbpFKcBY81e"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.knology.net (smtp.knology.net [24.214.63.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 7296A103899
	for <alsa-devel@alsa-project.org>; Sat,  8 Dec 2007 21:58:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Fernando Papa <fpapa@adinet.com.uy>
List-Id: alsa-devel@alsa-project.org


--=-Y3NdjqNqaNbpFKcBY81e
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

While working with Fernando to get the sis7019 driver working in his
buildroot setup, we kept running into a lockup of the PCM stream when
using speaker-test. aplay was fine, as was other I finally tracked it
down to a combination of uclibc not doing block reads, which led to
XRUNs, and what I thought was issue in snd_pcm_lib_write1() when trying
to fill up the tail of the PCM buffer with a large write, when there was
an intervening small write.

As it turns out, the lockup problem may simply be in speaker-write's
sw_params settings -- it calls snd_pcm_sw_params_set_avail_min() to set
the minium write to the period size, and
snd_pcm_sw_params_set_start_threshold() to start once the buffer has
been filled. This doesn't account for odd wave file lengths and XRUNs.

The problem arises when the wave data is not a multiple of the period
size, and you get an XRUN when there is less than buffer_size samples
remaining in the current loop. 

So for example, period size is 8192, buffer is 32768, and the wave file
has 71042 samples (Front_Left.wav for speaker-test).

speaker-test will break that into 8 writes of 8192 samples, and one of
5506.

If you get a XRUN in the last 32k of the file, the PCM will be stopped,
and prepared, and we'll start loading data into again. Because we have a
tail of 5506 samples, we get to the point where the available space is
less than our minimum, and then snd_pcm_lib_write1() will wait forever
for the available space to be >= runtime->avail_min, even though the
channel is stopped.

[snip from a trace, patch to pcm_lib.c attached]
writei size 8192 avail 32768 min 8192 xfer 1 state 2
writei size 8192 avail 24576 min 8192 xfer 1 state 2
writei size 5506 avail 16384 min 8192 xfer 1 state 2
writei size 8192 avail 10878 min 8192 xfer 1 state 2
writei size 8192 avail 2686 min 8192 xfer 1 state 2
writei loop avail 2686 min 8192
writei loop avail 2686 min 8192
writei loop avail 2686 min 8192
writei loop avail 2686 min 8192


Assuming that this is desired behavior from the kernel side, then I see
three options to fix this in speaker-test:
1) snd_pcm_sw_params_set_avail_min() to 1 sample
2) snd_pcm_sw_params_set_start_threshold() to start when (nperiods - 1)
are ready (or be even more aggressive)
3) call snd_pcm_drain() at the end of each loop to clear out the buffer.
This won't help if the wave file has fewer samples than the buffer size.

Options 1 or 2 seem to be best.

Thoughts?

Dave


--=-Y3NdjqNqaNbpFKcBY81e
Content-Disposition: attachment; filename=pcm_lib_debug.patch
Content-Type: text/x-patch; name=pcm_lib_debug.patch; charset=UTF-8
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3NvdW5kL2NvcmUvcGNtX2xpYi5jIGIvc291bmQvY29yZS9wY21fbGliLmMN
CmluZGV4IDgwNmYxZmIuLmRlYWM1ZTggMTAwNjQ0DQotLS0gYS9zb3VuZC9jb3JlL3BjbV9saWIu
Yw0KKysrIGIvc291bmQvY29yZS9wY21fbGliLmMNCkBAIC0xNzcsNiArMTc3LDggQEAgc3RhdGlj
IGlubGluZSBpbnQgc25kX3BjbV91cGRhdGVfaHdfcHRyX3Bvc3Qoc3RydWN0IHNuZF9wY21fc3Vi
c3RyZWFtICpzdWJzdHJlYW0NCiAJCQl4cnVuKHN1YnN0cmVhbSk7DQogCQlyZXR1cm4gLUVQSVBF
Ow0KIAl9DQorCXByaW50ayhLRVJOX0RFQlVHICJhdmFpbCAlbHUgbWF4ICVsdSBtaW4gJWx1XG4i
LCBhdmFpbCwgcnVudGltZS0+YXZhaWxfbWF4LA0KKwkJCQlydW50aW1lLT5jb250cm9sLT5hdmFp
bF9taW4pOw0KIAlpZiAoYXZhaWwgPj0gcnVudGltZS0+Y29udHJvbC0+YXZhaWxfbWluKQ0KIAkJ
d2FrZV91cCgmcnVudGltZS0+c2xlZXApOw0KIAlyZXR1cm4gMDsNCkBAIC0xNjUxLDYgKzE2NTMs
MTAgQEAgc3RhdGljIHNuZF9wY21fc2ZyYW1lc190IHNuZF9wY21fbGliX3dyaXRlMShzdHJ1Y3Qg
c25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwNCiAJCWlmIChydW50aW1lLT5zbGVlcF9taW4g
PT0gMCAmJiBydW50aW1lLT5zdGF0dXMtPnN0YXRlID09IFNORFJWX1BDTV9TVEFURV9SVU5OSU5H
KQ0KIAkJCXNuZF9wY21fdXBkYXRlX2h3X3B0cihzdWJzdHJlYW0pOw0KIAkJYXZhaWwgPSBzbmRf
cGNtX3BsYXliYWNrX2F2YWlsKHJ1bnRpbWUpOw0KKwkJcHJpbnRrKEtFUk5fREVCVUcgIndyaXRl
aSBzaXplICVsdSBhdmFpbCAlbHUgbWluICVsdSB4ZmVyICVsdSBzdGF0ZSAlZFxuIiwNCisJCQkJ
c2l6ZSwgYXZhaWwsIHJ1bnRpbWUtPmNvbnRyb2wtPmF2YWlsX21pbiwgcnVudGltZS0+eGZlcl9h
bGlnbiwNCisJCQkJcnVudGltZS0+c3RhdHVzLT5zdGF0ZSk7DQorDQogCQlpZiAoKChhdmFpbCA8
IHJ1bnRpbWUtPmNvbnRyb2wtPmF2YWlsX21pbiAmJiBzaXplID4gYXZhaWwpIHx8DQogCQkgICAo
c2l6ZSA+PSBydW50aW1lLT54ZmVyX2FsaWduICYmIGF2YWlsIDwgcnVudGltZS0+eGZlcl9hbGln
bikpKSB7DQogCQkJd2FpdF9xdWV1ZV90IHdhaXQ7DQpAQCAtMTY5NSw2ICsxNzAxLDggQEAgc3Rh
dGljIHNuZF9wY21fc2ZyYW1lc190IHNuZF9wY21fbGliX3dyaXRlMShzdHJ1Y3Qgc25kX3BjbV9z
dWJzdHJlYW0gKnN1YnN0cmVhbSwNCiAJCQkJCWJyZWFrOw0KIAkJCQl9DQogCQkJCWF2YWlsID0g
c25kX3BjbV9wbGF5YmFja19hdmFpbChydW50aW1lKTsNCisJCQkJcHJpbnRrKEtFUk5fREVCVUcg
IndyaXRlaSBsb29wIGF2YWlsICVsdSBtaW4gJWx1XG4iLCBhdmFpbCwNCisJCQkJCQlydW50aW1l
LT5jb250cm9sLT5hdmFpbF9taW4pOw0KIAkJCQlpZiAoYXZhaWwgPj0gcnVudGltZS0+Y29udHJv
bC0+YXZhaWxfbWluKSB7DQogCQkJCQlzdGF0ZSA9IFJFQURZOw0KIAkJCQkJYnJlYWs7DQo=


--=-Y3NdjqNqaNbpFKcBY81e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-Y3NdjqNqaNbpFKcBY81e--
