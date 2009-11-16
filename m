From: "Wael Nasreddine (a.k.a eMxyzptlk)" <mla@nasreddine.com>
Subject: Re: HDA Intel IDT 92HD71B7X - HP Pavilion DV7-1299EF -
	Only the left speaker is working
Date: Mon, 16 Nov 2009 18:22:56 +0100
Message-ID: <d3328e7b0911160922n681600a4hfe93b80daaa9265e@mail.gmail.com>
References: <d3328e7b0911110722l27597a8bl523052b035e9ec9d@mail.gmail.com>
	<d3328e7b0911120146o317cd32fnc3282a2809aa908f@mail.gmail.com>
	<s5htyx0cak5.wl%tiwai@suse.de>
	<d3328e7b0911140446j6edf0646x5ca7c825ae780a0a@mail.gmail.com>
	<s5htywxmf7d.wl%tiwai@suse.de>
	<d3328e7b0911140625u745f08cdsd0f673c1482bf364@mail.gmail.com>
	<d3328e7b0911150826l6b6fffd6kdad8fb1692445b20@mail.gmail.com>
	<s5hmy2migde.wl%tiwai@suse.de>
	<d3328e7b0911160907g600fda62jc7022e980d98419f@mail.gmail.com>
	<s5haaymie6c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e65b5dccd6627e0478804315
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 7CB91245CF
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 18:23:19 +0100 (CET)
Received: by bwz9 with SMTP id 9so16429242bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 09:23:18 -0800 (PST)
In-Reply-To: <s5haaymie6c.wl%tiwai@suse.de>
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

--0016e65b5dccd6627e0478804315
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2009 at 18:15, Takashi Iwai <tiwai@suse.de> wrote:
>
> At Mon, 16 Nov 2009 18:07:40 +0100,
> Wael Nasreddine (a.k.a eMxyzptlk) wrote:
> >
> > Thank you that actually worked, I have now both Front Left and LFE work=
ing,
> > but it's very hard to tell coz the LFE is louder than both front speake=
rs I
> > even put my ear directly on the speaker and it still can't be 100% sure=
, but
> > I think that for now what is working is 'Front Left + LFE', I can't hea=
r
> > anything from the right speaker.. but it's already an improvement to wh=
at I
> > had.
>
> Hm, if it's *so* loud, we should have a mixer control for this, I
> guess.
>
It's not *so* loud, but yea I appreciate a mixer for it yes! at least
I can tell which speaker is working and also I can listen to Music
without bothering someone else because with LFE the base is loud..

>
> > Do you have any suggestion on how to enable the right speaker?
>
> No, already out of idea... =C2=A0I wonder whether any other people
> suffering from the same problem?
>
Julien has the same PC, same OS, same Kernel, same BIOS Version, but
the weird thing is that he is not suffering from this problem, which
obviously led me to beleive a hardware defect, but it's working on
Windows!

@Julien, could you plz try the patch (attached
enable-lfe-on-dv7.patch) against
ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-sna=
pshot.tar.gz
? and Tell us if it changes anything for you?

>
> thanks,
>
> Takashi



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

--0016e65b5dccd6627e0478804315
Content-Type: application/octet-stream; name="enable-lfe-on-dv7.patch"
Content-Disposition: attachment; filename="enable-lfe-on-dv7.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g23i372u0

ZGlmZiAtTmF1ciBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYyBiL3NvdW5kL3BjaS9o
ZGEvcGF0Y2hfc2lnbWF0ZWwuYwotLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3NpZ21hdGVsLmMJ
MjAwOS0xMS0xNiAxNTozODoyNi4wMDAwMDAwMDAgKzAxMDAKKysrIGIvc291bmQvcGNpL2hkYS9w
YXRjaF9zaWdtYXRlbC5jCTIwMDktMTEtMTYgMTc6NDY6MzcuMDIzMzYwOTEzICswMTAwCkBAIC01
NDY4LDYgKzU0NjgsMTggQEAKIAkJYnJlYWs7CiAJfQogCisgICAgICAgLyogZW5hYmxlIExGRSBv
biBIUCBkdjcgaWYgYXZhaWxhYmxlICovCisgICAgICAgaWYgKHNwZWMtPmJvYXJkX2NvbmZpZyA9
PSBTVEFDX0hQX0RWNSkgeworICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGNhcDsKKyAgICAg
ICAgICAgICAgIGNhcCA9IHNuZF9oZGFfcGFyYW1fcmVhZChjb2RlYywgMHgxLCBBQ19QQVJfR1BJ
T19DQVApOworICAgICAgICAgICAgICAgY2FwICY9IEFDX0dQSU9fSU9fQ09VTlQ7CisgICAgICAg
ICAgICAgICBpZiAoY2FwID49IDYpIHsKKyAgICAgICAgICAgICAgICAgICAgICAgc3BlYy0+Z3Bp
b19tYXNrIHw9IDB4MjA7CisgICAgICAgICAgICAgICAgICAgICAgIHNwZWMtPmdwaW9fZGlyIHw9
IDB4MjA7CisgICAgICAgICAgICAgICAgICAgICAgIHNwZWMtPmdwaW9fZGF0YSB8PSAweDIwOwor
ICAgICAgICAgICAgICAgfQorICAgICAgIH0KKwogCWlmIChocF9ic2VyaWVzX3N5c3RlbShjb2Rl
Yy0+c3Vic3lzdGVtX2lkKSkgewogCQlwaW5fY2ZnID0gc25kX2hkYV9jb2RlY19nZXRfcGluY2Zn
KGNvZGVjLCAweDBmKTsKIAkJaWYgKGdldF9kZWZjZmdfZGV2aWNlKHBpbl9jZmcpID09IEFDX0pB
Q0tfTElORV9PVVQgfHwK
--0016e65b5dccd6627e0478804315
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016e65b5dccd6627e0478804315--
