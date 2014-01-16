From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: compress: Add suport for DPCM
 into compressed audio
Date: Thu, 16 Jan 2014 18:01:15 +0000
Message-ID: <20140116180115.GK17314@sirena.org.uk>
References: <1389804717-5985-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1389804717-5985-2-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2096854239101498059=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 70FF52619FB
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 19:01:24 +0100 (CET)
In-Reply-To: <1389804717-5985-2-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2096854239101498059==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9RxwyT9MtfFuvYYZ"
Content-Disposition: inline


--9RxwyT9MtfFuvYYZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 15, 2014 at 04:51:57PM +0000, Liam Girdwood wrote:
> Currently compressed audio streams are statically routed from the /dev
> to the DAI link. Some DSPs can route compressed data to multiple BE DAIs
> like they do for PCM data.

Applied both, thanks.

--9RxwyT9MtfFuvYYZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS2B5oAAoJELSic+t+oim9RfsQAJj8fK0nTJClRz96EFM3G9WA
z/wokmTb6aZahVMDdZFUs9SPcj8pRJGCwsNgcdxXZ0tLcb6y7FBw/ymmmB21BDxl
DC8EWQDOwhWDY3NcjeWhdEjtLhKB+2X+byQIw9Qu/xdwCE2MwB0OL69gJoIhgYf7
Dxz0DtCwKxFuY6lRiwXNtMZTB3+suswi1JSpxEgy2Gf4LB8VYct4r9M5rVkNhbV+
cHFsj3hh0Q3TU4TaQEGWOe1/HmyfCHAHq5hUfz19MBVbkl5VQ1CD5+p5weAwqmcy
PN/1RXnVL4b4VVakl55FV+DynWdlD2YXuaomWWPl+ezIH2Jm4IEAXtd76gGiMhKS
fubzlPu2f5/WwGJLMPMuo/P8R0sBkA7T/izuzPhs7RVjJebEHj4vCnWQsWkfVa44
9HBa8UeA/ezlE7T9f3lBBOmYhOm9vleRfCsCxicuBeuWo42n7ay2w6Pv2qCMeD+X
6owHxyl1pWAiZPedu2TEiLdF5k8AZJAZ9g9z0EqaUNtMbDUWR4CfUgSc1sTnFUVT
zTROhRoUh9v/QBg4sqRaxaaEkKG71Ei53z5wRd4JN80+d6JukUdtJjy2g8VPTX3Q
j8H7bULipsW/GTOzfPNdCc852SxXIIz1stDn7cUpXSjXgT68VJXWwaZRQrSWQ6Fn
T9fAZBUh44eRJ71FkhJB
=wVbY
-----END PGP SIGNATURE-----

--9RxwyT9MtfFuvYYZ--

--===============2096854239101498059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2096854239101498059==--
