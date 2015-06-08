From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: wm8741: Allow master clock
 switching
Date: Mon, 8 Jun 2015 19:00:06 +0100
Message-ID: <20150608180006.GP14071@sirena.org.uk>
References: <1433582748-30086-1-git-send-email-ce3a@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2877158406753052392=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ED0972604C7
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 20:00:20 +0200 (CEST)
In-Reply-To: <1433582748-30086-1-git-send-email-ce3a@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <ce3a@gmx.de>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, ckeepax@opensource.wolfsonmicro.com, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org


--===============2877158406753052392==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HditFSw+SJxJh6AP"
Content-Disposition: inline


--HditFSw+SJxJh6AP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 06, 2015 at 11:25:48AM +0200, Sergej Sawazki wrote:
> The set of supported sample rates depends on the master clock supplied
> to the codec. Allow the machine driver to set the required master clock
> in hw_params().

Applied, thanks.

--HditFSw+SJxJh6AP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJVddglAAoJECTWi3JdVIfQgBAH9jn/V0G5jDVmQ+7Z8WpE3xCD
rrGFnIvHharckMrGRW91zgsrLaHvmdtGdC8dsMtf1U3QMmWXNA3UpXdf6Bz7SyKK
kPS0GPSbwT4q52DYT6dz7LfZbY+WttRT5CuWEfMRgqAUQTwtzdX9KlHb/JDHF+pJ
yML0DHuNceefKV/E94tzrFD7X8DCK08P90DDiQKA5BVeVCDw42lBajlwPy7zOl5f
W8fbVE8hmlbd/3XhzIF5ujzdbwI8cJFaq8nDVUjclR41lovTKd/4Y2hzJVBodqAx
TPB+AUwRWbyQ3PRvn08HEqk57CijB3I2RQ2J+Tty2l6Nqx1GggKS5jUalG4GvA==
=ciVj
-----END PGP SIGNATURE-----

--HditFSw+SJxJh6AP--

--===============2877158406753052392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2877158406753052392==--
