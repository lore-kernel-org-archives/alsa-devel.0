From: valdis.kletnieks@vt.edu
Subject: Re: [PATCH 11/11] ASoC: wm8994: Mark expected switch fall-through
Date: Fri, 03 Aug 2018 13:55:18 -0400
Message-ID: <39703.1533318918@turing-police.cc.vt.edu>
References: <cover.1533151956.git.gustavo@embeddedor.com> <8e3df79b1dca92d49fd9d5c97391d31814ab40f9.1533151956.git.gustavo@embeddedor.com> <30613.1533313609@turing-police.cc.vt.edu> <85d918a5-6a14-ead0-4d0e-d63b5e43ad81@embeddedor.com> <20180803164504.GF6591@sirena.org.uk>
 <684a4fe9-6818-d19c-e7b7-fb8d592a0cee@embeddedor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1533318918_3353P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <684a4fe9-6818-d19c-e7b7-fb8d592a0cee@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

--==_Exmh_1533318918_3353P
Content-Type: text/plain; charset=us-ascii

On Fri, 03 Aug 2018 11:56:12 -0500, "Gustavo A. R. Silva" said:
> On 08/03/2018 11:45 AM, Mark Brown wrote:
> > Basically nobody ever uses OPCLK so I'd be susprised if anyone ever
> > noticed.

I wonder if nobody uses it because any attempts to do so get an error? :)

> I see. I wonder what's the best approach in this case. Should that code be
> removed instead of 'fixed'?

I'm thinking that's a spot that needs a 'break;' added.

Of course, my understanding of that code is limited to looking at the first 10
patches and the fall-through hit something reasonable, and then the last
one did a fall-through to an error return.

--==_Exmh_1533318918_3353P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBW2SXBo0DS38y7CIcAQLLbAf8CUAP8aa3NdO4Wi8ii4C5O+Q0r2dJHb0z
TDLpH9cM0ZgU22oXebcJDLfuGUAAP1lT6rrxb3WfDHgEeMhLNq8tGvz0CqlJny+2
zcPUFd5IPOGfRw2PBArMNj1CECLwIGUBJODtyR0D/kCOSFpXyqCVAl3sIrimFntN
N1pVU6H474DFVRlebm3sKNJp+HYl8TfWN5drGmLsLxWkRy69OXUDQjz4J2UaCcN1
psMKJDo3PcIzariYZsFwZnU/FwanKzwUAsEP9cAE2GrCt5hyne1JLl2L+4FXn3lr
0xWFcWbe8+hwHBGcG8KYukx9e7iP67bYM8ABPuPh2CtHQjQXKqnnMQ==
=8jtF
-----END PGP SIGNATURE-----

--==_Exmh_1533318918_3353P--
