From: Hendrik-Jan Heins <hjheins@gmail.com>
Subject: Re: Sony Vaio Pro svp112a1cm
Date: Fri, 7 Feb 2014 08:47:18 +0100
Message-ID: <CAAU0D9ewA38Yqq0FhebF1DNtwGPaEv5kk1Pp3OBoeNrOz3zMnA@mail.gmail.com>
References: <CAAU0D9cXafhbUY9bOf9AK_uUpYszV5BuoM5d3vHJjhFQbifxqQ@mail.gmail.com>
 <s5h7g9ajagu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c262300be00604f1cc3382
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f48.google.com (mail-la0-f48.google.com
 [209.85.215.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B3132652CE
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2014 08:47:19 +0100 (CET)
Received: by mail-la0-f48.google.com with SMTP id mc6so2309665lab.7
 for <alsa-devel@alsa-project.org>; Thu, 06 Feb 2014 23:47:19 -0800 (PST)
In-Reply-To: <s5h7g9ajagu.wl%tiwai@suse.de>
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
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--001a11c262300be00604f1cc3382
Content-Type: text/plain; charset=UTF-8

Dear Takashi,

I just went ahead and gave it a shot the way I hoped it should work.
The internal and the headphone microphone is now appearing in alsa,
and they are both working.

The patch is indeed very simple as you said; I just changed the
deviceID to the correct one, and it works.

please find it attached.

best regards,

Hendrik-Jan

2014-02-05 8:16 GMT+01:00 Takashi Iwai <tiwai@suse.de>:
> At Tue, 4 Feb 2014 23:04:08 +0100,
> Hendrik-Jan Heins wrote:
>>
>> Dear list,
>>
>> to report the Spny Vaio Pro svp112a1cm
>> THe sound device in this notebook works, but the internal microphone not.
>> This seeems to be the same device as in teh 13 inch version of this
>> laptop, but they seem to have changed the ID of the device.
>> Maybe the same fix can be applied to fix?
>
> If adding your id makes it working, just let us know (or submit a fix
> patch).
>
> That fixup is basically to disable the pin detection at NID 0x18 where
> reports a bogus state due to the TRRS headset jack.
>
>
> Takashi
>
>> All details of the machine are available here:
>> http://www.alsa-project.org/db/?f=970d897015298925b86d4d2c68a106fba22eb184
>>
>> thank you.
>>
>> best regards,
>>
>> Hendrik-Jan
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>

--001a11c262300be00604f1cc3382
Content-Type: text/x-patch; charset=US-ASCII; name="vaio_snd.patch"
Content-Disposition: attachment; filename="vaio_snd.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hrd5hwh40

LS0tIHNyYy9saW51eC0zLjEyL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCTIwMTQtMDIt
MDYgMjM6NDQ6MDguMzUyNjkzNjk0ICswMTAwCisrKyBwYXRjaF9yZWFsdGVrLmMJMjAxNC0wMi0w
NiAyMzoyMzo1My4wODM1NzgwOTcgKzAxMDAKQEAgLTQwMzQsNiArNDAzNCw3IEBACiAJU05EX1BD
SV9RVUlSSygweDEwNDMsIDB4ODNjZSwgIkFTVVMgUDEwMDUiLCBBTEMyNjlfRklYVVBfU1RFUkVP
X0RNSUMpLAogCVNORF9QQ0lfUVVJUksoMHgxMDQzLCAweDg1MTYsICJBU1VTIFgxMDFDSCIsIEFM
QzI2OV9GSVhVUF9BU1VTX1gxMDEpLAogCVNORF9QQ0lfUVVJUksoMHgxMDRkLCAweDkwYjYsICJT
b255IFZBSU8gUHJvIDEzIiwgQUxDMjg2X0ZJWFVQX1NPTllfTUlDX05PX1BSRVNFTkNFKSwKKwlT
TkRfUENJX1FVSVJLKDB4MTA0ZCwgMHg5MGI1LCAiU29ueSBWQUlPIFBybyAxMSIsIEFMQzI4Nl9G
SVhVUF9TT05ZX01JQ19OT19QUkVTRU5DRSksCiAJU05EX1BDSV9RVUlSSygweDEwNGQsIDB4OTA3
MywgIlNvbnkgVkFJTyIsIEFMQzI3NV9GSVhVUF9TT05ZX1ZBSU9fR1BJTzIpLAogCVNORF9QQ0lf
UVVJUksoMHgxMDRkLCAweDkwN2IsICJTb255IFZBSU8iLCBBTEMyNzVfRklYVVBfU09OWV9IV0VR
KSwKIAlTTkRfUENJX1FVSVJLKDB4MTA0ZCwgMHg5MDg0LCAiU29ueSBWQUlPIiwgQUxDMjc1X0ZJ
WFVQX1NPTllfSFdFUSksCg==
--001a11c262300be00604f1cc3382
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--001a11c262300be00604f1cc3382--
