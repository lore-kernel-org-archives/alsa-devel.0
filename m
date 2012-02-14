From: Dan Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: intel8x0: Fix default inaudible sound on
	Gateway M520
Date: Mon, 13 Feb 2012 23:44:22 -0500
Message-ID: <CABJmPLmOQ_tPnxqWC8BSyExes1eo+gD62rsHjyA5F9BgLoFTEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7b33da98aebcbf04b8e53fd0
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C869A103D08
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2012 05:44:25 +0100 (CET)
Received: by dady9 with SMTP id y9so5455389dad.38
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 20:44:22 -0800 (PST)
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

--047d7b33da98aebcbf04b8e53fd0
Content-Type: text/plain; charset=UTF-8

Hi Takashi,

Attached please find a patch against current sound.git head that
resolves a user's default inaudible sound on the Gateway M520. It's
applicable to stable kernel trees, too. Thanks for considering the
patch. Cheers.

-Dan

--047d7b33da98aebcbf04b8e53fd0
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-intel8x0-Fix-default-inaudible-sound-on-Gateway.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-intel8x0-Fix-default-inaudible-sound-on-Gateway.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gymg3wi40

RnJvbSA1YmI0MzRiZDQ2OWNjMDAxNjZlZTc3Mzg2ZDkzNjA5M2ZlN2Y2MTUzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IE1vbiwgMTMgRmViIDIwMTIgMjM6MzQ6MjEgLTA1MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBpbnRlbDh4MDogRml4IGRlZmF1bHQgaW5hdWRpYmxlIHNvdW5kIG9uIEdhdGV3YXkgTTUyMAoK
QnVnTGluazogaHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5uZXQvYnVncy85MzA4NDIKClRoZSByZXBv
cnRlciBzdGF0ZXMgdGhhdCBhdWRpbyBpcyBpbmF1ZGlibGUgYnkgZGVmYXVsdCB3aXRob3V0IG11
dGluZwonRXh0ZXJuYWwgQW1wbGlmaWVyJy4gQWRkIGEgcXVpcmsgdG8gaGFuZGxlIGhpcyBTU0lE
IHNvIHRoYXQgY2hhbmdpbmcKdGhlIGNvbnRyb2wgaXMgbm90IG5lY2Vzc2FyeS4KClJlcG9ydGVk
LWFuZC10ZXN0ZWQtYnk6IEJlbmphbWluIENhcmxzb24gPGVsZGVyYnViYmEwODEwQGdtYWlsLmNv
bT4KQ2M6IDxzdGFibGVAa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTogRGFuaWVsIFQgQ2hlbiA8
Y3JpbXN1bkB1YnVudHUuY29tPgotLS0KIHNvdW5kL3BjaS9pbnRlbDh4MC5jIHwgICAgNiArKysr
KysKIDEgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL3NvdW5kL3BjaS9pbnRlbDh4MC5jIGIvc291bmQvcGNpL2ludGVsOHgwLmMKaW5k
ZXggOWYzYjAxYi4uZTBhNDI2MyAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2ludGVsOHgwLmMKKysr
IGIvc291bmQvcGNpL2ludGVsOHgwLmMKQEAgLTIxMDIsNiArMjEwMiwxMiBAQCBzdGF0aWMgc3Ry
dWN0IGFjOTdfcXVpcmsgYWM5N19xdWlya3NbXSBfX2RldmluaXRkYXRhID0gewogCX0sCiAJewog
CQkuc3VidmVuZG9yID0gMHgxNjFmLAorCQkuc3ViZGV2aWNlID0gMHgyMDJmLAorCQkubmFtZSA9
ICJHYXRld2F5IE01MjAiLAorCQkudHlwZSA9IEFDOTdfVFVORV9JTlZfRUFQRAorCX0sCisJewor
CQkuc3VidmVuZG9yID0gMHgxNjFmLAogCQkuc3ViZGV2aWNlID0gMHgyMDNhLAogCQkubmFtZSA9
ICJHYXRld2F5IDQ1MjVHWiIsCQkvKiBBRDE5ODFCICovCiAJCS50eXBlID0gQUM5N19UVU5FX0lO
Vl9FQVBECi0tIAoxLjcuOQoK
--047d7b33da98aebcbf04b8e53fd0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--047d7b33da98aebcbf04b8e53fd0--
