From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-pcm: Use valid condition for
 snd_soc_dai_digital_mute() in hw_free()
Date: Mon, 2 Dec 2013 12:19:16 +0000
Message-ID: <20131202121916.GX27568@sirena.org.uk>
References: <1385976874-30755-1-git-send-email-b42378@freescale.com>
 <s5hli038t5g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6204912777078113840=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F6AB261A99
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 13:19:23 +0100 (CET)
In-Reply-To: <s5hli038t5g.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6204912777078113840==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E6cJGRvJdK5HoYjj"
Content-Disposition: inline


--E6cJGRvJdK5HoYjj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 02, 2013 at 11:05:31AM +0100, Takashi Iwai wrote:
> Nicolin Chen wrote:

> > The snd_soc_dai_digital_mute() here will be never executed because we only
> > decrease codec->active in snd_soc_close(). Thus correct it.

> A couple of minor problems by this approach:

> - snd_soc_dai_digital_mute() will be called twice in the normal PCM
>   close path.

Right, it's called in close() so it's redundant to call it here most of
the time.  On the other hand it will at least get called slightly sooner
which is good and in the case of reconfiguration we'll mute while doing
that - doing the mute earlier is better.

> - In full duplex mode where both playback/capture streams share the
>   same codec, one of the directions won't be handled correctly because
>   codec->active is incremented/decremented twice (once for each
>   direction).

Indeed, the check needs to be on playback_active or capture_active
rather than on the overall DAI.

--E6cJGRvJdK5HoYjj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnHrBAAoJELSic+t+oim9/coP/1jkJjURL3tobXy0GmSd5epi
JFHyaPkU/9fHqs8BECwF9mEqhG+O1OyAkZJx79ca2/Vgc8U4JdxTGiEvNlg8Cxvh
n27CMV8jGTFpq9X5g3K1EdQbYZ8ihg4ea821nYOiAsgeO7JQHE+BcteakPQkiimn
rdEdt3cPCjlcHlGEssVNtk18VAlteoxeWn25Yfehm6Z4QupVNb+gc/LUKD+OhS6U
UwUvUOYo4bZdxEMUwCCXYUjbEu7314nAGGTRe3Uvnb20sMie3HR8SKgsT6XEGSEI
/5jRiQ2s0vqY4QgIK6tSktO1OO8dxBrM2aRYyubiP2hrqrheB9HOyhpOr8wYtIKu
ZGSJooCw/pNai8Et4EVcO77BtBmbaiiolVv71EMRem0ChuZ9I6m6PwpqnibDNIXN
2LrbnpPcnUyhd5Xk40R+5/D4o7w55nGlwLohPu8jX8ofrHhNZIf9hzuqRWToHAVH
kWLSTK5ZlIjoTud/QHrq60JwNkalbs8Yjk4cA1qIff8iUx2XBOiWI5biwZn3UW/k
9iEPUBOjvoMtCfL9OG7QO+meOfC6Arm1UELej6IcRmu+Hj3yJjnnVn47+pGOkkwn
X3SYRLSbJJ11jG12JB0AnzuQ57odLw+CHfCSai0E5AQuyWm+/nSXH+6QjpqXL/+B
rgd+P7IXdXAVU4rjenIB
=IGHE
-----END PGP SIGNATURE-----

--E6cJGRvJdK5HoYjj--

--===============6204912777078113840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6204912777078113840==--
