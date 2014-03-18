From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add support for multi register mux
Date: Tue, 18 Mar 2014 23:59:41 +0000
Message-ID: <20140318235941.GT11706@sirena.org.uk>
References: <1395186692-11735-1-git-send-email-aruns@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0879902422167440405=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B1A3264F10
 for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2014 00:59:58 +0100 (CET)
In-Reply-To: <1395186692-11735-1-git-send-email-aruns@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arun Shamanna Lakshmi <aruns@nvidia.com>
Cc: Songhee Baek <sbaek@nvidia.com>, alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0879902422167440405==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jF5TAc7w0HgrN+Xd"
Content-Disposition: inline


--jF5TAc7w0HgrN+Xd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 18, 2014 at 04:51:32PM -0700, Arun Shamanna Lakshmi wrote:

> Currently soc_enum structure supports only 2 registers (reg, reg2)
> for kcontrol. However, it is possible to have multiple registers
> per mux. This change allows us to control these multiple registers.

I'd want to see a user along with this and...

> @@ -1093,6 +1093,9 @@ struct soc_enum {
>  	unsigned int mask;
>  	const char * const *texts;
>  	const unsigned int *values;
> +	unsigned int *regs;
> +	unsigned int *masks;
> +	unsigned int num_regs;

...it duplicates and generally isn't joined up with the existing members
of the structure, and has no support in the helpers (for example,
converting the existing stereo controls to be two element arrays which
I'd expect to see).  Helpers would count as users here.

Note that we don't support double register enums or muxes - only
numerical controls are supported.  It's not clear what a multi-register
enum would mean.

--jF5TAc7w0HgrN+Xd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKN3pAAoJELSic+t+oim9X90P/juLHAIf9XoQvk30A3LBxtCu
cIU14vx3hoogOSinsRae+wah8Srhjgr/LYGw8CV1pEOL1r6tFyqt4chIrBB6gzxc
1sVAOpsjWqvhzGON9bAvzaoa6ZLeWWtrlpMpFxX2b8v1/pAqHspp+zfJIVLX/tS9
5z/9PWX49rWlgNXqwDFNGGQ2/rS8QSduj0qqzAAHGpOQvf4t/MY071HW/lPiqh0d
Cw0r+/bI500Y2yhpURqZTmUAAp8pmVup2jJ48Pg0F/fauNot7bQwjzeHlcqFEnS3
pRUUZILdSKBbUA5aALRhxbs+KHQcpZaJjZsDAiAZQ7Po8W92fu7WvRsr1cAa300+
86/LcNfXF1EAHXBlpEqVFwe4oBtiXKmsGdG4eGjTNwZhIjHWh1FVM4nCOqe6yJB7
2xRnHVaHHrn0Uj3lbyt1zXK+ta2BMEDFv2kTMSr2pt9CqQkVyN/NGmOowQcJw0VF
iV/eHxeHtWfAl1WkTCTE6IJI4A+S0vHcx/puPfkOjyxBV2SUCPi7Rd/C/m+DQhjt
hv4yk9lvHVzlIpqWFR/HVJtx8KGsTHkfcMQRFxGcauYZGeYfiyU3m3JShVMZQyRR
SNhSgGs9vlf0aQN734YjxEGvJ2hJFsJoSI+Vyzi91YTn4uj5oDV3AP5O2uYY7op+
URLCfkLzVEWISLt6nNDe
=rwRq
-----END PGP SIGNATURE-----

--jF5TAc7w0HgrN+Xd--

--===============0879902422167440405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0879902422167440405==--
