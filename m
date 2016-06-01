From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Applied "ASoC: Intel: add bytct-rt5651 machine
 driver" to the asoc tree
Date: Wed, 1 Jun 2016 16:58:35 -0500
Message-ID: <ba871166-376e-bea0-07b2-f347d7ab296f@linux.intel.com>
References: <1851514.XmzcdsvJt0@wks-pdc-gentoo>
 <4617455.AlsP6hqDsl@wks-pdc-gentoo>
 <c524cc06-caa7-6080-412b-041c9b1af386@linux.intel.com>
 <8428317.tXclBn20Ko@wks-pdc-gentoo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6431D265218
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2016 23:58:38 +0200 (CEST)
In-Reply-To: <8428317.tXclBn20Ko@wks-pdc-gentoo>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pietro <pxpert@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/1/16 4:43 PM, Pietro wrote:
> Hi,
>
> Sorry for the wrong information:
> the 2 DSDTs were decompiled using different iasl versions (20140828 for Android vs 20150717 for Linux), giving apparently different results (the functions were decoded differently, but the keys were the same).
>
> The tablet is a dual boot Windows+Android (Surely based on AndroidIA, with a Patched gmin kernel... Obviously the sources were not provided by the manifacturer).
>
> I've made some tests using both the firmware included in Android, and the upstream ones, with no apparent results (Always slow Audio).
>
> But when you suggested me to use the fw_sst_22a8.bin I was trying to load the Android one, giving me load errors. Now I've tried the upstream one and it works with correct timing settings (!!)
>
> Then I've tried to restore the 4.5.2 stock bytcr_rt5651.c, but this gave me inconsistent playback: The speed was right, but there were continue audio artifacts (like the ones given by a bad resampler, to give you an idea).
> Using the patched driver, following your suggestion (patching it exatcly as I've wrote in the past E-Mails), solved this issue, so now the Audio is correctly played.
>
> In the following days I'll make some tests (For example audio recording, switch between Headset and Speakers Etc.) and let you know if I'll find other issues.
>
> Thanks for your continuous support, I've really appreciated it.

Good to hear!
Yes as a general rule mixing upstream drivers with Android firmware and 
vice-versa is not a good idea, and using the MCLK is the only way to 
solve audio quality issues, it's however not enabled on every board 
unfortunately. When we have the clock driver I will make this the 
default and use quirks to go back to bit-clock based PLL configs.
If you want to send me a patch I can merge it with the rest of Baytrail 
cleanups still being worked on.

>
> Pietro
>
>
> On Wednesday 01 June 2016 10:13:17 Pierre-Louis Bossart wrote:
>> On 6/1/16 3:38 AM, Pietro wrote:
>>> Hi,
>>>
>>>
>>>
>>> The Kernel error messages should be related to the Intel DRM graphics,
>>> so I don't care about them (at least for now).
>>>
>>>
>>>
>>> Anyway I don't know if tese warning can in some way be related to my
>>> problem:
>>>
>>>
>>>
>>> [ 9.565990] rt5651 i2c-10EC5651:00: ASoC: mux INL1 Mux has no paths
>>>
>>> [ 9.586586] rt5651 i2c-10EC5651:00: ASoC: mux INR1 Mux has no paths
>>>
>>> [ 9.586596] rt5651 i2c-10EC5651:00: ASoC: mux INL2 Mux has no paths
>>>
>>> [ 9.586601] rt5651 i2c-10EC5651:00: ASoC: mux INR2 Mux has no paths
>>
>> probably the config is incorrect, I didn't enable capture in the UCM file
>>
>>>
>>> [ 12.646035] sst-mfld-platform sst-mfld-platform: Slot control:
>>> codec_out tx interleaver slot 0 doesn't have DAPM widget!!!
>>>
>>> [ 12.649356] sst-mfld-platform sst-mfld-platform: Slot control:
>>> codec_out tx interleaver slot 1 doesn't have DAPM widget!!!
>>>
>>> [ 12.652673] sst-mfld-platform sst-mfld-platform: Slot control:
>>> codec_out tx interleaver slot 2 doesn't have DAPM widget!!!
>>>
>>> [ 12.656323] sst-mfld-platform sst-mfld-platform: Slot control:
>>> codec_out tx interleaver slot 3 doesn't have DAPM widget!!!
>>>
>>> [ 12.659868] sst-mfld-platform sst-mfld-platform: Slot control: codec_in
>>> rx deinterleaver codec_in0_0 doesn't have DAPM widget!!!
>>>
>>> [ 12.663456] sst-mfld-platform sst-mfld-platform: Slot control: codec_in
>>> rx deinterleaver codec_in0_1 doesn't have DAPM widget!!!
>>
>> this last warning is fixed upstream.
>>
>>> For your convenience I've extracted the DSDT from Android and Linux,
>>> because they seem to differ. Here they are:
>>>
>>>
>>>
>>> DSDT Linux: http://paste.ubuntu.com/16885538/
>>>
>>> DSDT Android: http://paste.ubuntu.com/16885557/
>>
>> DSDT is OS independent so that doesn't make sense.
>> Just to be clear, is this an Android tablet on which you are installing
>> ubuntu?
>> And did you try to use the firmware from upstream or from the Android
>> distribution?
>>
>>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
