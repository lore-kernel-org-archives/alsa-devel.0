From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ALSA: Add SoC on-chip internal memory
 support for DMA buffer allocation
Date: Wed, 16 Oct 2013 18:46:58 +0100
Message-ID: <20131016174658.GO2443@sirena.org.uk>
References: <1381920801-9187-1-git-send-email-b42378@freescale.com>
 <20131016115847.GK2443@sirena.org.uk> <525EBFF0.1080303@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6529954911925603118=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4162C2651EB
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 19:47:03 +0200 (CEST)
In-Reply-To: <525EBFF0.1080303@metafoo.de>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6529954911925603118==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tG/TrgamrKt+o+rv"
Content-Disposition: inline


--tG/TrgamrKt+o+rv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 16, 2013 at 06:33:52PM +0200, Lars-Peter Clausen wrote:
> On 10/16/2013 01:58 PM, Mark Brown wrote:

> > Also is iram the best name?  It makes me think of the dedicated fast
> > instruction RAM that some processors have.  sram perhaps (for static
> > RAM)?

> Using IRAM (internal SRAM) for this seems to be quite popular (`grep IRAM
> arch/arm -r`). Existing devicetree bindings also seem to use the 'iram'
> property to refer to the on-chip SRAM
> (Documentation/devicetree/bindings/media/coda.txt). It's probably a good
> idea to stay consistent with the existing bindings.

Oh, I wonder when that changed - it always used to get called SRAM (or
TCM when that was what was used).

--tG/TrgamrKt+o+rv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXtEPAAoJELSic+t+oim9pnwQAIoCc7FqPDDj7KsGYdI7aXll
0X7XzvlNdyJsnyDEzS0hZ26oAcgGqBD0RGSwfnjJUguYapyQQUW5Y/9gBcidXaSa
3p55UEe+4v8q/7tfCCdHrzMgkef3MxHNsRlakVFvdnrEthUszCbtGu4pO2sYYk7+
I+wlKNy4M+rzvC7FT0bh1EcJH1JJnrAt4Yw3Drj0Xc3Yb/OdnPEE0w52XOXD5Adz
HO0HJpQTq3Af/w1UmI+vucyxvEwi89Uljqj9bveG0zTj1itJviuS3Q6qNSsl8uuC
i6K8bgK+3wnStoMvQF282QfP3y6bW6bRlAelfajefFoalS0dD/bEmutZgjRFbali
+nXH2/XhHe95TUVVw96i5lLJo+RkYdvYGWoRq06RUY/halxX6dYHFtAyJPFsrx3c
KvchCIABVR8j+otblgmESRa08CNjg23N8e86w352H1HlF09dtfdEuEPxm+vwnGLT
IIqIs8Ua3+YrH2xRE2RGzZTW2KZeRo3m0DcPil8sRz8aGM3yCeQAq/ACz/81cgaC
0oDlM2tHel/zvlZ8e97efUOYjnc7S+cRAt0O5lcNpkWee2jvraF2ZteWN9/CiWjp
TTpvtFrVjk5qY0gtrVir26nrLK2ToLNnGhba+AeVEOODUjOhDoxDpzRkvVmTFyI4
uBYejsi6vD+dGbxtKCSA
=7F+c
-----END PGP SIGNATURE-----

--tG/TrgamrKt+o+rv--

--===============6529954911925603118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6529954911925603118==--
