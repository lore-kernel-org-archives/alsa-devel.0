From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: dapm: Add snd_soc_dapm_switch to
 the power up/down sequence table
Date: Fri, 14 Jun 2013 12:41:55 +0100
Message-ID: <20130614114155.GN1403@sirena.org.uk>
References: <1371208614-18697-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0256843469187021897=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DE2402650C1
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 13:41:58 +0200 (CEST)
In-Reply-To: <1371208614-18697-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============0256843469187021897==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T2TLPR1GNug0LD4g"
Content-Disposition: inline


--T2TLPR1GNug0LD4g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 14, 2013 at 01:16:50PM +0200, Lars-Peter Clausen wrote:
> The power up/down sequence order for DAPM switch widgets is not explicitly
> initialized, causing them to be run always as the first widget type for both
> power up and down. Move it to the same position in the sequence as other mixer
> widget types.

Applied all, thanks.

> Cc: stable@vger.kernel.org

but this seems a bit hasty - there are existing users of this who
haven't been complianing, changing the sequencing underneath them may
cause some unintended breakage if they've somehow been relying on the
existing behaviour.  It doesn't seem safe enough for a stable fix,
people ought to be able to blindly take the stable kernel updates.

--T2TLPR1GNug0LD4g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuwGAAAoJELSic+t+oim9j6EQAJazC7SQqmWShrtHqCXpkwml
5E58QET6myy/N6o/JDrcxo6eu3J/Gm2k0emU068x47fA/RlLD2xEnqO99mWQGtA8
blVKSlJYZ/To6zPe3HV9Jp9hHBA5SPxECc+2G0B3PI/yqXJg2TvriKycihlhZts2
3/6iKu+5Nwn016fzyeFxRGHY4CGFM4j58tTvh523ZpGTFKT9KgMxPgbg3NZPsba/
0jRJRH00MRZSyMyZ8GoO/VdlWp2zFHoBNrT5c7nMHw57QpUWESq8lKAZSFtcmuro
u8YUZHosnvfBOKFpf11X+9nfNOaFhqhIl3gB/HJ5I+USeHbPc+yK++eJ1xZbwrTi
lKtd5dgHu3hR4yALS3nQcRdDL58WoEtvOY3CKKOJvOTjySd+/W9LPinBXAqomNif
xHRkCiMz5puxYurAhi7nWPzVZoYCY4UNzVIzebyi5rSK5n6zy3yfRO8aPqhb4NoE
npV3QSANcJ9Ch7RzR+YewuvqEBy/qt6jTEbyJb/ZHjrKh6s/WWnBQ20Mq78H553l
8aoYaHfsK/0ggQxdeVqj/q3RvWRayon4peazcP4k6jDlo334L6Ry7c9LVJD0RmpW
YPWJnvhN7bzQIGhfPgYB3lfqtN2cvhKWsHvNOkj/s1eSfu8APQp4uAQUkXa6KmRO
h7QBBmrEgtgQ9oO1i7LR
=wiHU
-----END PGP SIGNATURE-----

--T2TLPR1GNug0LD4g--

--===============0256843469187021897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0256843469187021897==--
