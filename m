From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: Re: au88x0_synth
Date: Wed, 30 Mar 2005 10:13:23 +0200
Message-ID: <200503301013.30400.alien999999999@users.sourceforge.net>
References: <423CCDAC.80401@netvigator.com> <s5h4qf44vna.wl@alsa2.suse.de> <424A5D7D.2070400@netvigator.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2963316.PSjMGm1BoU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <424A5D7D.2070400@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Raymond <rayau@netvigator.com>
List-Id: alsa-devel@alsa-project.org

--nextPart2963316.PSjMGm1BoU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

while you guys are working on that driver, is there anyone that has a 64bit=
=20
setup? if not, i'd like to test out your driver in 64bit. i still have a=20
number of issues with it (my card is an au8810).

i cannot regularly check it, cause i only have one PC and it's a server, bu=
t=20
at nighttimes, i guess i can test it out a little.

good luck, AL13N

Op woensdag 30 maart 2005 10:04, schreef Raymond:
> Takashi Iwai wrote:
> > Raymond wrote:
> >>>>Lee Revell wrote:
> >>>>Looks like this chipset has a wavetable synth.  And I noticed some
> >>>>references to a driver on the openvortex list.  Would it be possible
> >>>>for ALSA to support it?
> >>>
> >>>Manuel Jander wrote:
> >>> Of course, but there are some unresolved hardware issues. The
> >>> WaveTable helper hardware is very similar to the trident
> >>> Wavetable helper hardware. It does not interpret MIDI directly, but
> >>> at least does some effect processing in hardware.
> >>
> >>http://sourceforge.net/mailarchive/message.php?msg_id=3D6004190
> >>
> >>1) Is the Trident Wavetable working ?
> >
> > Very limited.  It's no proper "MIDI" wavetable implementation.
> > IIRC, only a module player worked with trident driver.
>
> http://www.alsa-project.org/~frank/alsa-sequencer/node12.html
>
> The midi port only need to support 16 voices, the 16 sample rate
> convertors are just enough to produce 16 voices using the mono sound
> samples in the soundfonts au30gm.arl
>
> http://www.alsa-project.org/alsa-doc/alsa-lib/seq.html
>
> Please correct me if I am wrong, there seem to be no documentation on
> those ALSA sequencer functions such as snd_seq_create_kernel_client,...
>
> What will be needed for a proper "MIDI" wavetable implementation ?
>
> Manuel Jander wrote:
> > Raymond wrote:
> >>The "vortexcontrol" use alsa-lib API to play the audio
> >>samples inside au30gm.arl through hw:0,0.
> >
> > Thats because its just for hearing a sample. Its not even close to
> > what has to be done for a Wavetable implementation. The higher level
> > arl soundbank interpreter is very valuable, but on the hardware side
> > we are missing the WT engine support.
>
> In snd_vortex_playback_hw_adb, .rates =3D SNDRV_PCM_RATE_CONTINUOUS
>
> 1) Can the sample rate convertor be used to perform pitch shift ?
>
> 2) Can panning be done by changing the mixin-mixout gain for left/right
> channels of each voice ?
>
> The current alsa driver do not even use the timer VORTEX_SMP_TIME or
> timer interrupt VORTEX_SMP_TIMER
>
> 3) Is there any way to find out the resolution of the timer ?
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

--nextPart2963316.PSjMGm1BoU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCSl+quBWKXETrtdcRAuiZAJ46T08+EX+ZurHMaB0aWeVfc5NAhgCdFMMS
OhAi2g9hhd8YOk7Fe47znwg=
=2rVl
-----END PGP SIGNATURE-----

--nextPart2963316.PSjMGm1BoU--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
