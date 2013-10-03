From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [RFC] ASoC: core: Allow DAI links to be specified by using ACPI
 names
Date: Thu, 03 Oct 2013 17:22:45 +0300
Message-ID: <524D7DB5.1010608@linux.intel.com>
References: <1380803636-24079-1-git-send-email-jarkko.nikula@linux.intel.com> <20131003133729.GR27287@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20131003133729.GR27287@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 10/03/2013 04:37 PM, Mark Brown wrote:
> On Thu, Oct 03, 2013 at 03:33:56PM +0300, Jarkko Nikula wrote:
>
>> For instance, matchine drivers could specify codec in DAI link by using:
>> 	.codec_name = "INT33CA:00",
>> instead of
>> 	.codec_name = "rt5640.0-001c",
>> Note that ACPI name is used just an alias during bind time and core
>> continues to use device name. In fact, machine drivers could use either
>> names.
> This is making me wonder if we shouldn't be taking the stable names we
> get from ACPI as the dev_name() instead of our internal ones on ACPI
> systems (and possibly something similar on DT) rather than adding custom
> code like this.
This is actually somewhat confusing issue. I think it's relatively easy 
to switch using ACPI names within ASoC core (by modifying 
fmt_single_name or something like that).

Problem is that for ACPI enumerated client devices the dev_name(dev) 
still comes from those subsystems as before. So for instance dev_ prints 
in codec driver or ASoC core keeps printing "rt5640 0-001c:" as before 
and I personally find it a bit more confusing if internal ASoC names 
don't match as easily with dev_ prints.

But yes, I agree. This alias name in DAI link is not that clear either 
as it exists only during bind time.

-- 
Jarkko
