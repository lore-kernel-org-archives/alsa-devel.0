From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ALSA: compress_core: Split copy into
 seperate read and write callbacks
Date: Tue, 9 Apr 2013 12:47:28 +0100
Message-ID: <20130409114727.GP9243@opensource.wolfsonmicro.com>
References: <1364991209-24653-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1364991209-24653-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <515DC015.7040704@linux.intel.com>
 <20130405082344.GA20026@opensource.wolfsonmicro.com>
 <20130409111507.GF31193@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4503332843360346105=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2016A265DF7
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2013 13:47:30 +0200 (CEST)
In-Reply-To: <20130409111507.GF31193@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.jf.intel.com>, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============4503332843360346105==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MI2pJyvBeFc4alSb"
Content-Disposition: inline


--MI2pJyvBeFc4alSb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 09, 2013 at 04:45:07PM +0530, Vinod Koul wrote:
> On Fri, Apr 05, 2013 at 09:23:45AM +0100, Charles Keepax wrote:
> > On Thu, Apr 04, 2013 at 01:01:57PM -0500, Pierre-Louis Bossart wrote:

> > > Why not remove the const to make this consistent with the PCM interface?

> > I had been trying to avoid loosing the const from the write file
> > operation, however I am happy to just loose this through casting
> > instead. It is certainly a simpler change I will respin these to
> > do so.

> Keeping const of write seems to be a better idea... Ah i cant decide :(
> I will asker wiser folks... Takashi, Mark?

I generally prefer the const correctness, but on the other hand Pierre
is right about the PCM interface and it's probably more trouble than
it's worth to change that.  So meh, dunno :/

--MI2pJyvBeFc4alSb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRY/+8AAoJELSic+t+oim9U6AP/2TFDFFuDXQWKivxWiJG1115
1Jj8FENvZgRfQNSBdYm1O2RYyfvTvZhwEzf4pl1zLgtCI6crnyFBqa/0Bp3ltU1Z
PH+nXM3bOKkOF1r890fxsy4tQ5PJS+oCXYXGLAfBOJncBGLtwa8y5N0HFzkUht1x
Zgp3V4J9ntcWjgJmz6w2T+Z7UpaNEP6CVtZXZ95HRGHJVw1dQsrWnaQZO7Mpa+8X
4xNwuq3uB+UlrdcZuMb1gJaONV4b67dC4xtEQ1Wr7k6G3qf+eL5GPPIibkCJviLA
jvXBbpyzCNeJC0PPq2hfDy/G6S2zvmnyu7/lwfzf2lOuLhL5UGyCxF8jx6xDCGdD
D/98lcMnMTUsxTwqx+NHK3YIm/RyMbv7+dbA0fIJu+jDbYF1nUyOMZ8exBN9vd5U
wXHCw+FA4eLJ1ncTeYfmvL8GQ4fxYNd0kBTSLd6scu0tjP3vWCUpfhVmiC1x1Hlp
41Vs0q2IdhL6uV7eeOKKH8ZFSL5KXpf7Lzhjhj4eNLXA7RTSgXrzCbDSPy2uh76p
3LeWGCde9VSg7ehuBfvh6pbv0aWNRbuRF6O13xgGis2ZBt7iZ8ICMBaEve+aBHKw
WRyOsM9bJrz9ZERi3vDWT8bcQ2fbFcRTDWReRV35zsLIXzdnI3oBfTapbs6uae4D
3wr8A3/IpYjudGupOMmR
=yNZc
-----END PGP SIGNATURE-----

--MI2pJyvBeFc4alSb--

--===============4503332843360346105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4503332843360346105==--
