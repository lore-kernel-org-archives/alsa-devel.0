From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ALSA: Integrate control based jack
 reporting with core jack reporting
Date: Wed, 22 Feb 2012 20:55:30 +0000
Message-ID: <20120222205530.GD3265@opensource.wolfsonmicro.com>
References: <20120210163946.GG6472@opensource.wolfsonmicro.com>
	<s5hy5s625w8.wl%tiwai@suse.de>
	<20120213154458.GB3494@opensource.wolfsonmicro.com>
	<s5hwr7qzl6g.wl%tiwai@suse.de>
	<20120213192309.GG3494@opensource.wolfsonmicro.com>
	<s5hk43e24la.wl%tiwai@suse.de>
	<20120222171843.GA3265@opensource.wolfsonmicro.com>
	<s5hehtm22me.wl%tiwai@suse.de>
	<20120222183249.GB3265@opensource.wolfsonmicro.com>
	<s5hfwe24ner.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2994852776748190881=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F02F4103A29
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 21:55:32 +0100 (CET)
In-Reply-To: <s5hfwe24ner.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============2994852776748190881==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 22, 2012 at 09:35:08PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > As I've *repeatedly* said the idea was to prefix the name once we'd got
> > stuff merged into the same file (which means ripping out the HDA
> > specific code)

> Even if so, it can't be merged until this prefix stuff comes in.
> As mentioned, otherwise it conflicts.

Well, yeah.  But if there's an insistance that the new ABI is reworked
as well then it's not worthwhile.  It's a pretty simple change to make,
I just didn't want to faff around with the HDA code to discuss the core
interface - IIRC I mostly posted the patch to make it clear that both
APIs just use sets of booleans.

> Alternatively, deprecate CONFIG_SND_HDA_INPUT_JACK.  This is another
> option.

I think we should do that anyway, just unconditionally enable the
feature.

> Meanwhile, we can mark it deprecated now as we provide an alternative
> solution in 3.3 frame.  Then drop it in 3.4 or 3.5 where your patch
> comes in.  THis sounds feasible.

We're well past the point at which we can change 3.3 substantially.

> > It seems like it's a bit late to worry about the naming scheme to that
> > extent given that the existing ABI has already managed to get into one
> > kernel release and looks like it's also going to get into 3.4 as well.

> Which ABI?  The kctl jack hasn't been in released kernels yet.  It was
> first merged in 3.3.  So I really want to fix up the naming rule as
> soon as possible before 3.3 release.  For example, with or with

We're pretty committed to what's in 3.3 though.  If it's just the hyphen
that's a fairly meaningless difference in terms of the stuff I'm talking
about, it's trivial to change.  But if you guys decide to go with things
like adding TLV information or whatever then that's more involved and I
can't see that getting in at this point, we'd need to remove the kctl
jacks from the userspace interface for 3.3 or accept churn.

It did also make it out in the last alsa-driver release IIRC.

> hyphen.  It's an easy task to fix in the code once when decided.

I mostly agree, I'm pushing to merge now because it seems like we can
make the change before or after merging the APIs and I don't want to get
to the merge window without the two interfaces being brought into line
because there's still ongoing discussion of exactly what the userspace
interface for the control jacks should look like.

> > Right now the only tractable fix I can see is to implement something
> > approximating the HDA ABI in ASoC but that just makes things even worse
> > from a maintability point of view.

> Well, as I already wrote, the prefix and suffix are supposed to be
> optional.  So, the current HD-audio implementation doesn't block your
> interpretation in jack.c by itself.  The only blockages are that the
> jack.c implementation doesn't provide enough for HD-audio requirement

So when I submit a patch removing the kctl jack support from HDA in
favour of something along the lines of the current code you'll be OK
with that so long as there's also something there to use the card naming
(I'd expect I'd end up submitting that as a followup patch for the sake
of making the individual patches clearer)?

> (with the first version), and the detailed naming rule like hyphening
> isn't decided yet.

Right, but like I say I don't think this should block fixing the problem
with multiple APIs and ABIs.

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRVWRAAoJEBus8iNuMP3dHDkP/jvo2DmUCU3ML9Y+vqe5xu6I
QEIq0vqR4oV3V+X1ws+fkLXfn8NeGa7AulRx2PRXlcZW0FQS+CfzZzo6q6K7mxC5
YbC2B3CtMPq+sJF0qyDY15c9batulWp8O8Nl82lbjaQf+iOGrbYGZoGqMnab1VHp
XkERUVjTCRfM429qvDI9s+Yw/pkK0bZXFQBhf6jmgu/ussfWxV4bVFZCgU5RR7cM
wlha3qaucijQXjm8Rt0KGdCYdcetM7upluwW4b6gGcEIDZE1YK+hN7WdBNDQo3KV
h8JrcmnSmOn0G2GGLlUYkTex+VvLBG6ZZXR2IDhZrCZbDghxuG7/TVPGJAdLlJZ5
ueUw72rn5Eh9fRA87FAf0wPlihNFjbX8WMKZaxbUVo1rbW9x2X3kYSrHvezR22kw
EVAvKKZGhH7SKCYigjgYGEF+26rNuoVYo5zDn90t5FOSVVd60m3rl9OKVW//i+5e
3FUupZyI6AHZXr6FXbbNbNZvVrxTvXXkLPFzhoH3f50stV26I00obXOBfdXnG2gc
viQ+CcFaTvgDT48n3t+Pl1Gjkdg586J92Zisdpkt+or0y9UcUyUPpLbEfVCmKr5S
BiXaYZW0sb3LuzGci6x39h9bUZNYSzytbDZLK8C2nMZ33XvSz9q2cMUcqhpSIiM/
NG1aRRyyfXd4R7dLoJmA
=RZXq
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--

--===============2994852776748190881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2994852776748190881==--
