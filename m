From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ALSA: Integrate control based jack
 reporting with core jack reporting
Date: Mon, 13 Feb 2012 07:44:59 -0800
Message-ID: <20120213154458.GB3494@opensource.wolfsonmicro.com>
References: <1328644128-32630-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F323405.8080902@canonical.com>
	<20120208114642.GG3120@opensource.wolfsonmicro.com>
	<4F327A21.8030805@canonical.com> <s5h39aj5569.wl%tiwai@suse.de>
	<4F3516E4.2080706@canonical.com>
	<20120210155003.GA11701@sirena.org.uk>
	<4F35413F.9000701@canonical.com>
	<20120210163946.GG6472@opensource.wolfsonmicro.com>
	<s5hy5s625w8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8133863816753189362=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BFC9824567
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 16:45:04 +0100 (CET)
In-Reply-To: <s5hy5s625w8.wl%tiwai@suse.de>
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


--===============8133863816753189362==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 13, 2012 at 02:56:55PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > There's rather a lot of people who do embedded development and do need
> > to look at this stuff, though.  There's a real cost to raising the bar
> > for humans to understand things.

> Hm, I'm afraid that this is getting apart from the real worth
> discussion.  I'm interested in whether "Line-Out" is acceptable
> enough, or it's a matter of taste, just like Marmite is acceptable as
> the normal English breakfasts.

Well, I dunno - you did suggest adding direction modifiers to the jack
names which would both be a more general solution to the problem and
clean up the naming issue.

> with the input-jack layer.  The input-jack doesn't provide the index
> number.  So, you can't register the same name correctly.  Thus I tried
> to create a unique name string as input-jack id.

It's really never been the intention to have an "input-jack" layer -
the API is there to hide all the input layer stuff it can from the
individual audio drivers.  The only thing that leaks out is the button
remapping which I couldn't think of anything more sensible to do with
them.

> Now, looking back to your implementation, the kctl jack is created
> with a name string based on the switch type, not from the name string
> passed to snd_jack_new() itself.  Why not passing the string as is?

We can't pass it as-is since we'll need multiple controls per jack -
literally all the systems I have available to test on would fail if they
used the same name as they all have headset jacks.  As I said further up
the thread my plan had been to refactor the name generation code once
the separate kctl code is gone and they can be merged into the same
source file which makes this a lot easier.

With these patches I'm mainly looking for a quick and simple refactoring
to get rid of the duplication - once we've got rid of the duplicate
driver APIs then we can refactor the internals of the implementation
however we like but there's a pretty pressing need to fix the driver
API and get all the drivers doing the same thing to userspace even if
it's not ideal.

> If multiple kctls are needed (e.g. for headset), you can either create
> a new name or just create the multiple instances with the same name
> but give extra TLVs to identify which type it is.  Or, you can create
> an enum control so that both the input-jack and the kctl-jack
> correspond as 1:1.

This stuff is why I've been asking you about the ABI and general
semantics for the new controls, I was never sure what the intention was
- when you said they were just plain booleans I just went ahead and
created multiple controls as that seemed to be what the current idiom
was.

I don't think an enumeration is going to scale so well given the number
of possible combinations you can get on more complex jacks.

> In other words, if 1:1 mapping isn't needed, we don't have to create a
> different name string at all.  Just create "Jack Detect" controls with
> different indices and with corresponding TLVs.  This would be enough
> (could be even easier) for a machine parser.

That'd work I think, though I would create a new control for each
physical jack at least just for clarity.

> And, it seems that there is no standard rule defined for the id string
> of input-jack.  If 1:1 model is used, we'd need to define this rule.

The input stack doesn't have the same concept of machine parsable names
for things that ALSA does (honestly that's pretty unique to ALSA within
the kernel) - the names it users are all free form text intended to be
meaningful to humans only.

> BTW, I found another issue.  With this implementation, you can't build
> kjack ctl without input-jack.  I can work around it for HD-audio by
> adding more ifdef, but it'd be ugly...

I really don't see this as a problem; it seems vanishingly unlikely that
any realistic system would want to disable the input API and need
accessory detection.  Obviously the end goal here is that you wouldn't
be able to have HDA specific hacks in the code as everything will be
handled by the ALSA core code...

To my mind we should just support everything and let userspace worry
about deciding what to use, this isn't the sort of thing which should
require a kernel rebuild to configure and it's not like there's any
fundamental problem or massive overhead caused by having the devices
show up.

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPOS/0AAoJEBus8iNuMP3dsAUP/0A1Xr95ftUvpAp6DODaJhGX
fY2ijHTRHTI3eXGcEGoHvuGmeaJQxBJ+RwQjwPeHwgFf2PNBhDZmsBWntv2RIKPj
CLxerk4POOpO5qp8LduC23TstxiJCj+KhQ+1cxillNfLewVJTvsE8cJg2Syeu3t1
nf2kda+FOoDpKUsEcg0xPv0fZaAj3Z9+HKXVr6UySQwYNGvyY2NSbXH9uka0bG4k
vFyMo8mOnyBr43/8QxH5ScdrWSH//9LVVZRtcb1LEIz79C4IUvrD+dR7sZtKBeVT
9WM16ax5SaSj8RKVg3LQL2wNJiyE9xmORqF+KHi6JcvtfXGprSAy0DnCrCchfJbe
doAM5t0H3HihZ5B7IJEYWAh5nTK4Pb+vC85RbOfQ1YKMMGylj8HaGXakCqhTd1b9
5tyqFCf74A9knZCuk2lm8iZ2ie/0jrzTTX0nSnBJaL+RCG77wgZGP1a5K4PWUbEf
KjG/GVx8HKscTa8LnIXfQOy9q+A0gG7SqaFdFfmZIay9FPTyJ8zfbJ8VCbddGHD3
O7xY9tAegqJLHMVcWA0kk6pnH6IkPJ0bU38LPmsJLe0RBaVdlg9N1WGhhHZvsX/Z
Mp1JF4XrnaS1hOTOOfD1xRcoqRX/xwuM6VqiAux1fvDkbFYwDQ+vHHpAfYsWTBWp
FAraJx1vWv72dy2XibyS
=hbY0
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--

--===============8133863816753189362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8133863816753189362==--
