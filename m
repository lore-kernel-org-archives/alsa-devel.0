From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC] ASoC: core: Allow DAI links to be specified by using ACPI names
Date: Fri, 04 Oct 2013 08:55:59 +0200
Message-ID: <1674991.zl8kYFEb4V@vostro.rjw.lan>
References: <1380803636-24079-1-git-send-email-jarkko.nikula@linux.intel.com> <20131003161929.GA27287@sirena.org.uk> <524E600B.4070202@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <524E600B.4070202@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Friday, October 04, 2013 09:28:27 AM Jarkko Nikula wrote:
> On 10/03/2013 07:19 PM, Mark Brown wrote:
> > On Thu, Oct 03, 2013 at 05:22:45PM +0300, Jarkko Nikula wrote:
> >> On 10/03/2013 04:37 PM, Mark Brown wrote:
> >>> This is making me wonder if we shouldn't be taking the stable names we
> >>> get from ACPI as the dev_name() instead of our internal ones on ACPI
> >>> systems (and possibly something similar on DT) rather than adding custom
> >>> code like this.
> >> This is actually somewhat confusing issue. I think it's relatively
> >> easy to switch using ACPI names within ASoC core (by modifying
> >> fmt_single_name or something like that).
> >> Problem is that for ACPI enumerated client devices the dev_name(dev)
> >> still comes from those subsystems as before. So for instance dev_
> >> prints in codec driver or ASoC core keeps printing "rt5640 0-001c:"
> >> as before and I personally find it a bit more confusing if internal
> >> ASoC names don't match as easily with dev_ prints.
> > You're misreading my suggestion.  What I'm saying is that it seems like
> > it might be useful to have dev_name() return the ACPI name - this would
> > mean that everything, including all the dev_ prints, would use the same
> > name which would then become stable and tied to hardware.
> I see. Indeed, this sounds a better idea. At quick look is even more simple.

Well, this is slightly ambiguous.  What exactly do you mean by "ACPI names"?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
