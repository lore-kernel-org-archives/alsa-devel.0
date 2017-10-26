From: Pshou <pshou@realtek.com>
Subject: ALC1200 in the Clevo-P51
Date: Thu, 26 Oct 2017 08:02:58 +0000
Message-ID: <126650E837C1704F92183C9FD34C1CCE183D36DC@RTITMBSV02.realtek.com.tw>
References: <126650E837C1704F92183C9FD34C1CCE183CFA38@RTITMBSV02.realtek.com.tw>
 <s5hwp5xb4oo.wl-tiwai@suse.de>
 <3BAA9B489B84C8429C9984AC5274928001F61F58@RTITMBSV02.realtek.com.tw>
 <s5hd17ot1ng.wl-tiwai@suse.de>
 <126650E837C1704F92183C9FD34C1CCE183D0385@RTITMBSV02.realtek.com.tw>
 <s5h4lsmvntp.wl-tiwai@suse.de>
 <126650E837C1704F92183C9FD34C1CCE183D03A6@RTITMBSV02.realtek.com.tw>
 <s5ho9quu6ym.wl-tiwai@suse.de>
 <126650E837C1704F92183C9FD34C1CCE183D04D7@RTITMBSV02.realtek.com.tw>
 <s5hlglurdmc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_126650E837C1704F92183C9FD34C1CCE183D36DCRTITMBSV02realt_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 3807B266A0C
 for <alsa-devel@alsa-project.org>; Thu, 26 Oct 2017 10:03:05 +0200 (CEST)
In-Reply-To: <s5hlglurdmc.wl-tiwai@suse.de>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kailang <kailang@realtek.com>
List-Id: alsa-devel@alsa-project.org

--_002_126650E837C1704F92183C9FD34C1CCE183D36DCRTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

 Hi Takashi:

Nice to meet you.
=20
This is the case of ALC1220 Clevo-P51.

Speaker uses I2S output.
We therefore want to make sure 0x14 (Headphones) and 0x1b (Speakers)
use to stereo DAC 0x02.

Best regards
Pshou

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]=20
Sent: Monday, September 04, 2017 5:56 PM
To: Pshou
Cc: alsa-devel@alsa-project.org; CHLin; Kailang; Singh, Guneshwor O
Subject: Re: ALC700 in the Intel chipset

On Mon, 04 Sep 2017 10:13:49 +0200,
Pshou wrote:
>=20
> =20
> Hi Takashi:
>=20
> Sorry
> I'll send it back again.
> this file is right.

Applied now.  Thanks.


Takashi

------Please consider the environment before printing this e-mail.

--_002_126650E837C1704F92183C9FD34C1CCE183D36DCRTITMBSV02realt_
Content-Type: application/octet-stream;
	name="0001-ALSA-hda-realtek-Add-support-for-ALC1220.patch"
Content-Description: 0001-ALSA-hda-realtek-Add-support-for-ALC1220.patch
Content-Disposition: attachment;
	filename="0001-ALSA-hda-realtek-Add-support-for-ALC1220.patch"; size=2410;
	creation-date="Wed, 25 Oct 2017 22:18:27 GMT";
	modification-date="Thu, 26 Oct 2017 06:38:49 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhNGU4NTY5NDk5MTc3MTgyYzQzMzQ0YjNkYThkZDA5ZDk5YTUzODQ0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQZWlzZW4gPHBzaG91QHJlYWx0ZWsuY29tPgpEYXRlOiBUaHUs
