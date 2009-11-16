From: "Wael Nasreddine (a.k.a eMxyzptlk)" <mla@nasreddine.com>
Subject: Re: HDA Intel IDT 92HD71B7X - HP Pavilion DV7-1299EF -
	Only the left speaker is working
Date: Mon, 16 Nov 2009 19:34:45 +0100
Message-ID: <d3328e7b0911161034p3022bb3bjd1e4fc83f6e50415@mail.gmail.com>
References: <d3328e7b0911110722l27597a8bl523052b035e9ec9d@mail.gmail.com>
	<d3328e7b0911140446j6edf0646x5ca7c825ae780a0a@mail.gmail.com>
	<s5htywxmf7d.wl%tiwai@suse.de>
	<d3328e7b0911140625u745f08cdsd0f673c1482bf364@mail.gmail.com>
	<d3328e7b0911150826l6b6fffd6kdad8fb1692445b20@mail.gmail.com>
	<s5hmy2migde.wl%tiwai@suse.de>
	<d3328e7b0911160907g600fda62jc7022e980d98419f@mail.gmail.com>
	<s5haaymie6c.wl%tiwai@suse.de>
	<d3328e7b0911160922n681600a4hfe93b80daaa9265e@mail.gmail.com>
	<s5h7htqid6w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e65b6164bc451b0478814453
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EF9610380C
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 19:35:08 +0100 (CET)
Received: by bwz9 with SMTP id 9so16578722bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 10:35:06 -0800 (PST)
In-Reply-To: <s5h7htqid6w.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, julien.cynober@free.fr
List-Id: alsa-devel@alsa-project.org

--0016e65b6164bc451b0478814453
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2009 at 18:36, Takashi Iwai <tiwai@suse.de> wrote:
>
> At Mon, 16 Nov 2009 18:22:56 +0100,
> Wael Nasreddine (a.k.a eMxyzptlk) wrote:
> >
> > On Mon, Nov 16, 2009 at 18:15, Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > At Mon, 16 Nov 2009 18:07:40 +0100,
> > > Wael Nasreddine (a.k.a eMxyzptlk) wrote:
> > > >
> > > > Thank you that actually worked, I have now both Front Left and LFE =
working,
> > > > but it's very hard to tell coz the LFE is louder than both front sp=
eakers I
> > > > even put my ear directly on the speaker and it still can't be 100% =
sure, but
> > > > I think that for now what is working is 'Front Left + LFE', I can't=
 hear
> > > > anything from the right speaker.. but it's already an improvement t=
o what I
> > > > had.
> > >
> > > Hm, if it's *so* loud, we should have a mixer control for this, I
> > > guess.
> > >
> > It's not *so* loud, but yea I appreciate a mixer for it yes! at least
> > I can tell which speaker is working and also I can listen to Music
> > without bothering someone else because with LFE the base is loud..
>
> OK, how about the patch below?
>
> > > > Do you have any suggestion on how to enable the right speaker?
> > >
> > > No, already out of idea... =C2=A0I wonder whether any other people
> > > suffering from the same problem?
> > >
> > Julien has the same PC, same OS, same Kernel, same BIOS Version, but
> > the weird thing is that he is not suffering from this problem, which
> > obviously led me to beleive a hardware defect, but it's working on
> > Windows!
>
> This is really weird...
>
>
> Takashi
>

Because the patch is not attached, I can't quite copy it correctly
from Gmail, so I did it by hand (attached), I applied it but I don't
see the mixer anywhere in alsamixer. I double checked the patch
though...

--
Wael Nasreddine

Weem Chief-Development Officer - http://www.weem.com

Blog =C2=A0 =C2=A0: http://wael.nasreddine.com
E-mail =C2=A0: wael.nasreddine@weem.com
gTalk =C2=A0 : wael.nasreddine@gmail.com
Tel =C2=A0 =C2=A0 : +33.6.32.94.70.13
Skype =C2=A0 : eMxyzptlk
Twitter : @eMxyzptlk

PGP: 1024D/C8DD18A2 06F6 1622 4BC8 4CEB D724 =C2=A0DE12 5565 3945 C8DD 18A2

.: An infinite number of monkeys typing into GNU emacs,
=C2=A0 would never make a good program. (L. Torvalds 1995) :.

