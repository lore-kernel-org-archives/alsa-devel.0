From: Dan Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: ac97: Add HP Compaq dc5100 SFF(PT003AW)
 to Headphone Jack Sense whitelist
Date: Sun, 14 Aug 2011 22:53:29 -0400
Message-ID: <CABJmPLk8owH7ifvpJb9YiqijxQxz1hA3pWSzKWJYqL20XFdTXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636e0ba023031e304aa825e46
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E54712441A
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 04:53:30 +0200 (CEST)
Received: by gyd8 with SMTP id 8so1133865gyd.38
	for <alsa-devel@alsa-project.org>; Sun, 14 Aug 2011 19:53:30 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--001636e0ba023031e304aa825e46
Content-Type: text/plain; charset=UTF-8

Hi,

Attached please find a patch against sound-2.6 master HEAD fixing
inaudible audio in the bug reporter's system by unmuting 'Headphone
Jack Sense'. To make it permanent, his PCI SSID is added to the
whitelist. Please consider applying.

Cheers,
-Dan

--001636e0ba023031e304aa825e46
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-ac97-Add-HP-Compaq-dc5100-SFF-PT003AW-to-Headph.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-ac97-Add-HP-Compaq-dc5100-SFF-PT003AW-to-Headph.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_grculsur0

RnJvbSBlZTJhY2ZiMTk3YWM2MzBjYjY4ZTgwZDMwNGI3OGQyNTM2NDljNTViIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFN1biwgMTQgQXVnIDIwMTEgMjI6NDM6MDEgLTA0MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBhYzk3OiBBZGQgSFAgQ29tcGFxIGRjNTEwMCBTRkYoUFQwMDNBVykgdG8gSGVhZHBob25lCiBK
YWNrIFNlbnNlIHdoaXRlbGlzdAoKQnVnTGluazogaHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5uZXQv
YnVncy84MjYwODEKClRoZSBvcmlnaW5hbCByZXBvcnRlciBuZWVkcyAnSGVhZHBob25lIEphY2sg
U2Vuc2UnIGVuYWJsZWQgdG8gaGF2ZQphdWRpYmxlIGF1ZGlvLCBzbyBhZGQgaGlzIFBDSSBTU0lE
IHRvIHRoZSB3aGl0ZWxpc3QuCgpSZXBvcnRlZC1hbmQtdGVzdGVkLWJ5OiBNdWhhbW1hZCBLaHVy
cmFtIEtoYW4KQ2M6IDxzdGFibGVAa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTogRGFuaWVsIFQg
Q2hlbiA8Y3JpbXN1bkB1YnVudHUuY29tPgotLS0KIHNvdW5kL3BjaS9hYzk3L2FjOTdfcGF0Y2gu
YyB8ICAgIDEgKwogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2FjOTcvYWM5N19wYXRjaC5jIGIvc291bmQvcGNp
L2FjOTcvYWM5N19wYXRjaC5jCmluZGV4IDIwMGM5YTEuLmE4NzJkMGEgMTAwNjQ0Ci0tLSBhL3Nv
dW5kL3BjaS9hYzk3L2FjOTdfcGF0Y2guYworKysgYi9zb3VuZC9wY2kvYWM5Ny9hYzk3X3BhdGNo
LmMKQEAgLTE5MDksNiArMTkwOSw3IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgYWQxOTgxX2phY2tz
X3doaXRlbGlzdFtdID0gewogCTB4MTAzYzA5NDQsIC8qIEhQIG5jNjIyMCAqLwogCTB4MTAzYzA5
MzQsIC8qIEhQIG5jODIyMCAqLwogCTB4MTAzYzAwNmQsIC8qIEhQIG54OTEwNSAqLworCTB4MTAz
YzMwMGQsIC8qIEhQIENvbXBhcSBkYzUxMDAgU0ZGKFBUMDAzQVcpICovCiAJMHgxNzM0MDA4OCwg
LyogRlNDIFNjZW5pYy1XICovCiAJMCAvKiBlbmQgKi8KIH07Ci0tIAoxLjcuNS40Cgo=
--001636e0ba023031e304aa825e46
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--001636e0ba023031e304aa825e46--
