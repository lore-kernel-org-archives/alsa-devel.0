From: "Ma Begaj" <derliebegott@gmail.com>
Subject: Re: [Alsa-user] Asus M2NPV-VM snd_hda_intel problem -
	also with Alsa 1.0.15rc3
Date: Tue, 9 Oct 2007 11:46:02 +0200
Message-ID: <a72d33330710090246m41f87f0dg85f513abdea8788a@mail.gmail.com>
References: <a72d33330709281229v1144cf03r31db37581ccb9a49@mail.gmail.com>
	<a72d33330709290651g5cc9099fqe1d8b01d061ba474@mail.gmail.com>
	<46FE76BA.1050702@gmail.com>
	<a72d33330709291245n18dac599n74df164b4ac7a1fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B2202464D
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Oct 2007 11:46:04 +0200 (CEST)
Received: by rv-out-0910.google.com with SMTP id k20so821034rvb
	for <alsa-devel@alsa-project.org>; Tue, 09 Oct 2007 02:46:02 -0700 (PDT)
In-Reply-To: <a72d33330709291245n18dac599n74df164b4ac7a1fa@mail.gmail.com>
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
To: alsa-devel@alsa-project.org, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I see that something is going on the list and that people which solved
a lot of problems with AD1986A chip are active on the list, but there
were no answers on this topic.

I am sorry if I posted this to the wrong list(s), but I would really
appreciate any hints to solve the problem with my sound.

Sound is muting as soon as I change volume, and I tried a few different pat=
ches.
I am loosing ideas and sometimes alse motivation.

Thanks for any hints, ideas, help, whatever.

M.



2007/9/29, Ma Begaj <derliebegott@gmail.com>:
> > Firstly, I don't have the same board. Similar, but different.
> >
> > I have an Asus A8N-VM CSM board, but it has the same AD1986A chip on it.
> > I didn't have the same issue with sound muting, but I did have issues
> > with surround (it just didn't work). I don't remember the details of how
> >
> >
> > --- patch_analog.c.backup       2007-04-14 11:01:17.209146249 +0100
> > +++ patch_analog.c      2007-04-14 13:37:47.005206476 +0100
> > @@ -895,14 +895,14 @@
> >          case AD1986A_3STACK:
> >                  spec->num_mixers =3D 2;
> >                  spec->mixers[1] =3D ad1986a_3st_mixers;
> > -               spec->num_init_verbs =3D 3;
> > +/*             spec->num_init_verbs =3D 3;
> >                  spec->init_verbs[1] =3D ad1986a_3st_init_verbs;
> > -               spec->init_verbs[2] =3D ad1986a_ch2_init;
> > +               spec->init_verbs[2] =3D ad1986a_ch2_init; */
> >                  spec->channel_mode =3D ad1986a_modes;
> >                  spec->num_channel_mode =3D ARRAY_SIZE(ad1986a_modes);
> >                  spec->need_dac_fix =3D 1;
> > -               spec->multiout.max_channels =3D 2;
> > -               spec->multiout.num_dacs =3D 1;
> > +               spec->multiout.max_channels =3D 6;
> > +               spec->multiout.num_dacs =3D 3;
> >                  break;
> >          case AD1986A_LAPTOP:
> >                  spec->mixers[0] =3D ad1986a_laptop_mixers;
> >
>
>
> thanks for your try.
> it helped partly ...  I tried 3 patches (incl. yours) and only yours
> helped partly at least.
> I patched Alsa 1.0.15rc3.
>
> Sound mutes as soon as I change volume, and I can only rmmod/modprobe
> snd-hda-intel to get it back.
>
> But Surround is working with your patch as I can see:
> "speaker-test -Dplug:surround51 -c6 -t waw" recognizes correctly all spea=
kears.
>
> "speaker-test -c6 -t waw" does not recognize the speakers correctly,
> but it probably should not, or ?!
>
> MythTv is playing stereo files only on the right speakers. I do not
> now is this a MythTv or Alsa problem. probably MythTv and I should
> create a .asoundrc which should correct this somehow.
>
>
> I did not try hg, because I thought that Alsa 1.0.15rc3 is very new.
>
>
> Thanks.
>
> M.
>


-- =

Glauben hei=DFt nicht wissen wollen, was wahr ist ... Nietzsche
