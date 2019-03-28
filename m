From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 16/20] ASoC: SOF: Add PCI device support
Date: Thu, 28 Mar 2019 14:21:47 -0400
Message-ID: <9f48d5e7-8a95-db2f-0605-b15e45670ce0@linux.intel.com>
References: <20190321161055.26582-1-pierre-louis.bossart@linux.intel.com>
 <20190321161055.26582-17-pierre-louis.bossart@linux.intel.com>
 <20190328174819.GM9224@smile.fi.intel.com>
 <20190328174918.GN9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190328174918.GN9224@smile.fi.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Heya Andy,

>>> +#if IS_ENABLED(CONFIG_SND_SOC_SOF_EDISON)
>>
>> Can we use Merrifield / mrfld instead of EDISON in entire series?

we could, but I don't know of any other platform than Edison to run the 
code. I know it's less accurate from an architecture perspective but 
felt Merrifield was confusing for non-Intel folks.

> And one more question, is there any howto to run a nocodec variant of SOF on
> Intel Merrifield platform?

I haven't had time to look into this with the slew of comments on v3/v4 
and travel. If you have a working Edison setup with 5.0+, then this 
should work as is. the main issue is going to describe the SSP2 pins 
with ACPI ASL stuff to make sure they are in 3.3V and the right pinmux, 
that's the part that I keep kicking down the road. When I used Edison 
with the official built there was a 'simple' script for the pin-mux, if 
you have the moral equivalent in ASL I am all ears
-Pierre
