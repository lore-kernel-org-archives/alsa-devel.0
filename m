From: Mark Brown <broonie@kernel.org>
Subject: Re: pcm512x driver: Mixer control naming issue
Date: Mon, 16 Mar 2015 11:38:45 +0000
Message-ID: <20150316113845.GM28806@sirena.org.uk>
References: <5500DE5B.2020401@hmbedded.co.uk> <5502DAE1.30609@hmbedded.co.uk>
 <20150313182729.GE28806@sirena.org.uk>
 <55060771.7060200@hmbedded.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8742938955876310179=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CB06260629
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 12:38:54 +0100 (CET)
In-Reply-To: <55060771.7060200@hmbedded.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Howard Mitchell <hm@hmbedded.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Gordon Garrity <gordon.garrity@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8742938955876310179==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZgGs4xYo94cs2XY/"
Content-Disposition: inline


--ZgGs4xYo94cs2XY/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 15, 2015 at 10:28:01PM +0000, Howard Mitchell wrote:
> On 13/03/15 18:27, Mark Brown wrote:

> >You say "these controls" but it seems like only "Playback Volume" has
> >a problem?  My first suggestion would be to define "Analog" or
> >"Analogue" as a prefix in ControlNames and then use that, that would
> >avoid confusing applications while still fittig in with the naming
> >convention.

> Yes you are correct that it's only "Playback Volume" that is causing a
> problem. However, I included "Playback Boost Volume" as it also provides a
> selection of analogue gain so I think it should be treated similarly for
> consistency.

Oh, I see.

> Defining a new prefix sounds like a reasonable idea in principle but calling
> it "Analog(ue)" seems like it's saying this is a proper analogue volume
> control whereas these particular controls merely provide very limited
> selections of gain. I could imagine that at some point in the future a

Userspace can determine how much control there is from the TLV
information.  Ideally a smart userspace will manage to combine all the
different controls it finds to make the best use it can of them - if it
can use analogue volume control for some of the control that's generally
better since it maximizes the resolution of the digital parts.

> default for "Analogue Playback Volume" may well be added to "alsactl
> restore" and then we end up back in the same situation. How about defining a
> prefix that is documented as saying that a default should not be used if
> there's nothing in asound.state for that control?

Really the problem here is using asound.state - it's far too dumb a
means of controlling random cards, and attempting to change it is most
likely going to break something else.  Any attempt to introduce a
default for analogue control will inevitably result in problems on cards
that currently work fine with digital/default control unless those are
changed which would then cause problems for things without the analogue
control.

--ZgGs4xYo94cs2XY/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVBsDEAAoJECTWi3JdVIfQIisH/3iKXg2WBbD7wJRdbg5Qk/WI
jihx1L5MMtrPmZKzwWkIZ3lXzW6o7bcTQWlpvb/CXPwYw8ggRLvYqujQU1d/nmZO
+UoxMkWIfs3uSAfdyKiQzdEv1saOhtMeum6JS9Gj37S15nqu3DJJACVRlik1oYLe
Cn/1Xus8WC3LVXtzsmUBbv+s4sAiACxDCELLxsl5pZ1eHRuzPb7QvoWqek2JGaxf
jzMP38niwUSx0IpxyQRWKUEqbBHj2swRRYiiv+oUVAhue29aReMa1C+6GYxShi8Z
GgpUcEX7eEZ/XNVEZKaN0HLKf0n7cOQCRnOjjhaiaM3IfsT7f/fidH7ZulF2je0=
=9ECi
-----END PGP SIGNATURE-----

--ZgGs4xYo94cs2XY/--

--===============8742938955876310179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8742938955876310179==--
