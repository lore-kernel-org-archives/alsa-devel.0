From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Add support for multi register
	mux
Date: Thu, 3 Apr 2014 10:53:30 +0100
Message-ID: <20140403095330.GS14763@sirena.org.uk>
References: <1396494710-20944-1-git-send-email-aruns@nvidia.com>
 <s5h4n2asq1o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3975504367628397741=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E98726566F
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 11:53:51 +0200 (CEST)
In-Reply-To: <s5h4n2asq1o.wl%tiwai@suse.de>
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
Cc: Songhee Baek <sbaek@nvidia.com>, Arun Shamanna Lakshmi <aruns@nvidia.com>, alsa-devel@alsa-project.org, lars@metafoo.de, swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3975504367628397741==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LmUdgXdNLPkN/XLh"
Content-Disposition: inline


--LmUdgXdNLPkN/XLh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 03, 2014 at 11:47:15AM +0200, Takashi Iwai wrote:

> I'm a bit late in the game, but I feel a bit uneasy through looking
> at the whole changes.  My primary question is, whether do we really
> need to share the same struct soc_enum for the onehot type?  What
> makes hard to use a struct soc_enum_onehot for them?  You need
> different individual get/put for each type.  We may still need to
> change soc_dapm_update stuff, but it's different from sharing
> soc_enum.

Indeed, I had thought this was where the discussion was heading - not
looked at this version of the patch yet.

--LmUdgXdNLPkN/XLh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPS+XAAoJELSic+t+oim9lHwP/2uZ4nlylfyzTPNCpWjcQXeL
WprHEKyxvF2Sa7mQHQc/MlyQk1yIT+KxkyZWg8GBbtIYgNzYcPGAq4USojFp8xRu
mlBYbm99+ZcD29z6+1Dggfutym47CP5q7Y/dF2pwYOKf3TCXyCU+F1mXbEHibEIV
hh6ohVewYuMlz3J1jGsMTkPkBcDKdSIPC+UP+mS3YQCb+SMhgON2huP+9uN0L2dD
cYPN17nd4YchFew5FZb27CX3TZKS0BhM0uOuPfNqEp5w5tEgf9vCkbq57XvENWq7
yDRzHjEX0VG6v+KhJcN7mImTrvawC53ac2OnCFcw+rX4UTYAQT3Oah1KxiFAgTu9
AQ0cSgI/TOkKuYWyGeRhdzwUALzn2YrHD1tW43uKAfUNKb3rKjrgXGgrgzQQukTi
0L6Qwz6FyJe37mQvBiYVe/Vch+W2Q3DQkQ68P75wTms5ETrLvm83fBfpItFMB5DW
5HDSNWLLK/1aEd5DRR9vyyJNjwPGtyF4CUkxvnqDi0D6+pPNiRqvvdFPK+1HzjuO
VTH09kGBqyzWphdgi087Y4PwWqnIHPQheaPB2mYuww6gev0/64G0ifYEnSU2wFcf
XWiZmaHRTkpErVZ5hEuJ82tfYKW/rQEDZ41pKylN7xiwKMCRkLYbD2sqZS7QSJZL
l/k0omz1xQu+sTbm/Q/0
=7/vO
-----END PGP SIGNATURE-----

--LmUdgXdNLPkN/XLh--

--===============3975504367628397741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3975504367628397741==--
