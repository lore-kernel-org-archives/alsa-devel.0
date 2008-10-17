From: William Pitcock <nenolod@sacredspiral.co.uk>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Fri, 17 Oct 2008 15:48:53 -0500
Message-ID: <1224276533.4088.4.camel@petrie.sacredspiral.co.uk>
References: <s5hy70xsl46.wl%tiwai@suse.de>
	<loom.20081016T120322-319@post.gmane.org>
	<s5h8wso3ejg.wl%tiwai@suse.de>
	<48F739F4.5070303@nostalgicnetworxx.org> <48F74344.4090509@gmail.com>
	<s5hvdvs1wig.wl%tiwai@suse.de> <48F74C91.7040708@gmail.com>
	<s5hprm01v3g.wl%tiwai@suse.de> <48F75284.1040901@gmail.com>
	<s5hljwo1u01.wl%tiwai@suse.de> <48F75700.5060102@gmail.com>
	<s5hfxmw1syu.wl%tiwai@suse.de> <48F75892.8000209@gmail.com>
	<s5hbpxk1shh.wl%tiwai@suse.de> <48F7855F.6060806@gmail.com>
	<s5hbpxj6902.wl%tiwai@suse.de> <48F84554.4060800@gmail.com>
	<s5hr66fzhqt.wl%tiwai@suse.de> <48F861BC.8000504@gmail.com>
	<s5hk5c7zgmb.wl%tiwai@suse.de> <48F86293.90205@gmail.com>
	<s5hhc7bzgf4.wl%tiwai@suse.de> <48F86606.9070108@gmail.com>
	<s5h8wsnzfcu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5613287823325125632=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carpathia.dereferenced.org (carpathia.dereferenced.org
	[64.71.161.129]) by alsa0.perex.cz (Postfix) with ESMTP id 538F324507
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Oct 2008 22:49:45 +0200 (CEST)
In-Reply-To: <s5h8wsnzfcu.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, The Source <thesourcehim@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5613287823325125632==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yBblRV3tfunxJxSQYeN4"


--=-yBblRV3tfunxJxSQYeN4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-10-17 at 12:27 +0200, Takashi Iwai wrote:
> At Fri, 17 Oct 2008 14:16:38 +0400,
> The Source wrote:
> >=20
> > Takashi Iwai =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > At Fri, 17 Oct 2008 14:01:55 +0400,
> > > The Source wrote:
> > >  =20
> > >> Takashi Iwai =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > >>    =20
> > >>> At Fri, 17 Oct 2008 13:58:20 +0400,
> > >>> The Source wrote:
> > >>>  =20
> > >>>      =20
> > >>>> Takashi Iwai =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > >>>>    =20
> > >>>>        =20
> > >>>>> At Fri, 17 Oct 2008 11:57:08 +0400,
> > >>>>> The Source wrote:
> > >>>>>  =20
> > >>>>>      =20
> > >>>>>          =20
> > >>>>>> Takashi Iwai =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > >>>>>>    =20
> > >>>>>>        =20
> > >>>>>>            =20
> > >>>>>>> At Thu, 16 Oct 2008 22:18:07 +0400,
> > >>>>>>> The Source wrote:
> > >>>>>>>  =20
> > >>>>>>>      =20
> > >>>>>>>          =20
> > >>>>>>>              =20
> > >>>>>>>>>> Ok. OpenAL with alsa also seem to cause problems.
> > >>>>>>>>>>    =20
> > >>>>>>>>>>        =20
> > >>>>>>>>>>            =20
> > >>>>>>>>>>                =20
> > >>>>>>>>>>                    =20
> > >>>>>>>>> In both cases, check the period_size and buffer_size values (=
shown in
> > >>>>>>>>> the kernel message, or /proc/asound/card0/pcm0p/sub0/hw_param=
s).
> > >>>>>>>>> And, try to aplay with these parameters, whether you get the =
similar
> > >>>>>>>>> problem.
> > >>>>>>>>>
> > >>>>>>>>> 	% aplay -v --period-size=3Dxxx --buffer-size=3Dyyy foo.wav
> > >>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>>> Takashi
> > >>>>>>>>>
> > >>>>>>>>>  =20
> > >>>>>>>>>      =20
> > >>>>>>>>>          =20
> > >>>>>>>>>              =20
> > >>>>>>>>>                  =20
> > >>>>>>>> I'm sorry, but any attemp to play file with ossplay results in=
 complete=20
