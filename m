From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Consistently use unsigned int
 for register values
Date: Thu, 13 Feb 2014 18:06:50 +0000
Message-ID: <20140213180650.GV28112@sirena.org.uk>
References: <1392297261-1366-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8664681657596672628=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 735762608D3
 for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2014 19:07:01 +0100 (CET)
In-Reply-To: <1392297261-1366-1-git-send-email-lars@metafoo.de>
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
Cc: Arun Shamanna Lakshmi <aruns@nvidia.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8664681657596672628==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qrxaW5QmeXhOrNsF"
Content-Disposition: inline


--qrxaW5QmeXhOrNsF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 13, 2014 at 02:14:21PM +0100, Lars-Peter Clausen wrote:
> Commit f7d3c1709 ("ASoC: dapm: Change prototype of soc_widget_read") changed the
> signature of soc_widget_read() so that it, instead of return the register value
> as a int, takes a pointer to a unsigned int and stores the register value in
> that pointer. There are still a few places that pass a int type value to that
> function though. Change these to unsigned int. For more consistency also change
> the signature of soc_widget_write() to take a unsigned int instead of an int for
> the register value.

Applied, thanks.

--qrxaW5QmeXhOrNsF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS/Qm2AAoJELSic+t+oim9DFQP/12hPderGMV0TKafgoSOeEYF
oFNwrLLmrB7H5ObSnHr2x+8ciLPhuYo7xQ71V00fazRBKns6a/WmARrS3npvlyVE
rMlH3iHTzYN4Q8PzTcQsLzl/afZhBuBIEh/l4La55wrJ3X5chj06k7wvjM/E79kA
yds3s66hAGGddGszdyI49B1AdgFiCs2MIojeIJXsnPej1a4ct4Ufp0obqq8jvEi9
JCtBGnQbyy1rpsfafQPSZzhlHq3WKPodt5fnWN7Q484bpzxXMrkX95F71+TwlE5z
FV5g3XxNqZC7iNEHhJ42wQ2vfgIP6vZHPVCKKvjNK5c0E4Pg/ftGM3yuR1iVhXAL
8OVcrA8X3ynIG+xNecsG99ccGjAYQxysQ4f0qU74U/zJVwq8v3c+M+m8r+yv90Y4
ulD1I1O8JZfm8KmJiiIdBEfDkC+QPhduSJL0csHkcFV4cihUp8zBpc+TDSlLMRPe
QJUQ7iSU8rajcumGZWqgyPTOs78pDFStOZcIveHeWq/1yU9YUhJh81XFZPGG46rI
LKHD7WDeChvpuIlm4aqejCefA7YoiWYgMoMmjBTUpHO78/Avu9p8QlpAeOFnRdQw
RrK3ci3aPYMzY7evMOZpK/gtKSZ0HcGh3bg6Nw0XABZJRf6rZAjokAjRFhLTjMBU
d50IESBxFNHOTcKwUWum
=EsE4
-----END PGP SIGNATURE-----

--qrxaW5QmeXhOrNsF--

--===============8664681657596672628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8664681657596672628==--
