From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sound: soc: intel: bxt_da7219_max98357a:
 Replace GFP_ATOMIC with GFP_KERNEL in broxton_audio_probe
Date: Fri, 13 Apr 2018 11:41:30 +0100
Message-ID: <20180413104130.GA6854@sirena.org.uk>
References: <1523270781-22627-1-git-send-email-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0524637107036739059=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AA7E8266BBC
 for <alsa-devel@alsa-project.org>; Fri, 13 Apr 2018 12:41:53 +0200 (CEST)
In-Reply-To: <1523270781-22627-1-git-send-email-baijiaju1990@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, sathyanarayana.nujella@intel.com, Adam.Thomson.Opensource@diasemi.com
List-Id: alsa-devel@alsa-project.org


--===============0524637107036739059==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 09, 2018 at 06:46:21PM +0800, Jia-Ju Bai wrote:
> broxton_audio_probe() is never called in atomic context.
> This function is only set as ".probe" in "struct platform_driver".

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrQiVoACgkQJNaLcl1U
h9CQPwf9EQIfFL7w6d2apKyJctMJiogjpDcKmRDZkAvAXXhZLRkjYE9+JADLxpi1
s4ClYXhU1ggARiyLLXGRnWDRCYY7Fh67huCBpKkf5GDPAbC2tAvOBAtbVN9Ex50Z
PFyzkOW9bENfM3RgdlXP3Sql00XrjNErjrl8Daw+STmlORzXsGLzZZDZH3owI35Z
cwQ4qzqaMjB5O9EWlse1EJla911Kf6xYjVGeTQw91C4nLxg9Nm32YjBhp4iSHjqW
1AFBB2L9fmTcWaPAEgmnMlnWE6NGZBdcpXvYSvfkJbdhg0lpp0vE728pykUDmAxz
rHtKyUeHTsw/59UOl5cQDGs19HtB/A==
=D/7C
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--

--===============0524637107036739059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0524637107036739059==--
