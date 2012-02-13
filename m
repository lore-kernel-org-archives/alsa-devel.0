From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ALSA: Integrate control based jack
 reporting with core jack reporting
Date: Mon, 13 Feb 2012 11:23:10 -0800
Message-ID: <20120213192309.GG3494@opensource.wolfsonmicro.com>
References: <20120208114642.GG3120@opensource.wolfsonmicro.com>
	<4F327A21.8030805@canonical.com> <s5h39aj5569.wl%tiwai@suse.de>
	<4F3516E4.2080706@canonical.com>
	<20120210155003.GA11701@sirena.org.uk>
	<4F35413F.9000701@canonical.com>
	<20120210163946.GG6472@opensource.wolfsonmicro.com>
	<s5hy5s625w8.wl%tiwai@suse.de>
	<20120213154458.GB3494@opensource.wolfsonmicro.com>
	<s5hwr7qzl6g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2214027874123017206=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 30900243DF
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 20:23:15 +0100 (CET)
In-Reply-To: <s5hwr7qzl6g.wl%tiwai@suse.de>
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


--===============2214027874123017206==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xjyYRNSh/RebjC6o"
Content-Disposition: inline


--xjyYRNSh/RebjC6o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 13, 2012 at 06:40:23PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > With these patches I'm mainly looking for a quick and simple refactoring
> > to get rid of the duplication - once we've got rid of the duplicate
> > driver APIs then we can refactor the internals of the implementation
> > however we like but there's a pretty pressing need to fix the driver
> > API and get all the drivers doing the same thing to userspace even if
> > it's not ideal.

> Hm, then I'd say let's hold on.  Merging this half-baked stuff is
> rather confusing at this point since the use of kctl jack isn't
> targeted yet for ASoC.

> I believe what we need _now_ is to decide the policy (i.e. element
> naming rule and TLV definitions) for kctl jacks quickly.

Now that the kctl jacks are there I'm getting people asking me about it
often enough so I'd like to see it merged.

> > > In other words, if 1:1 mapping isn't needed, we don't have to create a
> > > different name string at all.  Just create "Jack Detect" controls with
> > > different indices and with corresponding TLVs.  This would be enough
> > > (could be even easier) for a machine parser.

> > That'd work I think, though I would create a new control for each
> > physical jack at least just for clarity.

> They are indeed individual ctl elements.  They just share the same
> name and are distinguished by the index numbers.  For the parser
> program, it would be even easier because it needs to look only for
> elements containing the single string.  The rest is the parse of TLVs
> of gathered elements, which would be needed no matter whether we have
> multiple name strings or not.

I think we're mostly agreeing here - what I'd like is to be able to give
each jack a descriptive name which shows up in the control name
("Headset", "Docking Station") along with "Jack" or some other keyword.
The descriptive name could be optional, but it seems nice to put it in
the control name.

> > > And, it seems that there is no standard rule defined for the id string
> > > of input-jack.  If 1:1 model is used, we'd need to define this rule.

> > The input stack doesn't have the same concept of machine parsable names
> > for things that ALSA does (honestly that's pretty unique to ALSA within
> > the kernel) - the names it users are all free form text intended to be
> > meaningful to humans only.

> Yeah, maybe.  But, if you have two headset jacks, how would you
> identify with the current jack stuff...?

You've just got the descriptive name to go on, there's no way to
directly associate it back.

> So, at this point, I can list the following policies for kctl jacks:

> A. all kctls have one name string with different indices.  Each jack
>    is distinguished by the TLV provided to each kctl.

> B. kctls are built with only a base name ("Headphone", "Mic") with
>    different indices and TLVs.

> C. kctls contain unique names ([location] base [direction] [channel])
>    optionally with TLVs

I think I prefer B here with the base name being a descriptive name
(which could often be like the above) that should be unique within the
card, even if the driver just adds numbers.

--xjyYRNSh/RebjC6o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPOWMWAAoJEBus8iNuMP3dkfEQAIXtvSbKD/10I3P+DKOs9PW1
id1GBsYKeiNHqqawnfQ1oNjFebamgZOjctsjlkiSi/ymWEE47Jb2zZF6caI9eXFM
5iR8xEZtK0/yE7Rg+flxdszS+OhzRVnqIbVj6RPebW1TEp8q+rYZAhf0BMLrs6wy
g30+G5/VLoDvEuvdhqwTV49s16XHVgTrl9+kD4n4iA1tD65T4ybA5dOAwGNJMa74
heooNSyOROvhhPmJcFqhLC6IfCIonCqnBW8W98lNtGdGXSLGm47iSmCAMT5V/XZN
45u7FQMCwyMyUoSyMXyypllpHnj9JdoL1j8R3UCQ47ueoETmKBEkvAUU3Hb5cQ0d
grgQ2SxjfKnqMQCK+rOsTa2w5aWgcrNbpsVtGg2LlFkMl+AYjjLib4bzBRgUGVNb
k4wkBYVg50DaDuIeiWnZve59wyTM3ycSgm7N4aILBrym9qQft7cuxTXc7Z1EQNts
K8gsKI6hiRNQnGTfLgxb3/hYB1MiDV8uiNyhQ3Jl7ZBFR024kPyz7CXonrS1jit0
NJh1Inz9B6MCWUDjhgPL5vsY5xmBgR8EQx5ZOo+fLSr6T+IeKbKyJGP5LeEfoKaz
XUh1pgThXHgJ7m4HGwc9BglrnEIF6zPEIUkURC/o2aefd8DqUE533gAX7candd9a
6SS1kksYCKtlqCaRSlR5
=epY7
-----END PGP SIGNATURE-----

--xjyYRNSh/RebjC6o--

--===============2214027874123017206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2214027874123017206==--
