From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [Sound-open-firmware] [PATCH v4 16/20] ASoC: SOF:
 Add PCI device support
Date: Fri, 29 Mar 2019 20:30:41 -0400
Message-ID: <d6b6fc83-c362-4b86-ebb1-9c79dbb36858@linux.intel.com>
References: <20190321161055.26582-1-pierre-louis.bossart@linux.intel.com>
 <20190321161055.26582-17-pierre-louis.bossart@linux.intel.com>
 <20190328174819.GM9224@smile.fi.intel.com>
 <20190328174918.GN9224@smile.fi.intel.com>
 <9f48d5e7-8a95-db2f-0605-b15e45670ce0@linux.intel.com>
 <20190328220826.GQ9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190328220826.GQ9224@smile.fi.intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, sound-open-firmware@alsa-project.org, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 3/28/19 6:08 PM, Andy Shevchenko wrote:
> On Thu, Mar 28, 2019 at 02:21:47PM -0400, Pierre-Louis Bossart wrote:
>>>>> +#if IS_ENABLED(CONFIG_SND_SOC_SOF_EDISON)
>>>>
>>>> Can we use Merrifield / mrfld instead of EDISON in entire series?
>>
>> we could, but I don't know of any other platform than Edison to run the
>> code. I know it's less accurate from an architecture perspective but felt
>> Merrifield was confusing for non-Intel folks.
> 
> We use Merrifield across the entire kernel. It would be confusing other way around.
> So, please, change it to be consistent with the rest of the kernel.

Since this is the only comment so far, I'll add a follow-up patch.

> 
>>> And one more question, is there any howto to run a nocodec variant of SOF on
>>> Intel Merrifield platform?
>>
>> I haven't had time to look into this with the slew of comments on v3/v4 and
>> travel. If you have a working Edison setup with 5.0+, then this should work
>> as is.
> 
> Where to get SOF binary, and more interesting where to get sources and howto
> compile them into binary?


> 
>> the main issue is going to describe the SSP2 pins with ACPI ASL stuff
>> to make sure they are in 3.3V and the right pinmux, that's the part that I
>> keep kicking down the road. When I used Edison with the official built there
>> was a 'simple' script for the pin-mux, if you have the moral equivalent in
>> ASL I am all ears
> 
> I don't know what should be done and where, the pins themselves are in correct
> mode set by firmware (if no-one touches them as GPIOs):
> 
> pin 75 (GP40_I2S_2_CLK) mode 1 0x00003221
> pin 76 (GP41_I2S_2_FS) mode 1 0x00003221
> pin 77 (GP42_I2S_2_RXD) mode 1 0x00003221
> pin 78 (GP43_I2S_2_TXD) mode 1 0x00003221
> 
> If you talking about Edison/Arduino board and its discrete pin control, we have
> a mechanism to set it from ASL.

yep, that's the board I have.
