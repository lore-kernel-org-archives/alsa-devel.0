From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/31] ASoC: wm2000: Use WARN_ON() instead
	of BUG_ON()
Date: Wed, 6 Nov 2013 10:31:40 +0000
Message-ID: <20131106103140.GO11602@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-7-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1256891526064373005=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D744926171B
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:31:42 +0100 (CET)
In-Reply-To: <1383673218-18405-7-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1256891526064373005==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7gLe/sNPhR777EPF"
Content-Disposition: inline


--7gLe/sNPhR777EPF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 06:39:53PM +0100, Takashi Iwai wrote:
> BUG_ON() is rather useless for debugging as it leads to panic().
> Use WARN_ON() and handle the error cases accordingly.

Applied, thanks.

--7gLe/sNPhR777EPF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSehqJAAoJELSic+t+oim9zOgP/2yLlBvJfmo/eFqLEO9UpOSx
7rG8WwgAFBhYnXmQTCHm/jplE+gOr2J7/5b6D4R9zxsPUbGt0uFITl5uSfWWOCRB
/EZESMA6AAcgt2u1LaBz8oFwMLn+HdsqM53Igc9KuRJ4KEHlH6tRzhPTxe+LBH5Q
cyCKTRkb9rwONqUF1FGoTbtNeQHmaYhmUyU38F5/565lnQVr4bJX1LXlyEJOoRHN
47D7fVNNz9CD+7X5ldWYHjlRuNut4qcWVP8IbTo6PK1LBW8T08NjfjuJfcwLmy69
TuIisjfLzQUoMvagEE7tlQ9pqn02jx9jALpAeg7X2DZ4pY1CElk/EDDTF+MXadle
SFyExTPaOQHN7jC+zIwYwqK6c7Xljr+lo38e9q8tErTQ/aRVSzMeXJ8HJ/ntkryL
ggpzDfE4jVbVNCJrxkU4AZs1zBhqVtGNjRLzaGJgrQx7fQY/ozsouV7ld5sZwA1c
HWxIDZVlN9zQW7o16Wl4+blMPhiqi+60C1wVLm7r8gafc4Wit8l7S2XJT0GbKbbF
Xq2CpNDFlMPMDqyDZnjIPdl4+NRXyu+AVDOkO2VW/rbTwzEg184ETJqobZ7NMOZR
7G/esQvMRYTleyHiO7bKXO/0AupBK6jvWIyy8FYItVbBAutZSYJcZPksHpB1Cz/x
w72aMG42P8t2ZQluqfL1
=C6vy
-----END PGP SIGNATURE-----

--7gLe/sNPhR777EPF--

--===============1256891526064373005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1256891526064373005==--
