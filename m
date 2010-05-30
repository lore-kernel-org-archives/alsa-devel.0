From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: [PATCH] ALSA: hda: Use mbp31 quirk for an iMac
	model
Date: Sun, 30 May 2010 10:11:50 -0400
Message-ID: <AANLkTinGRbUdPAg7J097lpVt2pAmu6eAGOOsrnZI3uES@mail.gmail.com>
References: <AANLkTilBxctBVkkyQd1vexXn3JzLWofHPUL5a4IOjOx4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636e0ba034f3b3f0487d05284
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id C42C82456D
	for <alsa-devel@alsa-project.org>;
	Sun, 30 May 2010 16:11:51 +0200 (CEST)
Received: by pwj9 with SMTP id 9so1316620pwj.38
	for <alsa-devel@alsa-project.org>; Sun, 30 May 2010 07:11:50 -0700 (PDT)
In-Reply-To: <AANLkTilBxctBVkkyQd1vexXn3JzLWofHPUL5a4IOjOx4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, stable@kernel.org
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--001636e0ba034f3b3f0487d05284
Content-Type: text/plain; charset=UTF-8

On Sun, May 30, 2010 at 10:02 AM, Daniel Chen <seven.steps@gmail.com> wrote:
> Attached is a patch against sound-2.6 master enabling audible playback
> and capture for the original reporter's iMac. Please apply.

Oops, I just noticed that the description is imprecise. Please use
this patch instead, which correctly lists the model quirk used in the
description as mb31 (not mbp31). While the driver change is not
affected, I'd like the description to match the actual change.

Best,
-Dan

--001636e0ba034f3b3f0487d05284
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-hda-Use-mb31-quirk-for-an-iMac-model.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-mb31-quirk-for-an-iMac-model.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g9ty85d11

RnJvbSBmNmViZDA2ZThmZWY0MWFkYjk0YTZkZWI2ZDAyODRkMDI2MWNhYzY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFN1biwgMzAgTWF5IDIwMTAgMDk6NTU6MjMgLTA0MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IFVzZSBtYjMxIHF1aXJrIGZvciBhbiBpTWFjIG1vZGVsCgpCdWdMaW5rOiBodHRwczov
L2xhdW5jaHBhZC5uZXQvYnVncy81NDI1NTAKClN5bXB0b206IE9uIHRoZSByZXBvcnRlcidzIGlN
YWMsIGluIFVidW50dSAxMC4wNCBMVFMgbmVpdGhlciBwbGF5YmFjawpub3IgY2FwdHVyZSBhcHBl
YXIgYXVkaWJsZSBvdXQtb2YtdGhlLWJveC4KClRlc3QgY2FzZTogQm9vdCBmcm9tIGFuIFVidW50
dSAxMC4wNCBMVFMgbGl2ZSBjZCBvciBmcm9tIGFuIGluc3RhbGxlZApjb25maWd1cmF0aW9uIGFu
ZCBhdHRlbXB0IHRvIHBsYXkgb3IgY2FwdHVyZSBhdWRpby4KClJlc29sdXRpb246IFNwZWNpZnkg
dGhlIG1iMzEgcXVpcmsgZm9yIHRoaXMgbWFjaGluZSBpbiB0aGUgY29kZWMgU1NJRAp0YWJsZS4K
ClJlcG9ydGVkLWFuZC1UZXN0ZWQtQnk6IGYzYTk3CkNjOiA8c3RhYmxlQGtlcm5lbC5vcmc+ClNp
Z25lZC1vZmYtYnk6IERhbmllbCBUIENoZW4gPGNyaW1zdW5AdWJ1bnR1LmNvbT4KLS0tCiBzb3Vu
ZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYyB8ICAgIDEgKwogMSBmaWxlcyBjaGFuZ2VkLCAxIGlu
c2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9w
YXRjaF9yZWFsdGVrLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwppbmRleCAxN2Q0
NTQ4Li5kNzkyY2RkIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwor
KysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwpAQCAtOTQ3Niw2ICs5NDc2LDcgQEAg
c3RhdGljIHN0cnVjdCBzbmRfcGNpX3F1aXJrIGFsYzg4Ml9zc2lkX2NmZ190YmxbXSA9IHsKIAlT
TkRfUENJX1FVSVJLKDB4MTA2YiwgMHgxMDAwLCAiaU1hYyAyNCIsIEFMQzg4NV9JTUFDMjQpLAog
CVNORF9QQ0lfUVVJUksoMHgxMDZiLCAweDI4MDAsICJBcHBsZVRWIiwgQUxDODg1X0lNQUMyNCks
CiAJU05EX1BDSV9RVUlSSygweDEwNmIsIDB4MmMwMCwgIk1hY2Jvb2tQcm8gcmV2MyIsIEFMQzg4
NV9NQlAzKSwKKwlTTkRfUENJX1FVSVJLKDB4MTA2YiwgMHgzMDAwLCAiaU1hYyIsIEFMQzg4OUFf
TUIzMSksCiAJU05EX1BDSV9RVUlSSygweDEwNmIsIDB4MzYwMCwgIk1hY2Jvb2sgMywxIiwgQUxD
ODg5QV9NQjMxKSwKIAlTTkRfUENJX1FVSVJLKDB4MTA2YiwgMHgzODAwLCAiTWFjYm9va1BybyA0
LDEiLCBBTEM4ODVfTUJQMyksCiAJU05EX1BDSV9RVUlSSygweDEwNmIsIDB4M2UwMCwgImlNYWMg
MjQgQWx1bWludW0iLCBBTEM4ODVfSU1BQzI0KSwKLS0gCjEuNy4wLjQKCg==
--001636e0ba034f3b3f0487d05284
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636e0ba034f3b3f0487d05284--
