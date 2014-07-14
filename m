From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/4] ASoC: Intel: Add dummy read for
	SRAM block enable
Date: Mon, 14 Jul 2014 19:11:44 +0100
Message-ID: <20140714181144.GN6800@sirena.org.uk>
References: <1405329072-28679-1-git-send-email-yang.jie@intel.com>
 <1405329072-28679-4-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5810858605180578698=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A35AF261B36
 for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2014 20:11:58 +0200 (CEST)
In-Reply-To: <1405329072-28679-4-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5810858605180578698==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kUBUi7JBpjcBtem/"
Content-Disposition: inline


--kUBUi7JBpjcBtem/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 14, 2014 at 05:11:11PM +0800, Jie Yang wrote:
> Add dummy read after each block enable, to workaround
> SRAM write missing bytes issue.

Applied, thanks.

--kUBUi7JBpjcBtem/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxB1dAAoJELSic+t+oim9QbIP/ivasrjewT9aRL8ymSwIXlCe
78FOGIPGW1ltyXbdd9U5tfkaCxJQh/lR8rDIB5x+kqSe3cGytIs2OYO0acd222el
Oy7kPPqP3tFnM3TbGwZL8wn3/MMmy0w89ChXH78a3zRisMZ/RMMpATdVzymPCAgF
8qQdSowAAdlQNAY3KpU6ll2gFn18cdT5Pbnu+BChylTmBCDqov6FgQZqoHVzUUNR
2hVi8mzvQhGSWpUDclazS6gUQF6uWtElNM76iKMQeDJ4toIy4wG5MEZZO2mCCZNW
bpnyPnkHSSx//nj9a+NM0n1TcXuomSKU1OhcZY9JT49wWC+EdW5jSrO5mBRVAKx+
liLY5eKBfpG7jijV4xfn4Qh29hZLp2DTAnJ32q8XqfpvfvabgsJTAaoaKHunkzMh
FjGwS/l/ZQ835Kwq1yCPUQtYh16L1p2vDNiMNjlTsJ16B1vXAheDyLdbKJN2nk1r
AaZwbC4oL11dCZDhLVeooDjDg1YrtZSTcmMCShXQ1XdnErnnrJlnjddZtFbLhcAr
tMpJ+aapOtP51OWBNz5p6O4pBIrzzKeI/o3r8+H9RatqgV8VVcFT9UPZ14dKgWc1
cqg/nLz/FNXzY5xlnZIps3wFY14lGT2D6XB9Lt6puEmkJ4M7LGmiXbfNuqautbxX
DRVoAiv+2fCOQWDKjLq3
=HcjP
-----END PGP SIGNATURE-----

--kUBUi7JBpjcBtem/--

--===============5810858605180578698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5810858605180578698==--
