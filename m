From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/9] ASoC: ab8500: Fix invalid cast to long
	pointer
Date: Wed, 30 Oct 2013 09:34:16 -0700
Message-ID: <20131030163416.GD2493@sirena.org.uk>
References: <1383118507-21503-1-git-send-email-tiwai@suse.de>
 <1383118507-21503-4-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8688133596998157563=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B944126553D
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 18:10:55 +0100 (CET)
In-Reply-To: <1383118507-21503-4-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8688133596998157563==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Content-Disposition: inline


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2013 at 08:35:01AM +0100, Takashi Iwai wrote:
> Don't cast to long pointers blindly just for using find_first_bit()
> and co.  This is certainly not portable at all.

Applied, thanks.  Please CC people working on the relevant code.

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScTUEAAoJELSic+t+oim9iMAP/3AlCbvNRv8nz4zZ8nCyOWZ6
VwGhzeF21ifeLKjG7m6H5VN7L554PakLUWaPSl2kWah4AZHmVdzC0qGZxGHzZ3Co
DDWqqfovmn/8s7yWE7hnVtDc6M4cu8zWcystU6FXHaYEI+6usizYTzys3OVX0IRl
GghnkMcjE8MjRkndaRS2Z/RgoBytahVp7txFrDOxTvopXJROKY9d4Dc8X27eCsRM
eHmvsJO0hq5ONexNU8OXpg7rCbSUpIbm8WVqfa/1OjEp/LsMyI6jc3w/6UWqjCA9
7qhLFvfbuxFF0T+tVk8meOXUW71HdtLDXZejyaFifE/YTg4ZYO40Ht3lkdz9c6J5
dr1ET07ytO8wmzm4GzxDXqc8KMnHS5pDRA8anFA7bVNmTB4oEGnh1NYseSXZJQJA
ALS6Sw22w2pfNOdlSxQ4log0LTemf7VjJ9Jjvhvf3m+zk3eZvDZLiZPGnihqB85t
crGsBzCs23qA3SsvnTas1oYiAhoPHQ+WfnypEsRECr5qJRc+mPIE6641a3EUrT1+
tlzwJBNRoZ8/rLKqUYzxAZ4ake9lw8Jt2sREW60nM+QA8dCD9sWxsWEXLfm1cuuw
jiMUuGtPVhWR0rdFiDVLVAMxx1AUJEz2amdd/WJmDdJS04tGq9mW0mPQEomrRzco
ujeg43FLnpLpBndoNasc
=IITH
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--

--===============8688133596998157563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8688133596998157563==--
