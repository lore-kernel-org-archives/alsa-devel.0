From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC] ASoC: core: Allow DAI links to be specified by using ACPI names
Date: Fri, 04 Oct 2013 19:17:17 +0200
Message-ID: <2478106.vxrWh0grvl@vostro.rjw.lan>
References: <1380803636-24079-1-git-send-email-jarkko.nikula@linux.intel.com> <1655137.c5uTBo1XRy@vostro.rjw.lan> <524E6CC3.8040507@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <524E6CC3.8040507@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Friday, October 04, 2013 10:22:43 AM Jarkko Nikula wrote:
> On 10/04/2013 09:53 AM, Rafael J. Wysocki wrote:
> > On Thursday, October 03, 2013 03:33:56 PM Jarkko Nikula wrote:
> >> This patch adds alternative way to specify DAI links by using ACPI names.
> >> ACPI name here is considered to be used as an alias for device name during
> >> DAI link binding time.
> > What's DAI?
> It comes from Digital Audio Interface, and DAI link in ALSA SoC 
> basically ties together platform, DAI and codec devices by name or 
> device tree node.
> 
> > +#if IS_ENABLED(CONFIG_ACPI)
> > That's not necessary, because ACPI_HANDLE() is defined as false for
> > CONFIG_ACPI unset.
> Actually problem acpi_bus_get_device() that is not available if 
> CONFIG_ACPI is not set. Which suggests was it even meant to be used in 
> drivers that are build for non ACPI systems too?

No, acpi_bus_get_device() shoudn't be used if CONFIG_ACPI is not set.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
