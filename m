From: Kailang <kailang@realtek.com>
Subject: Re: alc295_fixup_chromebook function
Date: Wed, 3 Apr 2019 08:28:35 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A18DBB118@RTITMBSVM07.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A18DBAE8F@RTITMBSVM07.realtek.com.tw>
 <s5hv9zykwga.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A18DBB118RTITMBSVM07real_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62356F8068A
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2019 10:28:43 +0200 (CEST)
In-Reply-To: <s5hv9zykwga.wl-tiwai@suse.de>
Content-Language: zh-TW
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_6FAB7C47BCF00940BB0999A99BE3547A18DBB118RTITMBSVM07real_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

This patch also changed model name as 'alc-chrome-book'.
It also tested by Intel Chrome audio team.

BR,
Kailang

-----Original Message-----
From: Takashi Iwai <tiwai@suse.de>=20
Sent: Monday, April 1, 2019 3:37 PM
To: Kailang <kailang@realtek.com>
Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
Subject: Re: alc295_fixup_chromebook function

On Mon, 01 Apr 2019 09:29:35 +0200,
Kailang wrote:
>=20
> Hi Takashi,
>=20
> You applied below patch.
> https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit
> /?h=3Dfor-next&id=3Dc8a9afa632f0fd45731d3353525faf1fdb362c89
>=20
> But I think ALC225_FIXUP_HEADSET_JACK will applicate for enable for heads=
et button.
> It was not only use for Chrome OS.
> So, ALC225_FIXUP_HEADSET_JACK and alc295_fixup_chromebook separation were=
 be better.
>=20
> Intel test https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.gi=
t/commit/?h=3Dfor-next&id=3D10f5b1b85ed10a80d45bc2db450e65bd792efaad this p=
atch.
> Mic JD was also not stable. (I don't know why. It passed with Ubuntu=20
> OS.) It need to change to initial state would be better. (original was=20
> HDA_FIXUP_ACT_PRE_PROBE)
>=20
> +static void alc295_fixup_chromebook(struct hda_codec *codec,
> +				    const struct hda_fixup *fix, int action) {
> +
> +	switch (action) {
> +	case HDA_FIXUP_ACT_INIT:
> +		switch (codec->core.vendor_id) {
> +		case 0x10ec0295:
> +			alc_update_coef_idx(codec, 0x4a, 0x8000, 1 << 15); /* Reset HP JD */
> +			alc_update_coef_idx(codec, 0x4a, 0x8000, 0 << 15);
> +			break;
> +		case 0x10ec0236:
> +			alc_update_coef_idx(codec, 0x1b, 0x8000, 1 << 15); /* Reset HP JD */
> +			alc_update_coef_idx(codec, 0x1b, 0x8000, 0 << 15);
> +			break;
> +		}
> +		break;
> +	}
> +}
>=20
> How could I create a fix patch for this?

The Chromebook quirk name was chosen so that the quirk implementation won't=
 be used by any random user as a generic solution.  If it can be used for r=
eal solutions, feel free to rename / split the quirk for easy adaption.  I =
have no big preference, but would like to judge from the actual patches.


thanks,

Takashi

------Please consider the environment before printing this e-mail.

--_002_6FAB7C47BCF00940BB0999A99BE3547A18DBB118RTITMBSVM07real_
Content-Type: application/octet-stream; name="0001-headset-mic-jd.patch"
Content-Description: 0001-headset-mic-jd.patch
Content-Disposition: attachment; filename="0001-headset-mic-jd.patch";
	size=3841; creation-date="Wed, 03 Apr 2019 08:01:52 GMT";
	modification-date="Wed, 03 Apr 2019 08:25:25 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwMDVkMTg2NjFkYTYyZjI4MWZlMGU1N2YzODk0ZTc5OWM2MGU2MjJjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFdlZCwgMyBBcHIgMjAxOSAxNTozMTo0OSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGhkYS9yZWFsdGVrIC0gTW92ZSB0byBBQ1RfSU5JVCBzdGF0ZQoKSXQgd2lsbCBiZSBsb3NlIE1p
