From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] topology: ABI - Add the types for BE
	DAI
Date: Thu, 6 Oct 2016 16:37:31 +0200
Message-ID: <20161006143731.53vyuwhyyca3vdbm@sirena.org.uk>
References: <cover.1475505267.git.mengdong.lin@linux.intel.com>
 <943bbdf62e4d0d3f297fa59b9804236c82778185.1475505267.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3841470256076216434=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BEC59266847
 for <alsa-devel@alsa-project.org>; Thu,  6 Oct 2016 17:14:33 +0200 (CEST)
In-Reply-To: <943bbdf62e4d0d3f297fa59b9804236c82778185.1475505267.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org


--===============3841470256076216434==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o2alfxzjhluhk3mz"
Content-Disposition: inline


--o2alfxzjhluhk3mz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 03, 2016 at 11:03:50PM +0800, mengdong.lin@linux.intel.com wrote:

> Pump the version number to 5.

So, we just had a user on IRC complaining that the last round of
incompatible changes in v4.7 broke their laptop audio - they had a
laptop that shipped with Linux and suddenly the topology file didn't
work.  I think that's an indication that at this point we have an ABI we
need to maintain compatibility with rather than just break things.  That
doesn't explicitly affect this patch but does mean that the parsing code
ought to cope which is likely to have some impact here.

> Topology kernel driver will check size of ABI objects to detect version
> mismatch between user space and kernel.

The ABI wasn't explicitly reved which suggests that it's this that
triggered the issue for the user.

> +/* BE DAI flags */
> +#define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_RATES         (1 << 0)
> +#define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_CHANNELS      (1 << 1)
> +#define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_SAMPLEBITS    (1 << 2)

These don't seem specific to back ends, people can use topologies for
DSPs on off-SoC devices which might also want to use these.

> +	__le32 be_dai_elems;	/* number of BE DAI elements */
> +	__le32 reserved[20];	/* reserved for new ABI element types */

Thinking about the above I'm wondering if it doesn't make more sense to
call these physical links rather than back ends - that term is going to
be clearer to people who don't use DPCM.

--o2alfxzjhluhk3mz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX9mGoAAoJECTWi3JdVIfQPSIH/23IgJ9RcDvaCyf7euAo9m/z
OKLR5E9uWpHRDJX+ngYj+mYlvgxTWxupLthxjh/IU67M6wp0PkvyfL1cWAiN9KzX
jZ+qCmnygHsfX4noNQyBEVcq8z0kI2wxvsYd5hSqwYtJ9KTo2NfKQciBvgH7azkP
XHFiGWgGZNQFjX4WaoDYcg2EMG27QXlIngz8SpcIOVbgb49CLZiKHx6ZmsuYwg7n
zXInl1D28HjQ+/y2RDYWgdX1M6ioaD/HjTHvSTloGhx3cgZu8Uj535pQFPOlQ0wV
haNlXEGPaEm4Ks/GuSQTTlP3EQesLD4vuHc380NfsyGzf5GVZ17sGewxzQpVoU4=
=xTOa
-----END PGP SIGNATURE-----

--o2alfxzjhluhk3mz--

--===============3841470256076216434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3841470256076216434==--
