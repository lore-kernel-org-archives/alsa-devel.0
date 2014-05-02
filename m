From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Fix Haswell/Broadwell DSP
 page table creation.
Date: Fri, 2 May 2014 09:53:25 -0700
Message-ID: <20140502165325.GL3245@sirena.org.uk>
References: <1399046194-5544-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1399046194-5544-4-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8584838330739319330=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A519261AC1
 for <alsa-devel@alsa-project.org>; Fri,  2 May 2014 18:53:31 +0200 (CEST)
In-Reply-To: <1399046194-5544-4-git-send-email-liam.r.girdwood@linux.intel.com>
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


--===============8584838330739319330==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HM+R7/Jd0Fa6H3F"
Content-Disposition: inline


--+HM+R7/Jd0Fa6H3F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 02, 2014 at 04:56:30PM +0100, Liam Girdwood wrote:
> Fix page table creation on Haswell and Broadwell to remove unsafe
> virt_to_phys mappings and use more portable SG buffer. Use audio buffer
> APIs to allocate DMA buffers.

Applied, thanks.

--+HM+R7/Jd0Fa6H3F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTY82CAAoJELSic+t+oim9VJwP/3xll5dTbLeaMKd12XuEowIx
IlsHel7+L0TyRwMTYlsJCALlLcyZU/JIsxn2Rg0N33AAT6AIeGl//wmczijtYfxD
QYC0+zCjW/yflUOyYOYiCsxQ4hO0gMJB1WDxe3jb/RjzE7HtFQ10w7uAwILWql6v
X3CAcPxr4GiUyXI8OuwLecczauB5p11synWlL8YZp4EpoVRqJL5l+LrnnCUNrXbx
sQ7TBQ66vhOMNrNIkPEaIthNOS8nw8C0jGy7pNUBnBgaiPgnseKaRwqnR9XlbwzN
qeOF032jb82NSWfylwsBDyPDkrFX9pUs7Hdp4UiA58fGs3Z2fLUcj+i0lm2GsH5c
GvXVbZ/ufUJaltB0hEWO4G09qKk3TfMtwI1AoOKZ5Zbc3jKgFCa5bvyB7mA9ECdd
zTbzsGKFKiLQVzHkkbTdUYTG2F+Y4Bpdb4nCrDIl0qFbQJsF4B+rmRoEgDHJZg7/
9h/gnstIcRXIWoFNgmoJvV9GN8Ij7ltAJpeDhL6i6u7MC91YswqpwI9NvfHV781Q
cGo4ldApavHVICOrYMGmxzxfuAveiIrG77htuC7EzstFBPQQE2zEprOtjz0WeAFZ
HJCGt1sL4PAzKKYaPfWnyRVcr0Mnzm46SYz5b/ODkPs9F3afqeTz2FZuRObkS/Wt
wN21YqofY8BcKQFkADNX
=hn7s
-----END PGP SIGNATURE-----

--+HM+R7/Jd0Fa6H3F--

--===============8584838330739319330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8584838330739319330==--