IDI2IE9jdCAyMDE3IDEwOjM1OjM2ICswODAwClN1YmplY3Q6IFtQQVRDSF0gIEFMU0E6IGhkYS9y
ZWFsdGVrIC0gQWRkIHN1cHBvcnQgZm9yIEFMQzEyMjAKCkFkZCBDbGV2by1QNTEgbW9kZSBzdXBw
b3J0IGZvciBBTEMxMjIwLgpBTEMxMjIwIENsZXZvLXA1MQpTcGVha2VyIHVzZXMgSTJTIG91dHB1
dC4KV2UgdGhlcmVmb3JlIHdhbnQgdG8gbWFrZSBzdXJlIDB4MTQgKEhlYWRwaG9uZXMpIGFuZCAw
eDFiIChTcGVha2VycykKdXNlIHRvIHN0ZXJlbyBEQUMgMHgwMi4KClNpZ25lZC1vZmYtYnk6IFBl
aXNlbiBIb3UgPHBzaG91QHJlYWx0ZWsuY29tPgoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEv
cGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKaW5kZXggMDJj
NzlkNi4uZGZlZmNhMCAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMK
KysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKQEAgLTE4MDMsNiArMTgwMyw3IEBA
IGVudW0gewogCUFMQzg4N19GSVhVUF9BU1VTX0JBU1MsCiAJQUxDODg3X0ZJWFVQX0JBU1NfQ0hN
QVAsCiAJQUxDMTIyMF9GSVhVUF9HQl9EVUFMX0NPREVDUywKKwlBTEMxMjIwX0ZJWFVQX0NMRVZP
X1A5NTAsCiB9OwogCiBzdGF0aWMgdm9pZCBhbGM4ODlfZml4dXBfY29lZihzdHJ1Y3QgaGRhX2Nv
ZGVjICpjb2RlYywKQEAgLTIwMjAsNiArMjAyMSwyMSBAQCBzdGF0aWMgdm9pZCBhbGMxMjIwX2Zp
eHVwX2diX2R1YWxfY29kZWNzKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjLAogCX0KIH0KIAorc3Rh
dGljIHZvaWQgYWxjMTIyMF9maXh1cF9jbGV2b19wOTUwKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVj
LAorCQkJCWNvbnN0IHN0cnVjdCBoZGFfZml4dXAgKmZpeCwKKwkJCQkgaW50IGFjdGlvbikKK3sK
KwloZGFfbmlkX3QgY29ubjFbMV0gPSB7IDB4MGMgfTsKKwkJCisJaWYgKGFjdGlvbiAhPSBIREFf
RklYVVBfQUNUX1BSRV9QUk9CRSkgCisJCXJldHVybjsKKwlhbGNfdXBkYXRlX2NvZWZfaWR4KGNv
ZGVjLCAweDcsIDAsIDB4M2MzKTsKKwkvKiBXZSB0aGVyZWZvcmUgd2FudCB0byBtYWtlIHN1cmUg
MHgxNCAoZnJvbnQgaGVhZHBob25lKSBhbmQgMHgxYiAoc3BlYWtlcnMpIAorCQl1c2UgdGhlIHN0
ZXJlbyBEQUMgMHgwMiAqLworCXNuZF9oZGFfb3ZlcnJpZGVfY29ubl9saXN0KGNvZGVjLCAweDE0
LCAxLCBjb25uMSk7CisJc25kX2hkYV9vdmVycmlkZV9jb25uX2xpc3QoY29kZWMsIDB4MWIsIDEs
IGNvbm4xKTsKKworfQogc3RhdGljIGNvbnN0IHN0cnVjdCBoZGFfZml4dXAgYWxjODgyX2ZpeHVw
c1tdID0gewogCVtBTEM4ODJfRklYVVBfQUJJVF9BVzlEX01BWF0gPSB7CiAJCS50eXBlID0gSERB
X0ZJWFVQX1BJTlMsCkBAIC0yMjYwLDYgKzIyNzYsMTEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBo
ZGFfZml4dXAgYWxjODgyX2ZpeHVwc1tdID0gewogCQkudHlwZSA9IEhEQV9GSVhVUF9GVU5DLAog
CQkudi5mdW5jID0gYWxjMTIyMF9maXh1cF9nYl9kdWFsX2NvZGVjcywKIAl9LAorCVtBTEMxMjIw
X0ZJWFVQX0NMRVZPX1A5NTBdID0geworCQkudHlwZSA9IEhEQV9GSVhVUF9GVU5DLAorCQkudi5m
dW5jID0gYWxjMTIyMF9maXh1cF9jbGV2b19wOTUwLAorCX0sCisJCiB9OwogCiBzdGF0aWMgY29u
c3Qgc3RydWN0IHNuZF9wY2lfcXVpcmsgYWxjODgyX2ZpeHVwX3RibFtdID0gewpAQCAtMjMzMywx
MCArMjM1NCwxMSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9wY2lfcXVpcmsgYWxjODgyX2Zp
eHVwX3RibFtdID0gewogCVNORF9QQ0lfUVVJUksoMHgxNDYyLCAweGRhNTcsICJNU0kgWjI3MC1H
YW1pbmciLCBBTEMxMjIwX0ZJWFVQX0dCX0RVQUxfQ09ERUNTKSwKIAlTTkRfUENJX1FVSVJLX1ZF
TkRPUigweDE0NjIsICJNU0kiLCBBTEM4ODJfRklYVVBfR1BJTzMpLAogCVNORF9QQ0lfUVVJUkso
MHgxNDdiLCAweDEwN2EsICJBYml0IEFXOUQtTUFYIiwgQUxDODgyX0ZJWFVQX0FCSVRfQVc5RF9N
QVgpLAorCVNORF9QQ0lfUVVJUksoMHgxNTU4LCAweDk1MDEsICJDbGV2byBQOTUwSFIiLCBBTEMx
MjIwX0ZJWFVQX0NMRVZPX1A5NTApLAogCVNORF9QQ0lfUVVJUktfVkVORE9SKDB4MTU1OCwgIkNs
ZXZvIGxhcHRvcCIsIEFMQzg4Ml9GSVhVUF9FQVBEKSwKIAlTTkRfUENJX1FVSVJLKDB4MTYxZiwg
MHgyMDU0LCAiTWVkaW9uIGxhcHRvcCIsIEFMQzg4M19GSVhVUF9FQVBEKSwKIAlTTkRfUENJX1FV
SVJLKDB4MTdhYSwgMHgzYTBkLCAiTGVub3ZvIFk1MzAiLCBBTEM4ODJfRklYVVBfTEVOT1ZPX1k1
MzApLAogCXt9CiB9OwoKCg==

--_002_126650E837C1704F92183C9FD34C1CCE183D36DCRTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_126650E837C1704F92183C9FD34C1CCE183D36DCRTITMBSV02realt_--
