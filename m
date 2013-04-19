From: Mark Brown <broonie@kernel.org>
Subject: Re: ALSA framework problem: FE disconnected,
 BE still connected!
Date: Fri, 19 Apr 2013 11:27:22 +0100
Message-ID: <20130419102722.GT13687@opensource.wolfsonmicro.com>
References: <7e576a6bf7cb6ca6a9be95b0d14e3a87.squirrel@www.codeaurora.org>
 <20130418165844.GN13687@opensource.wolfsonmicro.com>
 <51705700.8090005@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0467428691093781133=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 248DB264FE3
 for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2013 12:27:24 +0200 (CEST)
In-Reply-To: <51705700.8090005@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: asishb@codeaurora.org, lkasam@codeaurora.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, gsantosh@codeaurora.org
List-Id: alsa-devel@alsa-project.org


--===============0467428691093781133==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PzGeKfgKLFJqWH+5"
Content-Disposition: inline


--PzGeKfgKLFJqWH+5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2013 at 01:26:40PM -0700, Patrick Lai wrote:
> On 4/18/2013 9:58 AM, Mark Brown wrote:

> >Please submit patches in hte form covered in SubmittingPatches.

> We are not sure if the solution is correct. Change from Kasam will skip

Even if you're not sure it's best to post as a normal patch so if the
patch is a good solution it can be applied.

> the step which trigger stop the hardware and directly call hardware
> free. Is it expected that every driver internally stops the hardware
> before freeing the hardware resource if not stopped?

That seems silly.

--PzGeKfgKLFJqWH+5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRcRwCAAoJELSic+t+oim9+GgQAJRnN5zOfxXo8TY9NnpwOy9F
3mvJ9eyJPlR6wXQ/PB5cKMKHMc7WluRrkSG6OwOUCFiLxREMuF5pJVrqxvm8e4Hg
FkBsqxnKSvJ9+ld2q/TXOdELXs+Z6+PYimb2Lu5sjHSSAknH1R1zKu+jszEz9obo
xtNN02Y5Qi1cn2UTrtYYDtLLqm4jjsAfYLbDysOAzUTH/HivwK7v7f1kjSSd89Ef
/YHr3MEDPnxp3iUHTAHsUmAVWOJh24b8hIWkUS/tjd6B/dHhJpBS1dI1cBn6fSRb
t9Wz/EwEWWLPzWxt7tMnm0TXWg2My0RlP/W5J0h9ukKNVql1bAQ3YQS4hXnzx66l
7OwkFIUKWBIrnNsBNAcxmZwY/Fa/TvGj5NZ0NMhV5QaLYd6ijXCdqZaAvhOGC4XZ
eFuUqOjvzT3DrpfByMG1+IuaVGuBJ4VkrgqTX58xGaR020EMSmThDVSsThEgQCQb
BPAxSbKF1TH7bc1h6+w+/yHJAuErVwEra9Uf0gL74AJxkcLVq54Y/Ey/ugpM9U0c
CE36owGhdj88ZULk7tTKv4s+Q6oknsx2uNAb2VXy5siUG9dJj7++i56N9IAeuPi8
+1AxoRDWV9bBeTmfD4dYOcIKMvZloclcFnzADSAL42LNSsdV5u05a0pm53Qj2FEG
BWFWgDxRQSRjkHrBpHjp
=mxPT
-----END PGP SIGNATURE-----

--PzGeKfgKLFJqWH+5--

--===============0467428691093781133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0467428691093781133==--
