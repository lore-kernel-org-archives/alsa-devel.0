From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH] ALSA: au88x0 - Remove unused "Master Mono"
 Playback Volume and Playback Switch of ac97 codec
Date: Tue, 5 Jun 2012 13:57:15 +0800
Message-ID: <CAN8cciaka89XAxgpg=5f_XrSmTvKgznDAZB1UH-2WshsWnmkdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6d7e4e795425e04c1b352e1
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C3F1104235
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 07:57:16 +0200 (CEST)
Received: by wibhr14 with SMTP id hr14so2758408wib.2
	for <alsa-devel@alsa-project.org>; Mon, 04 Jun 2012 22:57:15 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Takashi Iwai\" tiwai@suse.de \"ALSA Development Mailing List" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--0016e6d7e4e795425e04c1b352e1
Content-Type: text/plain; charset=UTF-8

Remove "Master Mono Playback Volume" and "Master Mono Playback Switch"
of ac97 mixer since au88x0 does no use "Master Mono Pin" of AC97 codec
even au88x0 support mono playback

--0016e6d7e4e795425e04c1b352e1
Content-Type: application/octet-stream;
	name="0001-au88x0-Remove-unused-Master-Mono-Playback-Volume-and.patch"
Content-Disposition: attachment;
	filename="0001-au88x0-Remove-unused-Master-Mono-Playback-Volume-and.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h32jyn5s0

RnJvbSAyYTE3NzY1NTZjMDdjNTUyMzVlOWY4NDhiZThmYzJmNGQ2MTA2NGFiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiByYXltb25kIDxyYXltb25kQHA1YnYuKG5vbmUpPgpEYXRlOiBN
b24sIDQgSnVuIDIwMTIgMTQ6NTk6NTUgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNBOiBhdTg4
eDAgLSBSZW1vdmUgdW51c2VkICJNYXN0ZXIgTW9ubyIgUGxheWJhY2sKIFZvbHVtZSBhbmQgUGxh
eWJhY2sgU3dpdGNoIG9mIGFjOTcgY29kZWMKClJlbW92ZSAiTWFzdGVyIE1vbm8gUGxheWJhY2sg
Vm9sdW1lIiBhbmQgIk1hc3RlciBNb25vIFBsYXliYWNrIFN3aXRjaCIgb2YgYWM5NyBtaXhlciBz
aW5jZSBhdTg4eDAgZG9lcyBubyB1c2UgIk1hc3RlciBNb25vIFBpbiIgb2YgQUM5NyBjb2RlYyBl
dmVuIGF1ODh4MCBzdXBwb3J0IG1vbm8gcGxheWJhY2sKClNpZ25lZC1vZmYtYnk6IFJheW1vbmQg
WWF1IDxzdXBlcnF1YWQudm9ydGV4MkBnbWFpbC5jb20+CgpkaWZmIC0tZ2l0IGEvc291bmQvcGNp
L2F1ODh4MC9hdTg4eDBfbWl4ZXIuYyBiL3NvdW5kL3BjaS9hdTg4eDAvYXU4OHgwX21peGVyLmMK
aW5kZXggNTU3Yzc4Mi4uZmExM2VmYiAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2F1ODh4MC9hdTg4
eDBfbWl4ZXIuYworKysgYi9zb3VuZC9wY2kvYXU4OHgwL2F1ODh4MF9taXhlci5jCkBAIC0xMCw2
ICsxMCwxNSBAQAogI2luY2x1ZGUgPHNvdW5kL2NvcmUuaD4KICNpbmNsdWRlICJhdTg4eDAuaCIK
IAorc3RhdGljIGludCByZW1vdmVfY3RsKHN0cnVjdCBzbmRfY2FyZCAqY2FyZCwgY29uc3QgY2hh
ciAqbmFtZSkKK3sKKwlzdHJ1Y3Qgc25kX2N0bF9lbGVtX2lkIGlkOworCW1lbXNldCgmaWQsIDAs
IHNpemVvZihpZCkpOworCXN0cmNweShpZC5uYW1lLCBuYW1lKTsKKwlpZC5pZmFjZSA9IFNORFJW
X0NUTF9FTEVNX0lGQUNFX01JWEVSOworCXJldHVybiBzbmRfY3RsX3JlbW92ZV9pZChjYXJkLCAm
aWQpOworfQorCiBzdGF0aWMgaW50IF9fZGV2aW5pdCBzbmRfdm9ydGV4X21peGVyKHZvcnRleF90
ICogdm9ydGV4KQogewogCXN0cnVjdCBzbmRfYWM5N19idXMgKnBidXM7CkBAIC0yOCw1ICszNyw3
IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IHNuZF92b3J0ZXhfbWl4ZXIodm9ydGV4X3QgKiB2b3J0
ZXgpCiAJYWM5Ny5zY2FwcyA9IEFDOTdfU0NBUF9OT19TUERJRjsKIAllcnIgPSBzbmRfYWM5N19t
aXhlcihwYnVzLCAmYWM5NywgJnZvcnRleC0+Y29kZWMpOwogCXZvcnRleC0+aXNxdWFkID0gKCh2
b3J0ZXgtPmNvZGVjID09IE5VTEwpID8gIDAgOiAodm9ydGV4LT5jb2RlYy0+ZXh0X2lkJjB4ODAp
KTsKKwlyZW1vdmVfY3RsKHZvcnRleC0+Y2FyZCwgIk1hc3RlciBNb25vIFBsYXliYWNrIFZvbHVt
ZSIpOworCXJlbW92ZV9jdGwodm9ydGV4LT5jYXJkLCAiTWFzdGVyIE1vbm8gUGxheWJhY2sgU3dp
dGNoIik7CiAJcmV0dXJuIGVycjsKIH0KLS0gCjEuNy45LjUKCg==
--0016e6d7e4e795425e04c1b352e1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0016e6d7e4e795425e04c1b352e1--
