From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: [PATCH] Add quirk for HP Samba (ALC888)
Date: Thu, 12 Jul 2007 19:41:18 -0300
Message-ID: <5f52f6d70707121541l6e51325ayb8303b8f986a2cb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_21566_32779326.1184280078086"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 4846710384F
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jul 2007 00:41:19 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so368559mue
	for <alsa-devel@alsa-project.org>; Thu, 12 Jul 2007 15:41:18 -0700 (PDT)
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
Cc: Takashi Iwai <tiwai@suse.de>, lcapitulino@mandriva.com
List-Id: alsa-devel@alsa-project.org

------=_Part_21566_32779326.1184280078086
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

This patch fixes 5.1 surround output for the HP Samba using the same
quirk as the HP Lucknow. If HP machines are uniform in their wiring, I
think we should rename ALC888_HP_NETTLE to ALC888_6ST_HP and
ALC888_HP_LUCKNOW to ALC888_3ST_HP for generic HP 6stack and 3stack
configurations.

I'll probably receive more HP machines soon, so I'll see if this is the case.

Best regards,
Claudio

------=_Part_21566_32779326.1184280078086
Content-Type: text/x-diff;
	name=0011-ALSA-hda-codec-Add-quirk-for-HP-Samba.patch;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f41tpd11
Content-Disposition: attachment; filename="0011-ALSA-hda-codec-Add-quirk-for-HP-Samba.patch"

RnJvbSA5MDE3OGI0YzAxYzA5ODcyNTkxMGI5MGY3ODI0YzUzMGRiNmZjZWIxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDbGF1ZGlvIE1hdHN1b2thIDxjbWF0c3Vva2FAZ21haWwuY29t
PgpEYXRlOiBUaHUsIDEyIEp1bCAyMDA3IDE5OjM4OjA5IC0wMzAwClN1YmplY3Q6IFtQQVRDSF0g
W0FMU0FdIGhkYS1jb2RlYyAtIEFkZCBxdWlyayBmb3IgSFAgU2FtYmEKClRoaXMgcGF0Y2ggZml4
ZXMgNS4xIHN1cnJvdW5kIG91dHB1dCBmb3IgdGhlIEhQIFNhbWJhIHVzaW5nIHRoZSBzYW1lCnF1
aXJrIGFzIHRoZSBIUCBMdWNrbm93LiBJZiBIUCBtYWNoaW5lcyBhcmUgdW5pZm9ybSBpbiB0aGVp
ciB3aXJpbmcsCndlIHNob3VsZCByZW5hbWUgQUxDODg4X0hQX05FVFRMRSB0byBBTEM4ODhfNlNU
X0hQIGFuZCBBTEM4ODhfSFBfTFVDS05PVwp0byBBTEM4ODhfM1NUX0hQIGZvciBnZW5lcmljIEhQ
IDZzdGFjayBhbmQgM3N0YWNrIGNvbmZpZ3VyYXRpb25zLgoKU2lnbmVkLW9mZi1ieTogQ2xhdWRp
byBNYXRzdW9rYSA8Y21hdHN1b2thQGdtYWlsLmNvbT4KLS0tCiBzb3VuZC9wY2kvaGRhL3BhdGNo
X3JlYWx0ZWsuYyB8ICAgIDEgKwogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMg
Yi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwppbmRleCAyNjQ2MmM0Li4zMGU1ZjYyIDEw
MDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYworKysgYi9zb3VuZC9wY2kv
aGRhL3BhdGNoX3JlYWx0ZWsuYwpAQCAtNjU0MSw2ICs2NTQxLDcgQEAgc3RhdGljIHN0cnVjdCBz
bmRfcGNpX3F1aXJrIGFsYzg4M19jZmdfdGJsW10gPSB7CiAJU05EX1BDSV9RVUlSSygweDE3YWEs
IDB4MjA4NSwgIkxlbm92byBOQjA3NjMiLCBBTEM4ODNfTEVOT1ZPX05CMDc2MyksCiAJU05EX1BD
SV9RVUlSSygweDEwM2MsIDB4MmE2MSwgIkhQIE5ldHRsZSIsIEFMQzg4OF9IUF9ORVRUTEUpLAog
CVNORF9QQ0lfUVVJUksoMHgxMDNjLCAweDJhNjAsICJIUCBMdWNrbm93IiwgQUxDODg4X0hQX0xV
Q0tOT1cpLAorCVNORF9QQ0lfUVVJUksoMHgxMDNjLCAweDJhNGYsICJIUCBTYW1iYSIsIEFMQzg4
OF9IUF9MVUNLTk9XKSwKIAlTTkRfUENJX1FVSVJLKDB4MTdjMCwgMHg0MDcxLCAiTUVESU9OIE1E
MiIsIEFMQzg4M19NRURJT05fTUQyKSwKIAl7fQogfTsKLS0gCjEuNS4yLjMKCg==
------=_Part_21566_32779326.1184280078086
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_21566_32779326.1184280078086--
