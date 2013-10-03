From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [RFC] ASoC: core: Allow DAI links to be specified
 by using ACPI names
Date: Thu, 3 Oct 2013 20:59:42 +0530
Message-ID: <20131003152942.GI16684@intel.com>
References: <1380803636-24079-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20131003133729.GR27287@sirena.org.uk>
 <524D7DB5.1010608@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <524D7DB5.1010608@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.jf.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org, alsa-devel@alsa-project.org, Mika Westerberg <mika.westerberg@linux.jf.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 03, 2013 at 05:22:45PM +0300, Jarkko Nikula wrote:
> On 10/03/2013 04:37 PM, Mark Brown wrote:
> >On Thu, Oct 03, 2013 at 03:33:56PM +0300, Jarkko Nikula wrote:
> >
> >>For instance, matchine drivers could specify codec in DAI link by using:
> >>	.codec_name = "INT33CA:00",
> >>instead of
> >>	.codec_name = "rt5640.0-001c",
> >>Note that ACPI name is used just an alias during bind time and core
> >>continues to use device name. In fact, machine drivers could use either
> >>names.
> >This is making me wonder if we shouldn't be taking the stable names we
> >get from ACPI as the dev_name() instead of our internal ones on ACPI
> >systems (and possibly something similar on DT) rather than adding custom
> >code like this.
> This is actually somewhat confusing issue. I think it's relatively
> easy to switch using ACPI names within ASoC core (by modifying
> fmt_single_name or something like that).
> 
> Problem is that for ACPI enumerated client devices the dev_name(dev)
> still comes from those subsystems as before. So for instance dev_
> prints in codec driver or ASoC core keeps printing "rt5640 0-001c:"
> as before and I personally find it a bit more confusing if internal
> ASoC names don't match as easily with dev_ prints.
> 
> But yes, I agree. This alias name in DAI link is not that clear
> either as it exists only during bind time.
Sorry am very ignorant about ACPI, but cant resist asking why should ACPI
allocate some internal name and then we go about figuring the bus, slave and
codec. Wouldn't it make sense to just get "rt5640.0-001c" as device from ACPI
and use it.

-- 
~Vinod
