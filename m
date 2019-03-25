From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [alsa-devel] [PATCH] ASoC: intel: Fix crash at suspend/resume
 after failed codec registration
Date: Mon, 25 Mar 2019 07:21:00 -0700
Message-ID: <50fafc60-0ee4-ab33-8d24-dfc149215bee@roeck-us.net>
References: <1553294388-25293-1-git-send-email-linux@roeck-us.net>
 <5451ba5b-1a5d-41b0-2b39-772c326de785@linux.intel.com>
 <20190325121232.GF7284@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325121232.GF7284@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Curtis Malainey <cujomalainey@chromium.org>
List-Id: alsa-devel@alsa-project.org

On 3/25/19 5:12 AM, Mark Brown wrote:
> On Sat, Mar 23, 2019 at 09:55:46AM -0400, Pierre-Louis Bossart wrote:
> 
>> I'd like to highlight that there is a fundamental flaw in the way the
>> machine drivers are handled. Since we don't have a hook for the machine
>> driver in the BIOS, the DSP driver creates a platform_device which will
>> instantiate the machine driver. When errors happen in the machine driver
>> probe, they are suppressed due to a 'feature' of the device model, so you
>> can end-up with a broken configuration that is still reported as a
>> successful strobe.
> 
> These are driver specific issues not device model issues as far as I can
> see?  The issue fixed by this as is that you're storing a pointer in the
> ASoC level (not device model level) probe that you don't free when the
> component is unbound, causing you to dereference it later during
> suspend.  There is absolutely no problem with the machine driver not
> being guaranteed to bind at the time it's initially registered, that's
> perfectly normal and should cause no problems.
> 
It is actually a bit more complicated than that. The stored pointer (drv->soc_card)
isn't released. The problem is that dev_get_drvdata(drv->soc_card->dev) is NULL,
which causes the crash. I don't think there is a UAF involved - I built the
test image with KASAN enabled and it did not barf at me.

It may of course well be that there _should_ be a UAF but it doesn't happen
because some pointer that should be released isn't released due to some memory
or reference count leak. But that would be a different problem.

Overall the implementation does seem a bit suspicious to me. I don't really
understand why the platform driver handles suspend/resume for the cards.
But that may just be my lack of understanding. However, either case, I think the
Haswell driver (sst-haswell-pcm.c) has a similar problem. I am also not sure if
there are more problems lurking - I see a similar but different crash in v4.4.y
but have not been able to track it down. Actually, I found the problem fixed here
while trying to reproduce that crash with the latest kernel.

Guenter
