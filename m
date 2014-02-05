From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Strange sound of IDT 82hd206xx6 at font port in
	AC97 mode
Date: Wed, 5 Feb 2014 15:57:21 +0800
Message-ID: <CAN8cciY8GMvTRAacqv1JyaGH6GfEZ9kcraLUJzeUByPEeASr9Q@mail.gmail.com>
References: <BLU0-SMTP22F128862C405DED98AB89ADAB0@phx.gbl>
 <CAN8cciZ+QwNpSnBmXuvKV9Hkqhfbo6CvY0bmx7rMQic9+tgb8A@mail.gmail.com>
 <BLU0-SMTP39216262BA66E5ED8A80E9BADAA0@phx.gbl>
 <CAN8ccianyNMd02ywO+AtbFoAsTxcm_Q8Fa-ab4hExAXi=Jw0Fw@mail.gmail.com>
 <BLU0-SMTP2290BB01520D451B3C3E1FCADAA0@phx.gbl>
 <CAN8cciZtetqAFq4uCC_qxN5+FmNRm58g1x2rzVWk4b-Zy3aHRA@mail.gmail.com>
 <BLU0-SMTP2938A849DA7F312C44807A3AD950@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c2dac0491a5304f1a41bab
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f46.google.com (mail-qa0-f46.google.com
 [209.85.216.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 786432625E0
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 08:57:22 +0100 (CET)
Received: by mail-qa0-f46.google.com with SMTP id ii20so46234qab.19
 for <alsa-devel@alsa-project.org>; Tue, 04 Feb 2014 23:57:21 -0800 (PST)
In-Reply-To: <BLU0-SMTP2938A849DA7F312C44807A3AD950@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Randy Li <lxr1234@hotmail.com>, tiwai@suse.de
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--001a11c2dac0491a5304f1a41bab
Content-Type: text/plain; charset=UTF-8

http://www.alsa-project.org/db/?f=ce795f0f8e31b9eb5e35cc2fed572290d14b1cda


>>>
> >>>
> >>> Simple mixer control 'Swap Center/LFE',0 Capabilities: pswitch
> >>> pswitch-joined penum Playback channels: Mono Mono: Playback
> >>> [off]
> >>>
> >>>
> >>>
> >>> Do this switch change the output of center and lfe when you
> >>> run
> >>>
> >>> speaker-test -c 6 -t wav -D hw:0,0
> >>>
> >> I only hear the font left and font right in both side of my
> >> headphone(the one for android)
> >>> seem that your are not using latest alsa driver
> >> The alsa driver? Well, shall I try the latest kernel?
> >
> > Do the channel swap at the orange rack at rear panel ?
> >
> > Do you have a speaker to test ?
> >
>


> At the front panel, not swap, I heared front left and front right in
> both side.
> At the rack panel, swaped.
> For the normal headphone(speaker)
> The font left and font right is switch the side.
>

Fix the device part of four line out from speaker to line out for ECS
A780GM-A

No more "Rear Mic Jack Mode" , "Front Jack Mode" and "Line Jack Mode" after
this fix when there is no internal speaker

those jack mode switches are redundant when the computer have both Line in
jack and Mic jack

--001a11c2dac0491a5304f1a41bab
Content-Type: text/x-diff; charset=US-ASCII; name="92HD206_Fix_Lineout.patch"
Content-Disposition: attachment; filename="92HD206_Fix_Lineout.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hraarlgy0

ZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYyBiL3NvdW5kL3BjaS9o
ZGEvcGF0Y2hfc2lnbWF0ZWwuYwppbmRleCA2OTk4Y2YyLi5jM2U1ODMzIDEwMDY0NAotLS0gYS9z
b3VuZC9wY2kvaGRhL3BhdGNoX3NpZ21hdGVsLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9z
aWdtYXRlbC5jCkBAIC0xNjMsNiArMTYzLDcgQEAgZW51bSB7CiAJU1RBQ19ERUxMX0JJT1NfU1BE
SUYsCiAJU1RBQ185MjdYX0RFTExfRE1JQywKIAlTVEFDXzkyN1hfVk9MS05PQiwKKwlTVEFDXzky
SEQyMDZfRklYXzZTVEFDS19MSU5FT1VULAogCVNUQUNfOTI3WF9NT0RFTFMKIH07CiAKQEAgLTM4
MTMsNiArMzgxNCwxNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGhkYV9maXh1cCBzdGFjOTI3eF9m
aXh1cHNbXSA9IHsKIAkJLnR5cGUgPSBIREFfRklYVVBfRlVOQywKIAkJLnYuZnVuYyA9IHN0YWM5
Mjd4X2ZpeHVwX3ZvbGtub2IsCiAJfSwKKwlbU1RBQ185MkhEMjA2X0ZJWF82U1RBQ0tfTElORU9V
VF0gPSB7CisJCS50eXBlID0gSERBX0ZJWFVQX1BJTlMsCisJCS52LnBpbnMgPSAoY29uc3Qgc3Ry
dWN0IGhkYV9waW50YmxbXSkgeworCQkJLyogY29ycmVjdCB0aGUgZGV2aWNlIGZpZWxkIHRvIExp
bmUgT3V0IG91dCAqLworCQkJeyAweDBkLCAweDAxMDE0MDEwIH0sCisJCQl7IDB4MGYsIDB4MDEw
MTEwMTIgfSwKKwkJCXsgMHgxMCwgMHgwMTAxNjAxMSB9LAorCQkJeyAweDExLCAweDAxMDEyMDE0
IH0sCQkJCisJCQl7fQorCQl9LAkJCQorCX0KIH07CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaGRh
X21vZGVsX2ZpeHVwIHN0YWM5Mjd4X21vZGVsc1tdID0gewpAQCAtMzg2MSw2ICszODczLDcgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfcGNpX3F1aXJrIHN0YWM5Mjd4X2ZpeHVwX3RibFtdID0g
ewogCQkJICAgIkludGVsIEQ5NjUiLCBTVEFDX0Q5NjVfNVNUKSwKIAlTTkRfUENJX1FVSVJLX01B
U0soUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHhmZjAwLCAweDI1MDAsCiAJCQkgICAiSW50ZWwgRDk2
NSIsIFNUQUNfRDk2NV81U1QpLAorCVNORF9QQ0lfUVVJUksoMHgxMDE5LCAweDI4MTYsICJFQ1Mg
QTc4MEdNLUEiLCBTVEFDXzkySEQyMDZfRklYXzZTVEFDS19MSU5FT1VUKSwKIAkvKiB2b2x1bWUt
a25vYiBmaXhlcyAqLwogCVNORF9QQ0lfUVVJUktfVkVORE9SKDB4MTBjZiwgIkZTQyIsIFNUQUNf
OTI3WF9WT0xLTk9CKSwKIAl7fSAvKiB0ZXJtaW5hdG9yICovCg==
--001a11c2dac0491a5304f1a41bab
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--001a11c2dac0491a5304f1a41bab--
