From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt274: Variable "buf" in function
 rt274_jack_detect() could be uninitialized
Date: Mon, 7 Jan 2019 16:58:34 +0000
Message-ID: <20190107165834.GL9570@sirena.org.uk>
References: <20190104202708.14759-1-yzhai003@ucr.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4792289130476955809=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0411A266AB2
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 17:58:48 +0100 (CET)
In-Reply-To: <20190104202708.14759-1-yzhai003@ucr.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yizhuo <yzhai003@ucr.edu>
Cc: csong@cs.ucr.edu, Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, zhiyunq@cs.ucr.edu, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============4792289130476955809==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UK1lfQXsnwKrySH9"
Content-Disposition: inline


--UK1lfQXsnwKrySH9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 04, 2019 at 12:27:08PM -0800, Yizhuo wrote:
> In function rt274_jack_detect(), local variable "buf" could
> be uninitialized if function regmap_read() returns -EINVAL.
> However, it will be used to calculate "hp" and "mic" and
> make their value unpredictable while those value are used
> in the caller. This is potentially unsafe.

This doesn't apply against current code, please check and resend.

--UK1lfQXsnwKrySH9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwzhTkACgkQJNaLcl1U
h9BfYAf9HvrQb91OEUf4LOhKH18sRQCLgHXtlFFN/H7s1ST+zIQONgvRr0X3UrHT
iiMU0dGygbKV4KNin/sZqJSrHEKJkXc2gSAV1S8iSEgb2VZOMb3kPu2uTbIEQYGA
GqYkrSTcMawcOpD7XWn+9/UIe7+pYzqhrWpsdFw2bTvHFskfqesBAa19lnMKTW+6
wj4CCSLrCPw1/xaiK4rTkbeX7eax2okHyqjnNamaiBIgFU7bcN76kblxhVBXIBfs
zuTZGqiYj2XktV57oOEr2g3mNyd6eRV/qVZbj7/MIrldAaAGmVixIBbzLQUZwG4E
PVXRn4S0NeolG+Rwa6ttkqi34nelIw==
=6AXx
-----END PGP SIGNATURE-----

--UK1lfQXsnwKrySH9--

--===============4792289130476955809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4792289130476955809==--
