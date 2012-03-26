From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dmaengine_pcm: use dmaengine cyclic wrapper
Date: Mon, 26 Mar 2012 18:28:37 +0100
Message-ID: <20120326172837.GA3789@opensource.wolfsonmicro.com>
References: <1332763088-18964-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1332763088-18964-1-git-send-email-vinod.koul@linux.intel.com>
Sender: linux-next-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-next@vger.kernel.org, paul.gortmaker@windriver.com, fabio.estevam@freescale.com, Alexandre.Bounine@idt.com
List-Id: alsa-devel@alsa-project.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 26, 2012 at 05:28:08PM +0530, Vinod Koul wrote:
> commit 4a163c82 added extra parameter to device_prep_dma_cyclic
> this is not required if we use the wrapper over cyclic API.

Applied, thanks.

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPcKcxAAoJEBus8iNuMP3dAa4P/jqM6NOROyX/Xmo2pNUZTytA
XoVrPsN9HA+yeIg0KgeZAoCyVPVIZduwLiD8FEMVaBavzl3FD4VmkGTXzPGwyyCd
Cq7Y5iHhSE4nlUQHO/3xq/QnCR3OqwO0fvUOg3dR/gY4T7Y+e23nnbhEsz3/EehY
yyycCa2cwrQo3RNetOepkAzcnApYKe1D4W8fL3gfg896yk6IEGWv8B8XDk03nae0
ZembhYIAc1bnVRE1OMP17wi28p3Ugk+W0tu18nAem3CCP/f3VaZsysHGVCjenWe1
qmC8GDhIEoMMijRz1bGiSsyrogSxqeDhvHOyCmd1zmAoWO7gLk+6Bkd68LmW3KTZ
EJPyz1xWIAGMXMIZb/vl59zvcmtcHc1NmM4/ocd58AT8V/1gKUm4FxTFk8Wvzzy7
2Uu2qt0MVM6fMNALm9u/1EmIyrVv5kObtDhopBCwGtmOVRIzglavAcboOFRyHVoa
w3reAAELccv7AgLcXx/82LaiYBbkpFlapqxcPCw+eHcQASP+yS5jHvIrzUcWALu2
fBt3HICu9kwDNR1INmslrNhe/MLl82RxROWHjeSc/ub2gzgvjVC0Izua1DzfIKvh
CabiTWNuHyuC4MxyUkx8v7QeJeylKwloOPTXjcR+qs9Mk6qyGM40B5SE6bPvK8Al
3vXGfjJbL3VVD2E/VmqC
=k1rk
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
