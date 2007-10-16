From: "Ma Begaj" <derliebegott@gmail.com>
Subject: Re: 1.0.15rc3 patch_analog.s bug + fix
Date: Tue, 16 Oct 2007 14:14:47 +0200
Message-ID: <a72d33330710160514l717e4635yb6e0c97b2449fbd6@mail.gmail.com>
References: <20071015025303.GA17664@jay.phy.queensu.ca>
	<s5hsl4c62fl.wl%tiwai@suse.de>
	<20071015203421.GA6047@jay.phy.queensu.ca>
	<200710161058.19929.anarsoul@gmail.com> <s5hlka347nc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 9693324488
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Oct 2007 14:14:49 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so1058943nzf
	for <alsa-devel@alsa-project.org>; Tue, 16 Oct 2007 05:14:48 -0700 (PDT)
In-Reply-To: <s5hlka347nc.wl%tiwai@suse.de>
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

Hi,

sorry for partly OT and interrupting your conversation. is there
somewhere a patch which corrects muting for AD1986A when playing 2ch
sound when 6ch is selected in the alsamixer?

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D3485

Thanks

M.

2007/10/16, Takashi Iwai <tiwai@suse.de>:
> At Tue, 16 Oct 2007 10:58:19 +0300,
> Vasily Khoruzhick wrote:
> >
> > > > Hmm, the code logic looks correct to me.  If HP jack is present, the
> > > > internal speaker should be muted.  Otherwise it follows the state of
> > > > HP jack (muted/unmuted, that acts as a master switch).
> >
> > Original patch:
> >       present =3D snd_hda_codec_read(codec, 0x1a, 0,
> >                                    AC_VERB_GET_PIN_SENSE, 0) & 0x800000=
00;
> >
> > Code in alsa (patch-analog.c line 614):
> >
> >       present =3D snd_hda_codec_read(codec, 0x1a, 0, AC_VERB_GET_PIN_SE=
NSE, 0);
> >       spec->jack_present =3D (present & 0x80000000) !=3D 0;
> >
> > Seems to have quite different logic, don't it?
>
> I don't see your point.  It's the same logic:
>
>   If present has bit 0x80000000, spec->jack_present =3D 1,
>   Otherwise, spec->jack_present =3D 0.
>
> The problem is that the jack detection of this codec (or specific to
> the laptop) seems inverse from the standard.
>
> > Should be:
> >
> >       present =3D snd_hda_codec_read(codec, 0x1a, 0, AC_VERB_GET_PIN_SE=
NSE, 0);
> >       spec->jack_present =3D (present & 0x80000000) =3D=3D 0;
> >
> > P.S. It's very sad that you've released 1.0.15 with that bug :(
>
> Yes, it's sad.  Too late recognized.  We'll likely have 1.0.15a
> release soon later, though.
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>


-- =

Glauben hei=DFt nicht wissen wollen, was wahr ist ... Nietzsche
