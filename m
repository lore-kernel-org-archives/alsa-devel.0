From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: twl4030: allow voice port to be
 connected externally.
Date: Sat, 8 Nov 2014 09:26:22 +0000
Message-ID: <20141108092622.GC2722@sirena.org.uk>
References: <20141108002637.6561.19002.stgit@notabene.brown>
 <20141108003803.6561.57464.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8502852284987343554=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D6CF6260453
 for <alsa-devel@alsa-project.org>; Sat,  8 Nov 2014 10:26:41 +0100 (CET)
In-Reply-To: <20141108003803.6561.57464.stgit@notabene.brown>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: NeilBrown <neilb@suse.de>
Cc: Mark Rutland <mark.rutland@arm.com>, GTA04 owners <gta04-owner@goldelico.com>, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============8502852284987343554==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 08, 2014 at 11:38:03AM +1100, NeilBrown wrote:

> If voice port on twl4030 is not connected to a McBSP (or similar)
> then we cannot configure the format the way we normally do for a DAI.

Yes we can, you need to represent the DAI link to whatever else the
device is connected to in the driver like we do anything else - and in
any case this isn't a device specific issue so we shouldn't be doing
something driver specific to solve it.  Look at something like speyside.

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXeG9AAoJECTWi3JdVIfQc4QH/1l0g9IioGYeCiZI3hZeipn2
QJUO3LMztZZuximUm03fKQggDZ1mw/TahdVKVOFhMgD++poaljjboOlyy9akat14
1TFyjLa3Q6f7S93kcuDi0kuxhQoY6mgVFN2zOYC1z9q1bAqfElOkaJjbk/rdTKtn
2ubSjrX1vQ7ZGGrGNvTpQTcOKiQBEzdL9HW6Z/ZtoKy1OF2+pqZh0B17GFnB+U2d
YeHRMeEz4XUZGDk7RofQ4HbeVg+dqNesp683wFaWu1zMn9Xmmxc5ANaMM5ASJEsW
TVyg5Sri69ALJHaIAqVVJzQV8oq4rd0KstLBVdWpDSR4RX0VybIC9KxaFVl1bpE=
=Y39v
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--

--===============8502852284987343554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8502852284987343554==--
