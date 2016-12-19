From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 1/3] clk: x86: Add Atom PMC platform clocks
Date: Mon, 19 Dec 2016 11:04:04 +0000
Message-ID: <20161219110404.cnk43zqenn2m7ib2@sirena.org.uk>
References: <1481306510-7471-1-git-send-email-irina.tirdea@intel.com>
 <1481306510-7471-2-git-send-email-irina.tirdea@intel.com>
 <CAHp75Vdaw4yvTPP2JZc+ti-AVNsisRQ+WG=JxPQ1jv-r7DADQA@mail.gmail.com>
 <1a98dcda-a662-958e-307f-5fe3f281ed9f@linux.intel.com>
 <CAHp75VccDyiLhWxZYg+d0usrwhfa_hiZAJCKPXXVRod=tB803g@mail.gmail.com>
 <20161216183607.GB44199@f23x64.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="exmomhpvdqifvrc4"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161216183607.GB44199@f23x64.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Irina Tirdea <irina.tirdea@intel.com>, linux-clk@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>, platform-driver-x86@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--exmomhpvdqifvrc4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 16, 2016 at 10:36:07AM -0800, Darren Hart wrote:

> My understanding is include/linux should be more generic, rather than platform
> specific headers. So while platform_data may refer specifically to the platform
> bus drivers, it's the closest thing we have to include/platform, which would be
> ideal. I would prefer to stick with include/platform_data because:

It's not specific to the platform bus, it's for use with the platform_data
pointer embedded in struct device that all buses can have - it's
extensively used for things like I2C and SPI for example.  But really it
doesn't matter *that* much.

--exmomhpvdqifvrc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhXvqAACgkQJNaLcl1U
h9BxzQf/c8nqU+66S2miVJyYdJbh8d9Ed+afKoeeTozs1u6KcCMaigFS1hyUKSk1
ZKyGQy32B5iSGauGTYwbRJnz39qUg2d4Jay9XK8IEZoZLw/IiZ90CaXFkvtX2YVn
61P9OcYJE3eq57I6i8dhLD7bR9uI9CxIXS8fRbf7RaZd1wRb/z4s6z7YMFVJYvIS
zkzw0KrmIb+4AQfvWFuXw51xujERcnfBHnjHq1JX/yxqihmSJYg4/wi3pgNdKjEl
4AQc+r37wMLWO1LU7XP6H7TRKagVzriXtyap9zi/YtHoewnyrKkzVjcJMduOaEmf
OVSJefChGjkkQUUcAgaG/SVwRJH+RA==
=CT+F
-----END PGP SIGNATURE-----

--exmomhpvdqifvrc4--
