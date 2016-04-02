From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: codecs: add support for
 TAS5720 digital amplifier
Date: Sat, 2 Apr 2016 09:21:33 -0700
Message-ID: <20160402162133.GA2350@sirena.org.uk>
References: <1458580107-4632-1-git-send-email-dannenberg@ti.com>
 <1458580107-4632-3-git-send-email-dannenberg@ti.com>
 <20160328190143.GC2350@sirena.org.uk>
 <20160330025318.GB2073@borg.dal.design.ti.com>
 <20160330153853.GW2350@sirena.org.uk>
 <20160401211402.GA26370@borg.dal.design.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1320147451882385987=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A9EC260524
 for <alsa-devel@alsa-project.org>; Sat,  2 Apr 2016 18:21:54 +0200 (CEST)
In-Reply-To: <20160401211402.GA26370@borg.dal.design.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--===============1320147451882385987==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X71G3O74nGQzyUqw"
Content-Disposition: inline


--X71G3O74nGQzyUqw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 01, 2016 at 04:14:02PM -0500, Andreas Dannenberg wrote:
> On Wed, Mar 30, 2016 at 08:38:53AM -0700, Mark Brown wrote:

> > It sounds like this feature is unusably broken...  possibly you could do
> > something in the mute handler but it seems that anything you try to do
> > to use this feature is going to be both fragile and disruptive to the
> > system.

> Agreed, this is not the first time this has come up :( Btw in my quest
> for a solution one of my earlier implementations actually hooked into
> the MUTE handler, but while this worked keeping the TA5720 in shutdown
> most of the time it did not completely solve the interrupt-overrun issue
> (the TAS5720 would still generate SAIF errors for brief periods,
> dead-locking my SoC even with an empty threaded handler). I was also
> concerned that hooking such parasitic code into a MUTE handler would be
> a bit of an abuse and not make me may friends here.

I think this feature is so broken that any attempt to use it is going to
cause problems.  Even if you somehow manage to make something that holds
together in your test system I'm not convinced it's going to be safe for
other users.

> > What is the value in implementing it?

> There is a strong request from one rather large customer to have
> interrupt-driven fault handling. I did have an early implementation of
> the driver that polled for errors (except SAIF) at the beginning and the
> end of the audio playback but this was not good enough.

I really think this is something that the user needs to carry out of
tree, it seems clear that that enbling interrupts is very disruptive.

> But thinking about this some more, what if I do not actually use the
> interrupt signal, but rather during playback use a timer that fires
> every let's say 1s to check the TAS5720 fault register? This way one

That's fine, some other drivers do this for things that don't have
interrupts or don't have usable interrupts.

--X71G3O74nGQzyUqw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW//GJAAoJECTWi3JdVIfQpkkH/2K0Zy/s1peVzSNulX7iHEf5
JL/iyIxrQE33y0ygORvn3q9Tz597yqUO19kuCqkxZ6o9rkecg/aFHtDuHojwgvS/
ei7agmSki4V4XpmDGTj4cORjSIP7sSLPhkoBuBfSZB0D7NyEcztSqGoq6MwQEVt+
3l3+jQMgR8Qkl+iqlXI6CEBAh987dLhX9o+DkV0nnFyL1IFPqukdhS0BxtpYcqF9
bF9+Kfw4fykYnzod3qkK4atF7SUt3X3GMl5P+2qhIcb+yDjRcwUdVCU47vIv8HsP
p2Jte51Xyx8SKWA0NnsquZZ56Geu9kH20g3w+jwxuHC9OnvcZ90jVMJnqh3dW1w=
=WAmO
-----END PGP SIGNATURE-----

--X71G3O74nGQzyUqw--

--===============1320147451882385987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1320147451882385987==--