YyBKRCBzdGF0ZSB3aGVuIENocm9tZSBPUyBib290IGFuZCBoZWFkc2V0IHdhcyBwbHVnZ2VkLgpK
dXN0IEltcGxlbWVudCBvZiByZXNldCBjb21ibyBqYWNrIEpEIHZlcmIgZm9yIEFDVF9QUkVfUFJP
QkUgc3RhdGUuCkludGVsIHRlc3QgcmVzdWx0IHdhcyBhbHNvIGZhaWxlZC4gCkl0IHRlc3QgcGFz
c2VkIHVudGlsIGNoYW5nZWQgdGhlIGluaXRpYWwgc3RhdGUgdG8gQUNUX0lOSVQuCk1pYyBKRCB3
aWxsIHNob3cgZXZlcnkgdGltZS4KVGhpcyBwYXRjaCBhbHNvIGNoYW5nZWQgdGhlIG1vZGVsIG5h
bWUgYXMgJ2FsYy1jaHJvbWUtYm9vaycgZm9yIGFwcGxpY2F0aW9uIG9mIENocm9tZSBPUy4KCkZp
eGVzOiAxMGY1YjFiODVlZDEgKCJBTFNBOiBoZGEvcmVhbHRlayAtIEZpeGVkIEhlYWRzZXQgTWlj
IEpEIG5vdCBzdGFibGUiKQpTaWduZWQtb2ZmLWJ5OiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVh
bHRlay5jb20+CgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgYi9z
b3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwppbmRleCBhM2ZiM2Q0YzU3MzAuLjExMjc2OTY0
NDBhZiAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIvc291
bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKQEAgLTU0OTEsNyArNTQ5MSw3IEBAIHN0YXRpYyB2
b2lkIGFsY19oZWFkc2V0X2J0bl9jYWxsYmFjayhzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYywKIAlq
YWNrLT5qYWNrLT5idXR0b25fc3RhdGUgPSByZXBvcnQ7CiB9CiAKLXN0YXRpYyB2b2lkIGFsYzI5
NV9maXh1cF9jaHJvbWVib29rKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjLAorc3RhdGljIHZvaWQg
YWxjX2ZpeHVwX2hlYWRzZXRfamFjayhzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYywKIAkJCQkgICAg
Y29uc3Qgc3RydWN0IGhkYV9maXh1cCAqZml4LCBpbnQgYWN0aW9uKQogewogCkBAIC01NTAxLDE2
ICs1NTAxLDYgQEAgc3RhdGljIHZvaWQgYWxjMjk1X2ZpeHVwX2Nocm9tZWJvb2soc3RydWN0IGhk
YV9jb2RlYyAqY29kZWMsCiAJCQkJCQkgICAgYWxjX2hlYWRzZXRfYnRuX2NhbGxiYWNrKTsKIAkJ
c25kX2hkYV9qYWNrX2FkZF9rY3RsKGNvZGVjLCAweDU1LCAiSGVhZHNldCBKYWNrIiwgZmFsc2Us
CiAJCQkJICAgICAgU05EX0pBQ0tfSEVBRFNFVCwgYWxjX2hlYWRzZXRfYnRuX2tleW1hcCk7Ci0J
CXN3aXRjaCAoY29kZWMtPmNvcmUudmVuZG9yX2lkKSB7Ci0JCWNhc2UgMHgxMGVjMDI5NToKLQkJ
CWFsY191cGRhdGVfY29lZl9pZHgoY29kZWMsIDB4NGEsIDB4ODAwMCwgMSA8PCAxNSk7IC8qIFJl
c2V0IEhQIEpEICovCi0JCQlhbGNfdXBkYXRlX2NvZWZfaWR4KGNvZGVjLCAweDRhLCAweDgwMDAs
IDAgPDwgMTUpOwotCQkJYnJlYWs7Ci0JCWNhc2UgMHgxMGVjMDIzNjoKLQkJCWFsY191cGRhdGVf
Y29lZl9pZHgoY29kZWMsIDB4MWIsIDB4ODAwMCwgMSA8PCAxNSk7IC8qIFJlc2V0IEhQIEpEICov
Ci0JCQlhbGNfdXBkYXRlX2NvZWZfaWR4KGNvZGVjLCAweDFiLCAweDgwMDAsIDAgPDwgMTUpOwot
CQkJYnJlYWs7Ci0JCX0KIAkJYnJlYWs7CiAJY2FzZSBIREFfRklYVVBfQUNUX0lOSVQ6CiAJCXN3
aXRjaCAoY29kZWMtPmNvcmUudmVuZG9yX2lkKSB7CkBAIC01NTMxLDYgKzU1MjEsMjUgQEAgc3Rh
dGljIHZvaWQgYWxjMjk1X2ZpeHVwX2Nocm9tZWJvb2soc3RydWN0IGhkYV9jb2RlYyAqY29kZWMs
CiAJfQogfQogCitzdGF0aWMgdm9pZCBhbGMyOTVfZml4dXBfY2hyb21lYm9vayhzdHJ1Y3QgaGRh
X2NvZGVjICpjb2RlYywKKwkJCQkgICAgY29uc3Qgc3RydWN0IGhkYV9maXh1cCAqZml4LCBpbnQg
YWN0aW9uKQoreworCXN3aXRjaCAoYWN0aW9uKSB7CisJY2FzZSBIREFfRklYVVBfQUNUX0lOSVQ6
CisJCXN3aXRjaCAoY29kZWMtPmNvcmUudmVuZG9yX2lkKSB7CisJCWNhc2UgMHgxMGVjMDI5NToK
KwkJCWFsY191cGRhdGVfY29lZl9pZHgoY29kZWMsIDB4NGEsIDB4ODAwMCwgMSA8PCAxNSk7IC8q
IFJlc2V0IEhQIEpEICovCisJCQlhbGNfdXBkYXRlX2NvZWZfaWR4KGNvZGVjLCAweDRhLCAweDgw
MDAsIDAgPDwgMTUpOworCQkJYnJlYWs7CisJCWNhc2UgMHgxMGVjMDIzNjoKKwkJCWFsY191cGRh
dGVfY29lZl9pZHgoY29kZWMsIDB4MWIsIDB4ODAwMCwgMSA8PCAxNSk7IC8qIFJlc2V0IEhQIEpE
ICovCisJCQlhbGNfdXBkYXRlX2NvZWZfaWR4KGNvZGVjLCAweDFiLCAweDgwMDAsIDAgPDwgMTUp
OworCQkJYnJlYWs7CisJCX0KKwkJYnJlYWs7CisJfQorfQorCiBzdGF0aWMgdm9pZCBhbGNfZml4
dXBfZGlzYWJsZV9taWNfdnJlZihzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYywKIAkJCQkgIGNvbnN0
IHN0cnVjdCBoZGFfZml4dXAgKmZpeCwgaW50IGFjdGlvbikKIHsKQEAgLTU2ODQsNiArNTY5Myw3
IEBAIGVudW0gewogCUFMQzI4NV9GSVhVUF9MRU5PVk9fUENfQkVFUF9JTl9OT0lTRSwKIAlBTEMy
NTVfRklYVVBfQUNFUl9IRUFEU0VUX01JQywKIAlBTEMyOTVfRklYVVBfQ0hST01FX0JPT0ssCisJ
QUxDMjI1X0ZJWFVQX0hFQURTRVRfSkFDSywKIAlBTEMyMjVfRklYVVBfREVMTF9XWVNFX0FJT19N
SUNfTk9fUFJFU0VOQ0UsCiAJQUxDMjI1X0ZJWFVQX1dZU0VfQVVUT19NVVRFLAogCUFMQzIyNV9G
SVhVUF9XWVNFX0RJU0FCTEVfTUlDX1ZSRUYsCkBAIC02NjM1LDYgKzY2NDUsMTIgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBoZGFfZml4dXAgYWxjMjY5X2ZpeHVwc1tdID0gewogCVtBTEMyOTVfRklY
VVBfQ0hST01FX0JPT0tdID0gewogCQkudHlwZSA9IEhEQV9GSVhVUF9GVU5DLAogCQkudi5mdW5j
ID0gYWxjMjk1X2ZpeHVwX2Nocm9tZWJvb2ssCisJCS5jaGFpbmVkID0gdHJ1ZSwKKwkJLmNoYWlu
X2lkID0gQUxDMjI1X0ZJWFVQX0hFQURTRVRfSkFDSworCX0sCisJW0FMQzIyNV9GSVhVUF9IRUFE
U0VUX0pBQ0tdID0geworCQkudHlwZSA9IEhEQV9GSVhVUF9GVU5DLAorCQkudi5mdW5jID0gYWxj
X2ZpeHVwX2hlYWRzZXRfamFjaywKIAl9LAogCVtBTEMyOTNfRklYVVBfU1lTVEVNNzZfTUlDX05P
X1BSRVNFTkNFXSA9IHsKIAkJLnR5cGUgPSBIREFfRklYVVBfUElOUywKQEAgLTcxMzIsNyArNzE0
OCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaGRhX21vZGVsX2ZpeHVwIGFsYzI2OV9maXh1cF9t
b2RlbHNbXSA9IHsKIAl7LmlkID0gQUxDMjU1X0ZJWFVQX0RVTU1ZX0xJTkVPVVRfVkVSQiwgLm5h
bWUgPSAiYWxjMjU1LWR1bW15LWxpbmVvdXQifSwKIAl7LmlkID0gQUxDMjU1X0ZJWFVQX0RFTExf
SEVBRFNFVF9NSUMsIC5uYW1lID0gImFsYzI1NS1kZWxsLWhlYWRzZXQifSwKIAl7LmlkID0gQUxD
Mjk1X0ZJWFVQX0hQX1gzNjAsIC5uYW1lID0gImFsYzI5NS1ocC14MzYwIn0sCi0Jey5pZCA9IEFM
QzI5NV9GSVhVUF9DSFJPTUVfQk9PSywgLm5hbWUgPSAiYWxjLXNlbnNlLWNvbWJvIn0sCisJey5p
ZCA9IEFMQzIyNV9GSVhVUF9IRUFEU0VUX0pBQ0ssIC5uYW1lID0gImFsYy1oZWFkc2V0LWphY2si
fSwKKwl7LmlkID0gQUxDMjk1X0ZJWFVQX0NIUk9NRV9CT09LLCAubmFtZSA9ICJhbGMtY2hyb21l
LWJvb2sifSwKIAl7LmlkID0gQUxDMjk5X0ZJWFVQX1BSRURBVE9SX1NQSywgLm5hbWUgPSAicHJl
ZGF0b3Itc3BrIn0sCiAJe30KIH07Cg==

--_002_6FAB7C47BCF00940BB0999A99BE3547A18DBB118RTITMBSVM07real_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A18DBB118RTITMBSVM07real_--
