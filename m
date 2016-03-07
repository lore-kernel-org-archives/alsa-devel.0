From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5616: add kcontrol for headphone
	channel switch
Date: Mon, 7 Mar 2016 09:45:03 +0700
Message-ID: <20160307024503.GP18327@sirena.org.uk>
References: <1456910320-6979-1-git-send-email-john.lin@realtek.com>
 <20160302103535.GH18327@sirena.org.uk>
 <14AE6189BDA733429BF8455FEEF632980110FFD1@RTITMBSV02.realtek.com.tw>
 <20160305035137.GX18327@sirena.org.uk>
 <14AE6189BDA733429BF8455FEEF632980111074D@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7957839495780192671=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A7402607F7
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 08:13:35 +0100 (CET)
In-Reply-To: <14AE6189BDA733429BF8455FEEF632980111074D@RTITMBSV02.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Lin <john.lin@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, "zhengsq@rock-chips.com" <zhengsq@rock-chips.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============7957839495780192671==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="avnYMkYztPzqTqBp"
Content-Disposition: inline


--avnYMkYztPzqTqBp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 07, 2016 at 02:35:55AM +0000, John Lin wrote:

> > No, you should call it "Headphone Playback Switch".  Please see
> > ControlNames.txt for details.

> The schematic diagram of headphone is such as:

> DAC --> HP Vol --> HP Vol Mute --> HP MIX --> HP Mute

> The kcontrol named 'Headphone Playback Switch' was in use for 'HP Mute'.
> The missing kcontrol is 'HP Vol Mute' in schematic diagram.
> Could you give us advice in this case? Thank you very much.

My point is that you shouldn't have both Volume and Switch in the same
control name.  You could for example call them Headphone Switch and
Headphone Playback Switch.

--avnYMkYztPzqTqBp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW3OsuAAoJECTWi3JdVIfQZFMH/3BSn66qoNgxAfwaSU5ukIui
TT8aPDSr/j7jl6viZtW7WJ6w/17Hd7hRY00LRX+2wr3/ooXURklqqUMpNnyTP6x0
XG9J5XUmuiG0jVmGiJlkVEnh9KiYEKX5lb9kapnhxscoZYmVc6o8TAj/2GzAEnrs
KC+C2vKBVneIRaA2eF/7RPll9E6t/UhrmuGs7tfxGr/c4uh2Z3FWWtc1p6j7FxFX
/0l7ap9yT0fE1Rma4dJ9b5vytwje86NP8QCJbZ/Q8Ev32gqM7nJLlH1hWyCm7XEm
PtMnTjwEEkaICrrFvvr9hb3A/f+ZbxdAkIps6MwhP5Y1/iGS0MULQMZSr3ijrDc=
=3V4k
-----END PGP SIGNATURE-----

--avnYMkYztPzqTqBp--

--===============7957839495780192671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7957839495780192671==--
