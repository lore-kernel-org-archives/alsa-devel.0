From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/4] ASoC: core: Adds support for cpu
 loopback dai_link
Date: Wed, 18 Nov 2015 19:18:43 +0530
Message-ID: <20151118134843.GU25173@localhost>
References: <1447091401-24298-1-git-send-email-vinod.koul@intel.com>
 <1447091401-24298-3-git-send-email-vinod.koul@intel.com>
 <20151118131757.GI31303@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1191488598435188508=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 50B4F265473
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 14:45:00 +0100 (CET)
In-Reply-To: <20151118131757.GI31303@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1191488598435188508==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e5GLnnZ8mDMEwH4V"
Content-Disposition: inline


--e5GLnnZ8mDMEwH4V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2015 at 01:17:57PM +0000, Mark Brown wrote:
> On Mon, Nov 09, 2015 at 11:19:59PM +0530, Vinod Koul wrote:
> > From: Jeeja KP <jeeja.kp@intel.com>
> >=20
> > soc_link_dai_widgets() creates codec-codec loopback link which
> > allows DPCM to trigger these links and program the parameters for
> > these links These links are:
> >=20
> > 	Codec1 Tx (Pb)  ----------> Rx Codec2 (Cap)
> > 	Codec2 Tx (Cap) <---------- Tx Codec1 (Pb)
> >=20
> > But as we try to model a CPU based loops for non host links like
> > modem to codec loop, the above mapping gets wrong as:
> >=20
> > 	CPU Tx (Pb)  -----------> Codec Tx (Pb)
> > 	CPU Rx (Cap) <----------- Codec Rx (Cap)
> >=20
> > So we add a new flag to handle above scenario and link widgets as
> > depecited above
>=20
> So, what I was really thinking of with the renaming was a bigger rename
> that updates the names in snd_soc_dai_driver and everything that comes
> from that.  That's a much bigger thing though, let me think about it a
> bit more.

ah, yes that kind of change does make sense, but as you observed that will
be a larger rework. And I think I am up for it in parallel to my SKL work :)

But that will take a bit of time and I would like update these in bits
rather than one shot

Let me know what you think and how you would like to approach this

Thanks
--=20
~Vinod

--e5GLnnZ8mDMEwH4V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWTIG7AAoJEHwUBw8lI4NHV48QAKWisuT+aDf5n/S6ZJTxMlS/
nSTOkjDjco24IJVH9gVHOqCsb65J5/nPMPtAYte9hRxCPcPZ7Bw8SYzcWc1cu3Ut
KOS0Z1v4PRg3UWAeGdJNURPn3pdLCkmha9hgMtw8X+lBX7Lhis6gUI1QRChvwF4S
OjTtx29JrBCOkt2kd8ftq3+0tBGDMUwZVHMGHEkFZmgzhpsmMqgdm1CLJjWwPccK
RLclVq8TRMRdBAn4dA6Rkh5xeEe0Q6Rw7/aPM1tFqdmeBOlY7Pld7LFWd8GIaDDj
0QyJItV2A1EmclZ+B0Sm583heDw0ura2xNxna2RISkfj+KvPjaxJHVmWqnapjndb
s84ZePW3HJilW/1dvqOlxEeX3GywyEHMS9CSo9vZS2+xC2fevzdq7aK1hOLVdx/6
d0N/CHRIwGBWG3e/F8DIbwA/Lnu2Ky0Qb97H2ld/hQeojDxuJCsavEk2CL4jyoBP
eTLKWtPnXmmPtO0oSuHbAdNAHE3htM9tRNUFvRbMf7wSp2HuvQCF6o+NxAQjkvrs
Ji2ki9CzHwUNrJ9vWiIvoAzcX/60b8GD9MSK9wp70KjaS8PuHNfgDnmX9xgaMq2a
bJYtpZtymbSgnzmw9XWlLe7yMnnmbqQWUI+u2ZuiU3mQYozjvgk/rldQr0ovly+S
aSp8tFLpzl18LUNJ+7PD
=PFYr
-----END PGP SIGNATURE-----

--e5GLnnZ8mDMEwH4V--

--===============1191488598435188508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1191488598435188508==--
