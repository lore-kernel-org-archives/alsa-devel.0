From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use ALC880_F1734 quirk for Fujitsu
	Siemens AMILO Xi 1526
Date: Thu, 22 Apr 2010 07:24:58 -0400
Message-ID: <x2u604760771004220424y86a486e8q1535a327bb2ff26c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00504502cc9190ed660484d18f85
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 06F1510380F
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 13:24:59 +0200 (CEST)
Received: by pvh11 with SMTP id 11so434549pvh.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Apr 2010 04:24:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, stable@kernel.org, Arnaud Malpeyre <amalpeyre@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--00504502cc9190ed660484d18f85
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch (also applicable to 2.6.32.11 and 2.6.33.2)
against sound-2.6 master HEAD that fixes the quirk used for the OR's
hardware.

Best,
-Dan

--00504502cc9190ed660484d18f85
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ALSA-hda-Use-ALC880_F1734-quirk-for-Fujitsu-Siemens-.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-ALC880_F1734-quirk-for-Fujitsu-Siemens-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g8bhgo100

RnJvbSBlZmU4OGM2NDUwMGEzMGE3M2EwMWM2M2ZhMmQ1MGY2OTg5YWEyNjE5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFRodSwgMjIgQXByIDIwMTAgMDc6MTU6MjYgLTA0MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IFVzZSBBTEM4ODBfRjE3MzQgcXVpcmsgZm9yIEZ1aml0c3UgU2llbWVucyBBTUlMTyBY
aSAxNTI2CgpCdWdMaW5rOiBodHRwczovL2xhdW5jaHBhZC5uZXQvYnVncy81Njc0OTQKClRoZSBP
UiBoYXMgdmVyaWZpZWQgdGhhdCB0aGUgZXhpc3RpbmcgbW9kZWwgcXVpcmssIEFMQzg4MF9VTklX
SUxMLAppcyBpbnN1ZmZpY2llbnQgZm9yIGF1ZGlibGUgcGxheWJhY2sgYW5kIGNhcHR1cmUgYnkg
ZGVmYXVsdC4gSW5zdGVhZCwKdGhlIEFMQzg4MF9GMTczNCBtb2RlbCBxdWlyayBuZWVkcyB0byBi
ZSB1c2VkLgoKVGhpcyBjaGFuZ2UgaXMgbmVjZXNzYXJ5IGZvciBib3RoIDIuNi4zMi4xMSBhbmQg
Mi42LjMzLjIuCgpSZXBvcnRlZC1ieTogQXJuYXVkIE1hbHBleXJlIDxhbWFscGV5cmVAZ21haWwu
Y29tPgpUZXN0ZWQtYnk6IEFybmF1ZCBNYWxwZXlyZSA8YW1hbHBleXJlQGdtYWlsLmNvbT4KQ2M6
IDxzdGFibGVAa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTogRGFuaWVsIFQgQ2hlbiA8Y3JpbXN1
bkB1YnVudHUuY29tPgotLS0KIHNvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIHwgICAgMiAr
LQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgYi9zb3VuZC9wY2kvaGRhL3Bh
dGNoX3JlYWx0ZWsuYwppbmRleCBmNDI1MzQ0Li4yMDc4YTFhIDEwMDY0NAotLS0gYS9zb3VuZC9w
Y2kvaGRhL3BhdGNoX3JlYWx0ZWsuYworKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsu
YwpAQCAtNDIzMSw3ICs0MjMxLDcgQEAgc3RhdGljIHN0cnVjdCBzbmRfcGNpX3F1aXJrIGFsYzg4
MF9jZmdfdGJsW10gPSB7CiAJU05EX1BDSV9RVUlSSygweDE2OTUsIDB4NDAxMiwgIkVQb3ggRVAt
NUxEQSIsIEFMQzg4MF81U1RfRElHKSwKIAlTTkRfUENJX1FVSVJLKDB4MTczNCwgMHgxMDdjLCAi
RlNDIEYxNzM0IiwgQUxDODgwX0YxNzM0KSwKIAlTTkRfUENJX1FVSVJLKDB4MTczNCwgMHgxMDk0
LCAiRlNDIEFtaWxvIE0xNDUxRyIsIEFMQzg4MF9GVUpJVFNVKSwKLQlTTkRfUENJX1FVSVJLKDB4
MTczNCwgMHgxMGFjLCAiRlNDIiwgQUxDODgwX1VOSVdJTEwpLAorCVNORF9QQ0lfUVVJUksoMHgx
NzM0LCAweDEwYWMsICJGU0MgQU1JTE8gWGkgMTUyNiIsIEFMQzg4MF9GMTczNCksCiAJU05EX1BD
SV9RVUlSSygweDE3MzQsIDB4MTBiMCwgIkZ1aml0c3UiLCBBTEM4ODBfRlVKSVRTVSksCiAJU05E
X1BDSV9RVUlSSygweDE4NTQsIDB4MDAxOCwgIkxHIExXMjAiLCBBTEM4ODBfTEdfTFcpLAogCVNO
RF9QQ0lfUVVJUksoMHgxODU0LCAweDAwM2IsICJMRyIsIEFMQzg4MF9MRyksCi0tIAoxLjcuMC40
Cgo=
--00504502cc9190ed660484d18f85
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--00504502cc9190ed660484d18f85--
