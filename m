From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Using sync dapm_sync in stream_event call back
Date: Fri, 9 Nov 2012 13:26:20 +0000
Message-ID: <20121109132619.GE23807@opensource.wolfsonmicro.com>
References: <32F4D3A311A1404B92CF923AFF38C3C529E715@BGSMSX101.gar.corp.intel.com>
 <20121107144728.GH20844@opensource.wolfsonmicro.com>
 <32F4D3A311A1404B92CF923AFF38C3C529EEBD@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8572041594665983690=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7066F261693
 for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2012 14:32:16 +0100 (CET)
In-Reply-To: <32F4D3A311A1404B92CF923AFF38C3C529EEBD@BGSMSX101.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Babu, Ramesh" <ramesh.babu@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8572041594665983690==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 08, 2012 at 04:28:43AM +0000, Babu, Ramesh wrote:

Fix your mailer to word wrap within paragraphs, not doing this makes
your messages extremely hard to read.  I've reflowed your text for
legibility.

> App is re-routing the audio within codec by changing mixer settings
> (for a same stream/device).  When app changes a MUX mixer settings,
> temporarily DAPM path gets broken and shut downs BIAS/CLOCK.  I was
> planning to use a Virtual Widget which I enable in my open and disable
> it during stream_event(STREAM_STOP).  This is to make sure BIAS/CLOCK
> will never shut down, as long as stream is active.  I'm not sure if
> this is correct way to do it. Any inputs?

Open coding this at the driver level is not particularly sensible, there
is nothing driver specific about this as the same issue will apply to
any device.  It seems like a useful feature to add but should be at the
subsystem level.  Off the top of my head the simplest approach is likely
to be to add another timeout similar to the pop timer which we use to
keep supplies and biases running a little longer after their users have
been powered down.

I would at some point like to get something in the userspace API that
allows atomic updates of many controls (freeze the device, update the
controls and then unfreeze as one) which would also cover this but is
much more work.

If you are going to do this as a local hack this isn't a good way to do
it.  You should be driving the state transitions from the application
level so enabling your virtual widget before you do anything, doing your
changes and then disabling it when you're done.  This will cover a wider
range of use cases much more robustly.

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQnQRbAAoJELSic+t+oim9H64P/jPXFZkmHT+tomZMUa1ptYy7
qb0vsTEAKN4r6Irv0Iflq7wbAc/4bheJe7nF+aRhlcQOLKbkbPZw599KkK/lEm+N
jZp2jUy9m86/wrKiuqiVXE+NfNaUZM31RCV+sVDKXt5lLJKXlneO8ihFnZ9HcMY7
beDHb2keWSTc0SfzZ9W830ZCcTZ1N72rIadANDu/vBUM0zln6d4dFks/afa+Hm6d
yQ/fUBr0dKXFxlkfnulTU19OXbp49UoE6h3Q96tGMJD9BX6hEZsmPB9YF+pySB2i
U5UwimRoPP/0LoMwZhWMKm+g0drHPpW96p46DR2VYDsuC8W88zxJH5ITG0NCQer5
KMSvcxb1rwjrFFRjzqCD3Vi7qlfMBJPPMCOdpGmD6iJm6+g2O+GIRVRYVM1cvx10
S/AQQVPuSmI/YFcgKKJfVN8F0ZE0/5rTKagsOF2eGn10kGPTyFBZjv8F+a4Zbed2
PKC14wbWx8n7W33yBqEVXhkKKpX0+Gy7yyz9UOpDNN04sVnuLcJ41CQ3292S0/un
LoU1xYe+HnupxPNyLCGEJleMQ/ccRIh8S7BGxp10rV4n9UAd41XDY+8xW8s7c7po
wAFGzYN9/6Qu/U+SA4pruMm0Lk0c2Q19EVvNvzeNfrzvpvBLAQ6Dx3jndyx5M1Wu
pc4kVOpaE5DQk+GcE6GF
=kIG9
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--

--===============8572041594665983690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8572041594665983690==--
