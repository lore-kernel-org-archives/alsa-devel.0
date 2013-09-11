From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8903: disable IRQs during BIAS_OFF
Date: Wed, 11 Sep 2013 17:45:57 +0100
Message-ID: <20130911164557.GZ29403@sirena.org.uk>
References: <1378752289-6301-1-git-send-email-swarren@wwwdotorg.org>
 <20130909202726.GU29403@sirena.org.uk>
 <52309778.9010004@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6977614936315352277=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AD19261ACB
 for <alsa-devel@alsa-project.org>; Wed, 11 Sep 2013 18:46:03 +0200 (CEST)
In-Reply-To: <52309778.9010004@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6977614936315352277==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wXYyj3yjEv8QWr+Y"
Content-Disposition: inline


--wXYyj3yjEv8QWr+Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2013 at 10:16:56AM -0600, Stephen Warren wrote:
> On 09/09/2013 02:27 PM, Mark Brown wrote:

> > Drivers usually work around this by disabling their interrupt with=20
> > disable_irq() between suspend() and suspend_late(), then doing the
> > same thing again between resume_noirq() and resume() covering both
> > the windows where this can happen.  This preserves the ability to

> However, I'm not sure it's possible for genirq to handle this
> transparently in all situations.

> When would the IRQ be re-enabled again?

See above - during the period between the device being suspended and
interrupts being globally disabled, and then during the period between
interrupts being reenabled and the device resumed.

> If it the IRQ is enabled immediately before the device's resume() is
> called, then IRQs can still fire while the device is suspended. That
> would solve the issue at hand here; that the I2C device used for
> register IO wasn't resumed when the IRQ fired, but could presumably
> still be problematic for the device itself, in general if not in this
> case. Perhaps drivers just need to support this?

Yes, that's a problem if it's an issue in the driver/device itself - in
that case it seems reasonable for the device to be responsible for
quiescing itself (as they mostly do already).

> If the IRQ is enabled immediately after the device's resume() is
> called, then a device wouldn't be able to receive IRQs during the
> execution of resume(), which I assume would completely break some drivers?

I think you're right there.

> This gets more complicated with shared IRQ lines, since it wouldn't be
> possible to enable the IRQ immediately before/after *a* device's
> resume() was called, but rather, this could only happen immediately
> before/after the resume() for *all* devices using that IRQ were called.

Yeah.  Fortunately I've only ever run into this with threaded interrupts
so they can't be shared in the first place (which to be fair tends to
come along with the buses that cause issues here).

> It seems like the only way a driver can really manage IRQ handling in
> the general case is to mask interrupts at the source, like this patch
> does, rather than mask them at the interrupt controller, where the IRQ
> may already be shared.

The problem is that this doesn't actually fix the problem in some quite
common cases, you can still trigger it so long as the device is still
supposed to act as a wake source (and hence won't actually be suspended)
- masking the interrupts at the source would actively break those
systems since they do want to be woken by the device.  To make matters
worse if the device is the wake source then the interrupt will be
asserted during resume making it more likely that the resume side of the
issue will be triggered.

> I guess that means that for wakeup interrupts, the driver does indeed
> need to disable the interrupt at the source between resume_noirq() and
> resume(), although I have no idea how that could possibly work, if the
> register IO is over an I2C device that itself uses its own interrupts...

The disable needs to be done with disable_irq() rather than by
interacting with the device, just stop the interrupts being delivered
until the device is capable of handling them rather than stopping the
hardware asserting them.  Fortunately since genirq doesn't allow
threaded interrupts to be shared I2C devices won't normally have to
worry about how rude this is for shared interrupts and generally the
buses affected by this will be threaded.

--wXYyj3yjEv8QWr+Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSMJ5CAAoJELSic+t+oim9VJ0P/0iL8x5LdmfyucFbqRgnz1bF
lzQEU4zdiXOuPwwjRmQ5FsjuhWfE21ExctY4dhUFzSSetlIWCWcLz6kgg8mSQ8vU
MuW8ycWA5pfaubMa+dv61268vfMpH8VwRH0kP7kbOP5GksXUS9s+msSZ6+ldcU2o
RpXcNLjtUB2PDkWAE8I3/HgXiwVtjAAKAm1EzOTki5OpUu9Xsc9ul/jMY2G0BYu6
szv94I4lGoEbN6EGjMZNnTBg7WQoWQqjAZrgD9hsiqC8F+O45iaNTTkukZUfnUv6
sSFxP7Z/2ppjzP4HXpBnGp6p8xyK2Laed0C5qwAX+n34aBwkUvjdwiXcTwufzQqm
k+sjiXfqx0CbZag13ja3IOdn2+S4fNOENOvjeeoh2Udgfgbm75DtkZ0+QM4elpJz
/Dml6b2xdRKBI4dHzJgnibYV5/Dr1Iy24ll44L5dQo1W/t4mTJ1vdAfiSDwJVfgM
vAX123ZZ667Y8+ulvR7MUrHGMLB5gniBKT8VcclgboBGV9ttHTr4r3X+y389jOXU
Zc5XXRIk4DrpGnY9DZ/yGWcQRotq+NyISKBwKmiIoVcFOe5iRyywe64UA8jcyAOj
MktlhKbPuAe16cv5YY74whU9+UySjD/LbCEDxROB1BY5lSvfsJ9YSCAsbS/tNDuH
GnaIAT7upgme8Jvak3GM
=UQcf
-----END PGP SIGNATURE-----

--wXYyj3yjEv8QWr+Y--

--===============6977614936315352277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6977614936315352277==--