--0016e65b6164bc451b0478814453
Content-Type: application/octet-stream;
	name="enable-lfe_add-lfe-mixer-on-dv7.patch"
Content-Disposition: attachment;
	filename="enable-lfe_add-lfe-mixer-on-dv7.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g23kqtti0

ZGlmZiAtTmF1ciBhL2Fsc2Eta2VybmVsL3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYyBiL2Fsc2Et
a2VybmVsL3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYwotLS0gYS9hbHNhLWtlcm5lbC9wY2kvaGRh
L3BhdGNoX3NpZ21hdGVsLmMJMjAwOS0xMS0xNiAxNTozODoyNi4wMDAwMDAwMDAgKzAxMDAKKysr
IGIvYWxzYS1rZXJuZWwvcGNpL2hkYS9wYXRjaF9zaWdtYXRlbC5jCTIwMDktMTEtMTYgMTk6MTk6
MDEuMTEwNDk1MTU5ICswMTAwCkBAIC0xMDYzLDYgKzEwNjMsMTYgQEAKIHN0YXRpYyB2b2lkIHN0
YWM5Mnh4X2ZyZWVfa2N0bHMoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpOwogc3RhdGljIGludCBz
dGFjOTJ4eF9hZGRfamFjayhzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYywgaGRhX25pZF90IG5pZCwg
aW50IHR5cGUpOwogCitzdGF0aWMgdm9pZCBzdGFjX2FkZF9taXhlcihzdHJ1Y3Qgc2lnbWF0ZWxf
c3BlYyAqc3BlYywKKyAgICAgICAgICAgICAgc3RydWN0IHNuZF9rY29udHJvbF9uZXcgKmtuZXcp
Cit7CisgICBpZiAoIWtuZXcpCisgICAgICAgcmV0dXJuOworICAgaWYgKHNuZF9CVUdfT04oc3Bl
Yy0+bnVtX21peGVycyA+PSBBUlJBWV9TSVpFKHNwZWMtPm1peGVycykpKQorICAgICAgIHJldHVy
bjsKKyAgIHNwZWMtPm1peGVyc1tzcGVjLT5udW1fbWl4ZXJzKytdID0ga25ldzsKK30KKwogc3Rh
dGljIGludCBzdGFjOTJ4eF9idWlsZF9jb250cm9scyhzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykK
IHsKIAlzdHJ1Y3Qgc2lnbWF0ZWxfc3BlYyAqc3BlYyA9IGNvZGVjLT5zcGVjOwpAQCAtMzgyNSw4
ICszODM1LDcgQEAKIAlpZiAoZGlnX2luICYmIHNwZWMtPmF1dG9jZmcuZGlnX2luX3BpbikKIAkJ
c3BlYy0+ZGlnX2luX25pZCA9IGRpZ19pbjsKIAotCWlmIChzcGVjLT5rY3Rscy5saXN0KQotCQlz
cGVjLT5taXhlcnNbc3BlYy0+bnVtX21peGVycysrXSA9IHNwZWMtPmtjdGxzLmxpc3Q7CisgICAg
c3RhY19hZGRfbWl4ZXIoc3BlYywgc3BlYy0+a2N0bHMubGlzdCk7CiAKIAlzcGVjLT5pbnB1dF9t
dXggPSAmc3BlYy0+cHJpdmF0ZV9pbXV4OwogCWlmICghc3BlYy0+ZGlucHV0X211eCkKQEAgLTM5
MzUsOCArMzk0NCw3IEBACiAJaWYgKHNwZWMtPmF1dG9jZmcuZGlnX2luX3BpbikKIAkJc3BlYy0+
ZGlnX2luX25pZCA9IDB4MDQ7CiAKLQlpZiAoc3BlYy0+a2N0bHMubGlzdCkKLQkJc3BlYy0+bWl4
ZXJzW3NwZWMtPm51bV9taXhlcnMrK10gPSBzcGVjLT5rY3Rscy5saXN0OworICAgIHN0YWNfYWRk
X21peGVyKHNwZWMsIHNwZWMtPmtjdGxzLmxpc3QpOwogCiAJc3BlYy0+aW5wdXRfbXV4ID0gJnNw
ZWMtPnByaXZhdGVfaW11eDsKIAlzcGVjLT5kaW5wdXRfbXV4ID0gJnNwZWMtPnByaXZhdGVfZGlt
dXg7CkBAIC01MjgwLDYgKzUyODgsNTQgQEAKIAkJcmV0dXJuIDA7CiB9CiAKKy8qIEhQIGR2NyBi
YXNzIHZvbHVtZSAtIEdQSU81ICovCisjZGVmaW5lIHN0YWNfaHBfYmFzc19ncGlvX2luZm8gc25k
X2N0bF9ib29sZWFuX21vbm9faW5mbworc3RhdGljIGludCBzdGFjX2hwX2Jhc3NfZ3Bpb19nZXQo
c3RydWN0IHNuZF9rY29udHJvbCAqa2NvbnRyb2wsCisgICAgICAgICAgICAgICAgc3RydWN0IHNu
ZF9jdGxfZWxlbV92YWx1ZSAqdWNvbnRyb2wpCit7CisgICBzdHJ1Y3QgaGRhX2NvZGVjICpjb2Rl
YyA9IHNuZF9rY29udHJvbF9jaGlwKGtjb250cm9sKTsKKyAgIHN0cnVjdCBzaWdtYXRlbF9zcGVj
ICpzcGVjID0gY29kZWMtPnNwZWM7CisgICB1Y29udHJvbC0+dmFsdWUuaW50ZWdlci52YWx1ZVsw
XSA9ICEhKHNwZWMtPmdwaW9fZGF0YSAmIDB4MjApOworICAgcmV0dXJuIDA7Cit9CisKK3N0YXRp
YyBpbnQgc3RhY19ocF9iYXNzX2dwaW9fcHV0KHN0cnVjdCBzbmRfa2NvbnRyb2wgKmtjb250cm9s
LAorICAgICAgICAgICAgICAgIHN0cnVjdCBzbmRfY3RsX2VsZW1fdmFsdWUgKnVjb250cm9sKQor
eworICAgc3RydWN0IGhkYV9jb2RlYyAqY29kZWMgPSBzbmRfa2NvbnRyb2xfY2hpcChrY29udHJv
bCk7CisgICBzdHJ1Y3Qgc2lnbWF0ZWxfc3BlYyAqc3BlYyA9IGNvZGVjLT5zcGVjOworICAgdW5z
aWduZWQgaW50IGdwaW9fZGF0YTsKKworICAgZ3Bpb19kYXRhID0gKHNwZWMtPmdwaW9fZGF0YSAm
IH4weDIwKSB8CisgICAgICAgKHVjb250cm9sLT52YWx1ZS5pbnRlZ2VyLnZhbHVlWzBdID8gMHgy
MCA6IDApOworICAgaWYgKGdwaW9fZGF0YSA9PSBzcGVjLT5ncGlvX2RhdGEpCisgICAgICAgcmV0
dXJuIDA7CisgICBzcGVjLT5ncGlvX2RhdGEgPSBncGlvX2RhdGE7CisgICBzdGFjX2dwaW9fc2V0
KGNvZGVjLCBzcGVjLT5ncGlvX21hc2ssIHNwZWMtPmdwaW9fZGlyLCBzcGVjLT5ncGlvX2RhdGEp
OworICAgcmV0dXJuIDE7Cit9CisKK3N0YXRpYyBzdHJ1Y3Qgc25kX2tjb250cm9sX25ldyBzdGFj
X2hwX2Jhc3Nfdm9sdW1lX2N0cmxbXSA9IHsKKyAgIHsKKyAgICAgICAuaWZhY2UgPSBTTkRSVl9D
VExfRUxFTV9JRkFDRV9NSVhFUiwKKyAgICAgICAubmFtZSA9ICJCYXNzIFNwZWFrZXIgUGxheWJh
Y2sgVm9sdW1lIiwKKyAgICAgICAuaW5mbyA9IHN0YWNfaHBfYmFzc19ncGlvX2luZm8sCisgICAg
ICAgLmdldCA9IHN0YWNfaHBfYmFzc19ncGlvX2dldCwKKyAgICAgICAucHV0ID0gc3RhY19ocF9i
YXNzX2dwaW9fcHV0LAorICAgfSwKKyAgIHt9IC8qIHRlcm1pbmF0b3IgKi8KK307CisKK3N0YXRp
YyB2b2lkIHN0YWNfYWRkX2hwX2Jhc3Nfdm9sdW1lKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQor
eworICAgc3RydWN0IHNpZ21hdGVsX3NwZWMgKnNwZWMgPSBjb2RlYy0+c3BlYzsKKworICAgc3Bl
Yy0+Z3Bpb19tYXNrIHw9IDB4MjA7CisgICBzcGVjLT5ncGlvX2RpciB8PSAweDIwOworICAgc3Bl
Yy0+Z3Bpb19kYXRhIHw9IDB4MjA7CisgICBzdGFjX2FkZF9taXhlcihzcGVjLCBzdGFjX2hwX2Jh
c3Nfdm9sdW1lX2N0cmwpOworfQorCiBzdGF0aWMgaW50IHBhdGNoX3N0YWM5MmhkNzFieHgoc3Ry
dWN0IGhkYV9jb2RlYyAqY29kZWMpCiB7CiAJc3RydWN0IHNpZ21hdGVsX3NwZWMgKnNwZWM7CkBA
IC01NDY4LDYgKzU1MjQsMTggQEAKIAkJYnJlYWs7CiAJfQogCisgICAgICAgLyogZW5hYmxlIExG
RSBvbiBIUCBkdjcgaWYgYXZhaWxhYmxlICovCisgICAgICAgaWYgKHNwZWMtPmJvYXJkX2NvbmZp
ZyA9PSBTVEFDX0hQX0RWNSkgeworICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGNhcDsKKyAg
ICAgICAgICAgICAgIGNhcCA9IHNuZF9oZGFfcGFyYW1fcmVhZChjb2RlYywgMHgxLCBBQ19QQVJf
R1BJT19DQVApOworICAgICAgICAgICAgICAgY2FwICY9IEFDX0dQSU9fSU9fQ09VTlQ7CisgICAg
ICAgICAgICAgICBpZiAoY2FwID49IDYpIHsKKyAgICAgICAgICAgICAgICAgICAgICAgc3BlYy0+
Z3Bpb19tYXNrIHw9IDB4MjA7CisgICAgICAgICAgICAgICAgICAgICAgIHNwZWMtPmdwaW9fZGly
IHw9IDB4MjA7CisgICAgICAgICAgICAgICAgICAgICAgIHNwZWMtPmdwaW9fZGF0YSB8PSAweDIw
OworICAgICAgICAgICAgICAgfQorICAgICAgIH0KKwogCWlmIChocF9ic2VyaWVzX3N5c3RlbShj
b2RlYy0+c3Vic3lzdGVtX2lkKSkgewogCQlwaW5fY2ZnID0gc25kX2hkYV9jb2RlY19nZXRfcGlu
Y2ZnKGNvZGVjLCAweDBmKTsKIAkJaWYgKGdldF9kZWZjZmdfZGV2aWNlKHBpbl9jZmcpID09IEFD
X0pBQ0tfTElORV9PVVQgfHwKQEAgLTU1MzYsNiArNTYwNCwxNSBAQAogCQlyZXR1cm4gZXJyOwog
CX0KIAorICAgIC8qIGVuYWJsZSBMRkUgb24gSFAgZHY3IGlmIGF2YWlsYWJsZSAqLworICAgIGlm
IChzcGVjLT5ib2FyZF9jb25maWcgPT0gU1RBQ19IUF9EVjUpIHsKKyAgICAgICAgdW5zaWduZWQg
aW50IGNhcDsKKyAgICAgICAgY2FwID0gc25kX2hkYV9wYXJhbV9yZWFkKGNvZGVjLCAweDEsIEFD
X1BBUl9HUElPX0NBUCk7CisgICAgICAgIGNhcCAmPSBBQ19HUElPX0lPX0NPVU5UOworICAgICAg
ICBpZiAoY2FwID49IDYpCisgICAgICAgICAgICBzdGFjX2FkZF9ocF9iYXNzX3ZvbHVtZShjb2Rl
Yyk7CisgICAgfQorCiAJY29kZWMtPnByb2Nfd2lkZ2V0X2hvb2sgPSBzdGFjOTJoZDd4X3Byb2Nf
aG9vazsKIAogCXJldHVybiAwOwo=
--0016e65b6164bc451b0478814453
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016e65b6164bc451b0478814453--
