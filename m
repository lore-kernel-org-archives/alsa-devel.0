From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: intel: Fix crash at suspend/resume
 after failed codec registration
Date: Mon, 25 Mar 2019 09:18:04 -0400
Message-ID: <b6d2bdc5-d0e8-dee7-52be-fa7f3a36fa9f@linux.intel.com>
References: <1553294388-25293-1-git-send-email-linux@roeck-us.net>
 <5451ba5b-1a5d-41b0-2b39-772c326de785@linux.intel.com>
 <20190325121232.GF7284@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190325121232.GF7284@sirena.org.uk>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Curtis Malainey <cujomalainey@chromium.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org

On 3/25/19 8:12 AM, Mark Brown wrote:
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

Agree, what I was referring is that if the machine probe and card 
registration fails (not just deferred), the parent acpi/pci driver isn't 
notified - there is just no means to provide that information and that 
leads to all kinds of configuration issues.
