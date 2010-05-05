From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use olpc-xo-1_5 quirk for Toshiba
	Satellite P500-PSPGSC-01800T
Date: Tue, 4 May 2010 22:13:27 -0400
Message-ID: <g2p604760771005041913zb43dbbfep7b461d916f08d6c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00504502cc4827ff330485cf5f53
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C75C32444A
	for <alsa-devel@alsa-project.org>;
	Wed,  5 May 2010 04:13:29 +0200 (CEST)
Received: by pxi13 with SMTP id 13so1928821pxi.38
	for <alsa-devel@alsa-project.org>; Tue, 04 May 2010 19:13:28 -0700 (PDT)
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

--00504502cc4827ff330485cf5f53
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is another patch against sound-2.6 master HEAD (based on the
previous patch from yesterday) that makes the OR's
machine have audible sound by default. Please apply.

Best,
-Dan

--00504502cc4827ff330485cf5f53
Content-Type: text/x-diff; charset=US-ASCII;
	name="0002-ALSA-hda-Use-olpc-xo-1_5-quirk-for-Toshiba-Satellite.patch"
Content-Disposition: attachment;
	filename="0002-ALSA-hda-Use-olpc-xo-1_5-quirk-for-Toshiba-Satellite.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g8tihwqo0

RnJvbSAzM2Q2M2Y3ZTY5MTE1MDNhZmEwMDgwZDU2ZTk3NDBkNDBjZjIzNjRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFR1ZSwgNCBNYXkgMjAxMCAyMjowNzo1OCAtMDQwMApTdWJqZWN0OiBbUEFUQ0ggMi8yXSBB
TFNBOiBoZGE6IFVzZSBvbHBjLXhvLTFfNSBxdWlyayBmb3IgVG9zaGliYSBTYXRlbGxpdGUgUDUw
MC1QU1BHU0MtMDE4MDBUCgpCdWdMaW5rOiBodHRwczovL2xhdW5jaHBhZC5uZXQvYnVncy81NDky
NjcKClRoZSBPUiB2ZXJpZmllZCB0aGF0IHVzaW5nIHRoZSBvbHBjLXhvLTFfNSBtb2RlbCBxdWly
ayBhbGxvd3MgdGhlCmhlYWRwaG9uZXMgdG8gYmUgYXVkaWJsZSB3aGVuIGluc2VydGVkIGludG8g
dGhlIGphY2suIENhcHR1cmUgd2FzCmFsc28gdmVyaWZpZWQgdG8gd29yayBjb3JyZWN0bHkuCgpS
ZXBvcnRlZC1ieTogUmljaGFyZCBHYWduZQpUZXN0ZWQtYnk6IFJpY2hhcmQgR2FnbmUKQ2M6IDxz
dGFibGVAa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTogRGFuaWVsIFQgQ2hlbiA8Y3JpbXN1bkB1
YnVudHUuY29tPgotLS0KIHNvdW5kL3BjaS9oZGEvcGF0Y2hfY29uZXhhbnQuYyB8ICAgIDEgKwog
MSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvc291bmQvcGNpL2hkYS9wYXRjaF9jb25leGFudC5jIGIvc291bmQvcGNpL2hkYS9wYXRj
aF9jb25leGFudC5jCmluZGV4IGZiNDJjMmEuLjNhYzk3NmIgMTAwNjQ0Ci0tLSBhL3NvdW5kL3Bj
aS9oZGEvcGF0Y2hfY29uZXhhbnQuYworKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX2NvbmV4YW50
LmMKQEAgLTI5NjcsNiArMjk2Nyw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc25kX3BjaV9xdWlyayBjeHQ1
MDY2X2NmZ190YmxbXSA9IHsKIAkJICAgICAgQ1hUNTA2Nl9ERUxMX0xBUFRPUCksCiAJU05EX1BD
SV9RVUlSSygweDE1MmQsIDB4MDgzMywgIk9MUEMgWE8tMS41IiwgQ1hUNTA2Nl9PTFBDX1hPXzFf
NSksCiAJU05EX1BDSV9RVUlSSygweDEwMjgsIDB4MDQwMiwgIkRlbGwgVm9zdHJvIiwgQ1hUNTA2
Nl9ERUxMX1ZPU1RPKSwKKwlTTkRfUENJX1FVSVJLKDB4MTE3OSwgMHhmZjUwLCAiVG9zaGliYSBT
YXRlbGxpdGUgUDUwMC1QU1BHU0MtMDE4MDBUIiwgQ1hUNTA2Nl9PTFBDX1hPXzFfNSksCiAJU05E
X1BDSV9RVUlSSygweDExNzksIDB4ZmZlMCwgIlRvc2hpYmEgU2F0ZWxsaXRlIFBybyBUMTMwLTE1
RiIsIENYVDUwNjZfT0xQQ19YT18xXzUpLAogCVNORF9QQ0lfUVVJUksoMHgxN2FhLCAweDNhMGQs
ICJpZGVhcGFkIiwgQ1hUNTA2Nl9JREVBUEFEKSwKIAlTTkRfUENJX1FVSVJLKDB4MTdhYSwgMHgy
MTVlLCAiTGVub3ZvIFRoaW5rcGFkIiwgQ1hUNTA2Nl9USElOS1BBRCksCi0tIAoxLjcuMC40Cgo=
--00504502cc4827ff330485cf5f53
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--00504502cc4827ff330485cf5f53--
