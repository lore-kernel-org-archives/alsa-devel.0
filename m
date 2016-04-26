From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/2] ASoC: codecs: add support for
 TAS5720 digital amplifier
Date: Tue, 26 Apr 2016 18:29:36 +0100
Message-ID: <20160426172936.GE3217@sirena.org.uk>
References: <1461615456-19510-1-git-send-email-dannenberg@ti.com>
 <1461615456-19510-3-git-send-email-dannenberg@ti.com>
 <20160426154313.GA3217@sirena.org.uk>
 <20160426162240.GB2885@borg.dal.design.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8574773340170613259=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F8EB2612CC
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2016 19:29:51 +0200 (CEST)
In-Reply-To: <20160426162240.GB2885@borg.dal.design.ti.com>
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


--===============8574773340170613259==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tt8NzeIytnj46EAf"
Content-Disposition: inline


--tt8NzeIytnj46EAf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 26, 2016 at 11:22:40AM -0500, Andreas Dannenberg wrote:
> On Tue, Apr 26, 2016 at 04:43:13PM +0100, Mark Brown wrote:

> > If the driver doesn't do anything just remove the code.

> Well it's doing something which is making sure the nobody passes in a
> sample size that's not supported. Wouldn't we want to catch this?

Is the device actually going to mess up if someone sends it something
else or is it just going to ignore the extra bits (given that it's doing
autodetection anyway).

> > > +	if ((curr_fault & TAS5720_OCE) && !(tas5720->last_fault & TAS5720_OCE))
> > > +		dev_warn(dev, "The Class-D output stage has experienced an over current event\n");

> > "Class D over current".  The verbosity is making the line over long and
> > the phrasing is a bit unclear (and makes it seem less critical than it
> > really is).  These should probably be dev_crit() or somthing too, over
> > current and similar events on a speaker output are generally extremely
> > serious.

> The overlong line goes through checkpatch --strict and looks like an
> accepted practice to prevent breaking "grep" for example. The text is
> more or less from the datasheet to give people something they can
> cross-associate. But I can try to short this a bit.

It's not just the fact that it's wrapping round to the next line, it's
also the fact that it's very weakly phrased for something which might
reasonably indicate an actual fire risk.  I'm pretty sure people will
not struggle excessively to find the reference to over current in the
datasheet.

> conditions.  For the "over temp" error condition (which is actually
> really hard to create on the bench, I've to get the EVM up to like 150C
> and things start smelling a bit) this should probably be dev_crit() as

If the silicon is flagging an over temperature condition that tends to
indicate a catastrophic physical failure in the system, it is likely
that the speaker itself has failed or there's otherwise a short in the
speaker output path and potentially other physical damage especially in
smaller systems where you might find that for example there's thermal
damage to the case (and possibly even the user).

> well. And then, maybe leave the "DC error" as a warning, since it's less
> critical than the other two conditions. Thoughts?

If you're pushing DC through a speaker that will generally mean that you
will shortly see one or both of the over current and over temperature
errors, it's really not something they're designed for.

--tt8NzeIytnj46EAf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXH6V/AAoJECTWi3JdVIfQ8rMH/AkBGsNYhMKhsIiAXerYlMnz
8iY6SDU4oLi1//2mRrmCq1W9cQWgStzYszm5PxHZteTV1ZTNIK/UKJ+ZjO9d+V9i
iUNW0rQ8yD3wQ5Ih6P/sMRNXqfY4Kg+bz+6NMvCl6tfZF+pyko2g6kvKblSbKpp9
njUFS2iZahyUM1qcPL/M5O7eK3DsVRiCtkLElWRZMqWj1vP2gK2MllEQVWKIdtcr
SKBUUwFmmZXIe+NH3WNvBdfyEc6X9yTFGl0hRb8tJg45oT5ptyoXlX1MqY/R2BFV
+5wgQy2oKmTpXRVPMGuIWaA5kfSFicsdTE1vpXssR/AXIbzKMcD7P2GS27gCajc=
=xo8q
-----END PGP SIGNATURE-----

--tt8NzeIytnj46EAf--

--===============8574773340170613259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8574773340170613259==--
