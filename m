From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: firmware core: Add core support
 to create and destroy firmware components.
Date: Wed, 21 Nov 2012 20:52:31 +0900
Message-ID: <20121121115229.GE18117@opensource.wolfsonmicro.com>
References: <1353348765-6238-1-git-send-email-lrg@ti.com>
 <1353348765-6238-4-git-send-email-lrg@ti.com>
 <20121120032659.GC4483@opensource.wolfsonmicro.com>
 <50AB9E56.5050509@ti.com>
 <20121121004356.GC4673@opensource.wolfsonmicro.com>
 <50ACAB1D.2040103@ti.com>
 <20121121103754.GC18117@opensource.wolfsonmicro.com>
 <50ACB802.20102@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3104594564173503370=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AAD0E2625D7
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 12:52:38 +0100 (CET)
In-Reply-To: <50ACB802.20102@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3104594564173503370==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 21, 2012 at 11:16:18AM +0000, Liam Girdwood wrote:
> On 21/11/12 10:37, Mark Brown wrote:

> >Right, but the decision we took at the ASoC conference and have been
> >implementing was to move away from that to just letting applications set
> >the binary blob to change the enumeration value instead and then putting
> >the management of multiple names for the blobs into userspace.

> Ok, this is fine and works well for larger or multiple blobs that
> will be frequently changed at runtime depending on use case.
> However, the ABE coefficients here (around 400 bytes per EQU) are
> only loaded once at boot (where the number and graph positions of
> the EQUs is tightly coupled to the FW) and are not unloaded. The
> simplification here is that we dont have to write any new userspace
> code to manage the ABE EQUs and treat them as regular alsamixer
> controls which makes the integration and testing easier in this
> case.

That's the case for essentially all blobs right now (nobody got round to
fixing the ABI limit of 512 bytes!).  Are we saying we want to use this
infrastructure for all blobs?  If that's the case then we definitely
need to support multiple files per device...

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrMB0AAoJELSic+t+oim9IysQAJBIGQpqaouRQN0Ec2AuKQn2
j7cCj/fzDBV+6wR16t/SnGzkhUvgiSjGW2EasZhhHVdaelzqjBC9LjC+X/ZIJL2Z
hCP/XOJrtplobTN/taUTKxiDUZK98CkZgQNFO+8gFfLRHGB1VhoDehyRjH+WKNOS
XLHITyXFDt8f8T7UpB5twGotnTjMLgpPMZx7zkd/UnCbpeUPdRqAgErWqwQ3blGD
ED3WB6E6c/ejA1JChu4EAgPfcCG6KLIS8NuzfVb+UrXrao4MrFUYzveLzdWrwTCJ
rmwivp1aGedH3eD0kBCgR0t/3ZGtHkgK8uvAmEiUuPWhJEQMqWZqLQmw6KZ3Eztu
G2tVWuYIT9RAEycOUxFq+qBHZaQb+pJBj+9Sn4DazMHu/2TGbzS9K0agr94BfVHk
qnfXOctDuQ1s1R1ChXhiPispwoB5cmaM8AnkZPXl9wC7H92iWM5TNhh2vbp85sWb
tKBpN9ef9kxQtjnRXmsY8jLmKorieVgA4mHhXg2qblszQC51i5HkkpsgylLDuDee
FuxkKgCPZ0qWVUUcXy4/fljpV7ZStMH41XNZLfXCyiINApRyK0EyGQ+TUi8kq3yd
yWD05KqdMKyA+nc6X63fk8EMir1GFvq5hoaxT4ifdv47GsbglFnBIgLF63dgONva
J2s3xr6Gqwg3pFZtsJ95
=S8mU
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--

--===============3104594564173503370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3104594564173503370==--
