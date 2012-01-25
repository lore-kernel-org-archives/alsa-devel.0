From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: soc-dsp programming model for loopbacks
Date: Wed, 25 Jan 2012 17:28:41 +0000
Message-ID: <20120125172841.GT3687@opensource.wolfsonmicro.com>
References: <4f1f2489.c602440a.208e.ffff9d7bSMTPIN_ADDED@mx.google.com>
	<1327511249.11901.37.camel@odin>
	<20120125171112.GR3687@opensource.wolfsonmicro.com>
	<1327511587.11901.42.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2624602348333933602=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6A4E0103BCD
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2012 18:28:43 +0100 (CET)
In-Reply-To: <1327511587.11901.42.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2624602348333933602==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+bDoS+V4AJZnUgoC"
Content-Disposition: inline


--+bDoS+V4AJZnUgoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 25, 2012 at 05:13:07PM +0000, Liam Girdwood wrote:
> On Wed, 2012-01-25 at 17:11 +0000, Mark Brown wrote:

> > That's what the CODEC<->CODEC stuff is all about, hiding the link from
> > userspace.

> Ok, cool - Is the formatting and params hard coded ?

My implementations thus far have been able to infer these from the
capabilities of the devices they're connecting (one end of the link is
usually a device with a fixed configuration) and therefore not needed to
worry about this.  However this has always been the most painful bit of
the code so I'm probably going to make it hard coded or something.

--+bDoS+V4AJZnUgoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPIDvCAAoJEBus8iNuMP3dMJEP+wXF8oTlX7+NWxeug5uNpRjd
APJx1mu03jKEX9ZWmP1vy8P83ORVniynnFi/CSZmjdGlGl+ALdVQarphBk6lfG6a
ABR8o5zJrtwUM+jtmmcp2QqrD2rgY1pynnu7Pyf8BcJ9zaobVaxFlGhXxt79kNR9
h3M+XcO1n/FIwgbNQUkGn5ZH/Ch1D0VB65pu8yYmWYbQtuxj9mgouadaszzpEp/M
B6frtOXJdXT7VGP4x15NIQFMaBibH8LzVggG2sKmDIJ6wNYxYIKCwoxIBr2xzn6O
d7hzl5FcMI9oFaifEafOKcjeuM8tY9vGI37wXRu4C57OZkbVAO9c2Iseo34c7ot6
p4JQxTPPojlHIWHUrZecQob9CU0IY7UtX7skEv05UsyySVPz4/rm1sQ+JqL73beD
Z2qS9fV37nQH1ymmT3xy2RqKBWsXEF/WnBmj8NDlXdlmV9pVxOGBuwuBjQYTw5z2
7bUkm4XoUJHwCVFw+KkjbGXbVlKFGHAanGvmRhK1j55TLSzQg74r9YOjbn6O+pze
l4XhfAwY2S4CTYwNeOa8UPzheXL+VCdbq8BhKJ8IzfK+wcddjSbufxL201Fzb0Xz
oKoGbaII2X15Ua9PinXpFFUSyFim55QKLrj3BUht5aE472t12alUXZlQSJV8f0CM
ViYtVldtbX2HELoIO6MN
=Kwzc
-----END PGP SIGNATURE-----

--+bDoS+V4AJZnUgoC--

--===============2624602348333933602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2624602348333933602==--
