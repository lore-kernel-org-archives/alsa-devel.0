From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: VT8233/A/8235 Clock Problem
Date: Tue, 9 Dec 2003 00:04:55 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031208210455.GF1802@sirius.home>
References: <Pine.HPX.4.33n.0312081003040.24764-100000@studcom.urz.uni-halle.de> <1070914615.1921.24.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KJY2Ze80yH5MUxol"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1070914615.1921.24.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 08, 2003 at 12:16:55PM -0800, Mark Knecht wrote:
> On Mon, 2003-12-08 at 01:05, Clemens Ladisch wrote:
> > This is a module option; instead of changing this line, you are
> > supposed to put the following line into modules.conf:
> > 
> >   options snd-via82xx ac97_clock=44100
> > 
> > (or, if an options line for this module already exists, add it there)
> > 
> > 
> > HTH
> > Clemens
> 
> Clemens,
>    Hi. This option did not fix my sound problems with the Via 8235. It
> still sounds like it's resampling the sound. I hear artifacts all over
> the place. 
> 
>    I do think the option worked since the PCM stuff now says it's
> running at 44100, but I wonder if there is another option for the spdif
> side, or is there a bug in that the driver should be setting this at the
> same time? I'm not using spdif on this motherboard, but possibly when it
> runs at 48K that makes the hardware do something to the PCM data?
> 
>    alsaplayer and xmms both sound equally bad though OSS. alsaplayer
> says it's playing at 44100. alsaplayer through Jack and my HDSP 9652
> sounds good.

Most likely you need the dxs_support option instead of ac97_clock.

With dxs_support=2 the sound should work fine, but the hardware mixing
capability will be disabled.  Then you can try dxs_support=1 or
dxs_support=4.

By default snd-via82xx uses dxs_support=3 (except for certain known
motherboards), this makes only 48000 sampling rate available.  The
ALSA library can perform resampling for ALSA apps, and the kernel OSS
emulation layer can do resampling for OSS apps, but the quality is
often not good.

--KJY2Ze80yH5MUxol
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/1Od3W82GfkQfsqIRAiUTAJ9P1UGjrZtolQ6PV6y5Lw6r8N1k4wCfZI8h
Y5gVgcs0B8/Y/ShmET3uQE8=
=4LrY
-----END PGP SIGNATURE-----

--KJY2Ze80yH5MUxol--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