> > >>>>>>>> system hang with error:
> > >>>>>>>> unable to handle NULL ponter dereference at address=20
> > >>>>>>>> 0000000000000008.....(hang, no more output).
> > >>>>>>>> I tried many wav formats. So I can't get error log or period a=
nd buffer=20
> > >>>>>>>> sizes, sorry.
> > >>>>>>>>    =20
> > >>>>>>>>        =20
> > >>>>>>>>            =20
> > >>>>>>>>                =20
> > >>>>>>> Can anyone confirm to reproduce Oops with OSS apps (ossplay)?
> > >>>>>>>
> > >>>>>>> I'm wondering whether this has anything to do with the capture.
> > >>>>>>> Can you record the sound, and change the capture mixer element =
properly?
> > >>>>>>>
> > >>>>>>>
> > >>>>>>> thanks,
> > >>>>>>>
> > >>>>>>> Takashi
> > >>>>>>>
> > >>>>>>>  =20
> > >>>>>>>      =20
> > >>>>>>>          =20
> > >>>>>>>              =20
> > >>>>>> I checked mplayer. It uses period size 1024 instead of 4096 and =
16384=20
> > >>>>>> buffer size (default). Sound is choppy (sound pauses is more fre=
quent=20
> > >>>>>> when rate is lower).
> > >>>>>> However an attempt to play the same file with the same period an=
d buffer=20
> > >>>>>> sizes with aplay results in complete system hang.
> > >>>>>>    =20
> > >>>>>>        =20
> > >>>>>>            =20
> > >>>>> OK, that looks like a problem.  Looks like the timer resolution c=
an be
> > >>>>> short like that, or something racy in the timer handling.
> > >>>>>
> > >>>>> Can you check whether this happens with XXX_SYSTEM_TIMER, too?
> > >>>>>
> > >>>>> Or, does the patch below avoid the problem, at least?
> > >>>>>
> > >>>>>
> > >>>>> thanks,
> > >>>>>
> > >>>>> Takashi
> > >>>>>
> > >>>>> diff --git a/sound/pci/sbxfi/sbxfi.c b/sound/pci/sbxfi/sbxfi.c
> > >>>>> index 26a6cd3..5ceb228 100644
> > >>>>> --- a/sound/pci/sbxfi/sbxfi.c
> > >>>>> +++ b/sound/pci/sbxfi/sbxfi.c
> > >>>>> @@ -277,6 +277,7 @@ static void sbxfi_rearm_timer(struct sbxfi *c=
hip, int ticks)
> > >>>>>  #else
> > >>>>> =20
> > >>>>>  #define MAX_TICKS	((1 << 13) - 1)
> > >>>>> +#define MIN_TICKS	1000		/* FIXME: really so? */
> > >>>>> =20
> > >>>>>  static void sbxfi_init_timer(struct sbxfi *chip)
> > >>>>>  {
> > >>>>> @@ -287,6 +288,8 @@ static void sbxfi_set_timer(struct sbxfi *chi=
p, int ticks)
> > >>>>>  	LOG(2, "SET TIMER TICKS =3D %d\n", ticks);
> > >>>>>  	if (ticks > MAX_TICKS)
> > >>>>>  		ticks =3D MAX_TICKS;
> > >>>>> +	else if (ticks < MIN_TICKS)
> > >>>>> +		ticks =3D MIN_TICKS;
> > >>>>>  	sbxfi_write(chip, TIMR, ticks | TIMR_IE | TIMR_IP);
> > >>>>>  }
> > >>>>>  static void sbxfi_stop_timer(struct sbxfi *chip)
> > >>>>>
> > >>>>>  =20
> > >>>>>      =20
> > >>>>>          =20
> > >>>> After patch:
> > >>>>
> > >>>> Without system timer:
> > >>>>
> > >>>> aplay --period-size=3D1024 96000_16_Stereo.wav
> > >>>> Plays fine
> > >>>>
> > >>>> aplay --period-size=3D1024 22050_16_Mono.wav
> > >>>> BUG: unable to handle kernel NULL pointer dereference at 000000000=
0000008
> > >>>> Hang
> > >>>>
> > >>>> With system timer:
> > >>>>
> > >>>> aplay --period-size=3D1024 96000_16_Stereo.wav
> > >>>> Superglitch. Each sample is played many times before advancing to =
next one.
> > >>>>
> > >>>> aplay --period-size=3D1024 22050_16_Mono.wav
> > >>>> Instant reboot.
> > >>>>    =20
> > >>>>        =20
> > >>> Just to be sure: you don't enable XXX_CONT_RATE, right?
> > >>> It's known to be buggy, so disabled as default now.
> > >>>
> > >>>
> > >>> Takashi
> > >>>
> > >>>  =20
> > >>>      =20
> > >> It is disabled for me too.
> > >>    =20
> > >
> > > And the patch didn't help?
> > >
> > >
> > > Takashi
> > >
> > >  =20
> > Only 96000Hz Stereo without system timer plays fine after patch.
>=20
> Please elaborate?  You mean 22.5k still doesn't work with the patch?
> Does 22.5kHz ever work with other parameters?  It'd be really helpful
> if you get the full Oops log...
>=20
> The patch affects only the emu20k1 timer.  The system timer stuff
> isn't touched by it.
>=20
> The reboot implies that it's unlikely the timer but the driver wrote
> something wrong (unless you have the set up that the kernel traps and
> automatically reboot).  But, it's nothing but a wild guess at this
> point.
>=20
> Anyway, I updated the driver code a bit again.  Please check the
> latest one.

Only 96000Hz stereo works here as of 15 minutes ago. Following .asoundrc
stanzas result in a hardware fault and return to BIOS:

pcm.xfi-dmix {
    type dmix
    ipc_key 1024
    slave {
        pcm "hw:2,0"
        rate 96000
    }
}

pcm.xfi0 {
    type plug
    slave.pcm "xfi-dmix"
}

pcm.default pcm.xfi0

Unfortunately, nothing was left in /var/log/kern.log.

William

--=-yBblRV3tfunxJxSQYeN4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBI+Po1oB+26npOQg4RAmiRAJ0XlLIKHcs25jO/NXa12/3e7e9Q1wCgvR7x
SoRn9uv24kVukTjIIKiHuBg=
=fpd5
-----END PGP SIGNATURE-----

--=-yBblRV3tfunxJxSQYeN4--


--===============5613287823325125632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5613287823325125632==--
