From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: Re: au88x0_synth
Date: Mon, 6 Jun 2005 10:49:37 +0200
Message-ID: <200506061049.40902.alien999999999@users.sourceforge.net>
References: <423CCDAC.80401@netvigator.com> <200505151441.18029.alien999999999@users.sourceforge.net> <42A3BB75.9030006@netvigator.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart58852288.OQQyeoMREW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42A3BB75.9030006@netvigator.com>
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

--nextPart58852288.OQQyeoMREW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Op maandag 6 juni 2005 04:56, schreef Raymond:
> Alien wrote:
> > I'd like to have other stuff fixed first, if you don't mind, my volume =
is
> > randomly changing at certain points (the 32bit compile didn't have that)
> > and sometimes the audio modules hang (since that patch, i haven't had
> > that problem anymore).
> >
> > furthermore, i notice that I can't choose between 41000 and 48000 Hz
> > anymore in alsamixer, and that the equalizer sliders look odd (though i
> > never used them). i can tell you only what changed versus the 32bit mod=
e,
> > and with/without the patch.
>
> The enumerated SPDIF sample rate (32000,44100,48000) control has been
> replaced by the IEC958 control.
>
> http://sourceforge.net/mailarchive/message.php?msg_id=3D11102457
>
> The easy way is to use "vortexcontrol" to set the 10-bands
> (31,63,124,250,500,1K,2K,4K,8K,16K Hz) stereo equalizer to Jazz, Pop,
> Classical, Rock, Dance or user defined, otherwise you need to use
> alsamixer to set the equalizer in bypass mode.
>
> Do "vortexcontrol" need any patch to work in 64-bits platform ?

i have no idea, i never used it.

> >>Would you post the content of /etc/modprobe.conf ?
> >
> > I'm not using that right now:
> >
> > if i want to use sound after bootup (which doesn't happen often at
>
> all), I do:
> > modprobe snd-au8810
> > modprobe snd-emu10k1
> > modprobe snd-pcm-oss
> > alsactl restore -f /data/path/mixer
>
> Why do you use dmix when both cards support hardware mixing ?

i don't use dmix, this aplay -L output comes from my distro,  right now, i'=
m=20
using either default, or plug:hw:1 (for the SBLive, connected to a surround=
=20
heaphone)

> http://sourceforge.net/mailarchive/message.php?msg_id=3D9585516
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
> This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you
> shotput a projector? How fast can you ride your desk chair down the office
> luge track? If you want to score the big prize, get to know the little gu=
y.
> Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=3D20
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

--nextPart58852288.OQQyeoMREW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCpA4kuBWKXETrtdcRAms3AKDLCMLOYzUvO3oF517WyCNzGYqf4gCghG9g
tjdd+mc+JRjppcdvU0hxfhg=
=/eaW
-----END PGP SIGNATURE-----

--nextPart58852288.OQQyeoMREW--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
