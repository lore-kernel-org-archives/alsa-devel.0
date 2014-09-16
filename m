From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 04/10] ASoC: Intel: mfld-pcm: add
 control for powering up/down dsp
Date: Tue, 16 Sep 2014 12:03:43 -0700
Message-ID: <20140916190343.GC7960@sirena.org.uk>
References: <1410255693-6958-1-git-send-email-subhransu.s.prusty@intel.com>
 <1410255693-6958-5-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5312716681883965376=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BD97E262607
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 21:03:47 +0200 (CEST)
In-Reply-To: <1410255693-6958-5-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5312716681883965376==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vy8H1LsWyIRbmCsz"
Content-Disposition: inline


--vy8H1LsWyIRbmCsz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2014 at 03:11:27PM +0530, Subhransu S. Prusty wrote:

> @@ -129,6 +129,7 @@ struct sst_ops {
>  	int (*stream_read_tstamp) (struct device *dev, struct pcm_stream_info *str_info);
>  	int (*send_byte_stream)(struct device *dev, struct snd_sst_bytes_v2 *bytes);
>  	int (*close) (struct device *dev, unsigned int str_id);
> +	int (*power)(struct device *dev, bool state);

These seem to have a mix of )( and ) ( - it was a preexisting problem
but still...

--vy8H1LsWyIRbmCsz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGImPAAoJECTWi3JdVIfQfwIH/jHn0MXhrVNuxAcS4iwDPBD/
Y9pV4R3XcR5H2FFZ6VucBtj/GdGSFBtIMsW6OAh+7GxcVoj0QGSftGWSogF67q7b
RrdB0ZzeJMSZGUwCtTTt/NWRRMchTH5HHc4mM2HowlOAiLCiAdaFIvu0UhUZQiMZ
7W98Zuf6+0/mdVUYK9LPzwJrdeJrO7zLjFFzeet7zBtVMwOZuFzRAmr9RTt0rc6v
3rzfuWgYVR7ua47UGq1FTwTzGhnkGEQpOEIpgwK/W8CWNYcuIrYtYYghCn4FFEzq
Vx1de4G5mLgvK2ml/FViNm3WCixhERzN4/X/A5tvr49W92gphx93GxKA6J3A2vc=
=FLmA
-----END PGP SIGNATURE-----

--vy8H1LsWyIRbmCsz--

--===============5312716681883965376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5312716681883965376==--
