From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: rt5645: fix build warning
Date: Thu, 08 Oct 2015 17:33:22 +0300
Message-ID: <56167EB2.9060608@linux.intel.com>
References: <1444220532-14199-1-git-send-email-sudipm.mukherjee@gmail.com> <20151007140527.GK12635@sirena.org.uk> <20151008085550.GA3806@sudip-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151008085550.GA3806@sudip-pc>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 10/08/2015 11:55 AM, Sudip Mukherjee wrote:
> On Wed, Oct 07, 2015 at 03:05:27PM +0100, Mark Brown wrote:
>> On Wed, Oct 07, 2015 at 05:52:12PM +0530, Sudip Mukherjee wrote:
>>> We were getting build warning about "Section mismatch".
>>> dmi_platform_intel_broadwell is being referenced from the probe function
>>> rt5645_i2c_probe(), but dmi_platform_intel_broadwell was marked with
>>> __initdata.
>>>
>>> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
>>
>>> -static struct dmi_system_id dmi_platform_intel_broadwell[] __initdata = {
>>> +static struct dmi_system_id dmi_platform_intel_broadwell[] = {
>>
>> This doesn't seem like the obvious fix - why are we not annotating the
>> probe function suitably (or alternatively if we can't why does
>> __initdata still exist)?
>
> probe function should not be __init. probe can be called anytime after
> the module has been loaded.
> __initdata still exists as that part of the code was added by
> e9159e7577cf ("ASoC: rt5645: Add dmi for Broadwell") which is a very
> recent modification and I think that has been added by mistake.
> One more argument in my favor:
> The use in probe function is
> if (dmi_check_system(dmi_platform_intel_braswell) ||
> 		dmi_check_system(dmi_platform_intel_broadwell))
>
> dmi_platform_intel_braswell is not marked as __initdata but
> dmi_platform_intel_broadwell is marked but they both have same use at
> the same place.
>
If one really wants to save a few bytes then one could annotate this it 
with __initdata_or_module (very low use in kernel) but I don't think 
it's worth of effort and probably should be done for other sections here 
too by another patch.

To me this patch looks a right thing to do at the moment.

Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
