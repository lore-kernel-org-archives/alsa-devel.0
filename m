From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Fix Audio DSP usage when
	IOMMU is enabled.
Date: Fri, 2 May 2014 09:53:38 -0700
Message-ID: <20140502165338.GM3245@sirena.org.uk>
References: <1399046194-5544-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1399046194-5544-5-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8170810158661517876=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 700902654D3
 for <alsa-devel@alsa-project.org>; Fri,  2 May 2014 18:53:53 +0200 (CEST)
In-Reply-To: <1399046194-5544-5-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8170810158661517876==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7+7T3ZdO12I8zLgo"
Content-Disposition: inline


--7+7T3ZdO12I8zLgo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 02, 2014 at 04:56:31PM +0100, Liam Girdwood wrote:
> The Intel IOMMU requires that the ACPI device is used to allocate all
> DMA memory buffers. This means we need to pass the DMA device pointer into child
> component devices that allocate DMA memory.

Applied, thanks.

--7+7T3ZdO12I8zLgo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTY82OAAoJELSic+t+oim9ciYP/2xcFtE78qNYTWylLCO1QV9k
9lLN5uxKoNHJ4i2TRSzph8p3JYwcSgNVNmhPbf9/IiqCkvnoybyTLiHYgfiwoa/R
pVYgJYjv/E7wETAuR/9DHJE7F/QqhYE7SCvDyxNs6TaYWwXmcQda1tHRPEwTS0l8
2Z4ejuUZQ/nnRQrbIOaJE449tZU+jRVT+R7SKLFB6QFDJY0v4vIZYF25UrFpyp60
VJ10H9fLlxuz1tmLeM/beX0SXasRcv/bl852KATgKbzhC+aK/EqOZdTCJQkxopXN
YxG/2MkX8iClKXK2DZyTGHAsMhFlmEtgp/pVLh1ZNcSv3tb3+N1A6ApsF0d2iUV5
J4oZ8R/cHXQJo3DZ2eyLf09FILkT6KQzxT6cxZmlkfDpfMFCYC8sr72tv9QMCytu
aHdNaZIU9xSbMaE7GVgOYVHgksInFQf36XIONuB4S9KGn0gTdIoTSKnqBZuvkPrh
UNC1a20FDSRU1VNTxC8Gc6wNP/ljxMsfCkEYd7LlDgosXbIPv0uRGQhzCQzXBM+o
rWmIsDfZ7CRx03+hMpIs5DykRuN6jZ33wuoim0Ntw7L2YEvzcYZUe9T9PbpNDSzx
TL3OLOJ0LJpqYDuwisGCxtr0WWy3EsYxHN3wrJzecuP1SUMTEbIW4DGL9I4MiPDc
WfJDU/y4bhum1uPaMRyq
=Dszx
-----END PGP SIGNATURE-----

--7+7T3ZdO12I8zLgo--

--===============8170810158661517876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8170810158661517876==--
