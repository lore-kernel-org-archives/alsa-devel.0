From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Add documentation for codec specific mixer controls of
	Analog codec
Date: Tue, 4 Oct 2011 10:09:37 +0800
Message-ID: <CAN8ccib4qVuphGG7UzkfyzJFth=rC26J+dUih1zkD8o-N790Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174761c65c963304ae6f95e1
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id C04AD24337
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 04:09:37 +0200 (CEST)
Received: by bkbzu17 with SMTP id zu17so48791bkb.38
	for <alsa-devel@alsa-project.org>; Mon, 03 Oct 2011 19:09:37 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0015174761c65c963304ae6f95e1
Content-Type: text/plain; charset=ISO-8859-1

Analog codecs
--------------

 * Channel Mode
  This is an enum control to change the surround-channel setup,
  appears only when the surround channels are available.
  It gives the number of channels to be used, "2ch", "4ch" and "6ch".
  According to the configuration, this also controls the
  jack-retasking of multi-I/O jacks.

* Independent HP
  When this enum control is enabled, the headphone output is routed
  from an individual stream (the third PCM such as hw:0,2) instead of
  the primary stream.

--0015174761c65c963304ae6f95e1
Content-Type: application/octet-stream;
	name="0001-Add-documentation-for-codec-specific-mixer-controls.patch"
Content-Disposition: attachment;
	filename="0001-Add-documentation-for-codec-specific-mixer-controls.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gtc92f280

RnJvbSBlZjg3MTNkNjU5YmViYWY4ZjEzNjJlMGRlMTE3Y2I4ZGE1NWU5ZjM2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBUdWUsIDQgT2N0IDIwMTEgMDk6NDY6NDQgKzA4MDAKU3ViamVjdDogW1BBVENI
IC0gRG9jdW1lbnRhdGlvbiAxLzFdIEFkZCBkb2N1bWVudGF0aW9uIGZvciBjb2RlYyBzcGVjaWZp
YyBtaXhlciBjb250cm9scyBvZiBBbmFsb2cgY29kZWNzCgoqIENoYW5uZWwgTW9kZQogIFRoaXMg
aXMgYW4gZW51bSBjb250cm9sIHRvIGNoYW5nZSB0aGUgc3Vycm91bmQtY2hhbm5lbCBzZXR1cCwK
ICBhcHBlYXJzIG9ubHkgd2hlbiB0aGUgc3Vycm91bmQgY2hhbm5lbHMgYXJlIGF2YWlsYWJsZS4K
ICBJdCBnaXZlcyB0aGUgbnVtYmVyIG9mIGNoYW5uZWxzIHRvIGJlIHVzZWQsICIyY2giLCAiNGNo
IiBhYmQgIjZjaCIuCiAgQWNjb3JkaW5nIHRvIHRoZSBjb25maWd1cmF0aW9uLCB0aGlzIGFsc28g
Y29udHJvbHMgdGhlCiAgamFjay1yZXRhc2tpbmcgb2YgbXVsdGktSS9PIGphY2tzLgoKKiBJbmRl
cGVuZGVudCBIUAogIFdoZW4gdGhpcyBlbnVtIGNvbnRyb2wgaXMgZW5hYmxlZCwgdGhlIGhlYWRw
aG9uZSBvdXRwdXQgaXMgcm91dGVkCiAgZnJvbSBhbiBpbmRpdmlkdWFsIHN0cmVhbSAodGhlIHRo
aXJkIFBDTSBzdWNoIGFzIGh3OjAsMikgaW5zdGVhZCBvZgogIHRoZSBwcmltYXJ5IHN0cmVhbS4K
ClNpZ25lZC1vZmYtYnk6IFJheW1vbmQgWWF1IDxzdXBlcnF1YWQudm9ydGV4MkBnbWFpbC5jb20+
CgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9zb3VuZC9hbHNhL0hELUF1ZGlvLUNvbnRyb2xz
LnR4dCBiL0RvY3VtZW50YXRpb24vc291bmQvYWxzYS9IRC1BdWRpby1Db250cm9scy50eHQKaW5k
ZXggMTQ4MjAzNS4uY2VmYTg4MSAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9zb3VuZC9hbHNh
L0hELUF1ZGlvLUNvbnRyb2xzLnR4dAorKysgYi9Eb2N1bWVudGF0aW9uL3NvdW5kL2Fsc2EvSEQt
QXVkaW8tQ29udHJvbHMudHh0CkBAIC05OCwzICs5OCwxOSBAQCBDb25leGFudCBjb2RlY3MKIAog
KiBBdXRvLU11dGUgTW9kZQogICBTZWUgUmVhdGVrIGNvZGVjcy4KKworCitBbmFsb2cgY29kZWNz
CistLS0tLS0tLS0tLS0tLQorCisqIENoYW5uZWwgTW9kZQorICBUaGlzIGlzIGFuIGVudW0gY29u
dHJvbCB0byBjaGFuZ2UgdGhlIHN1cnJvdW5kLWNoYW5uZWwgc2V0dXAsCisgIGFwcGVhcnMgb25s
eSB3aGVuIHRoZSBzdXJyb3VuZCBjaGFubmVscyBhcmUgYXZhaWxhYmxlLgorICBJdCBnaXZlcyB0
aGUgbnVtYmVyIG9mIGNoYW5uZWxzIHRvIGJlIHVzZWQsICIyY2giLCAiNGNoIiBhbmQgIjZjaCIu
CisgIEFjY29yZGluZyB0byB0aGUgY29uZmlndXJhdGlvbiwgdGhpcyBhbHNvIGNvbnRyb2xzIHRo
ZQorICBqYWNrLXJldGFza2luZyBvZiBtdWx0aS1JL08gamFja3MuCisKKyogSW5kZXBlbmRlbnQg
SFAKKyAgV2hlbiB0aGlzIGVudW0gY29udHJvbCBpcyBlbmFibGVkLCB0aGUgaGVhZHBob25lIG91
dHB1dCBpcyByb3V0ZWQKKyAgZnJvbSBhbiBpbmRpdmlkdWFsIHN0cmVhbSAodGhlIHRoaXJkIFBD
TSBzdWNoIGFzIGh3OjAsMikgaW5zdGVhZCBvZgorICB0aGUgcHJpbWFyeSBzdHJlYW0uCi0tIAox
LjYuMC42Cgo=
--0015174761c65c963304ae6f95e1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0015174761c65c963304ae6f95e1--
