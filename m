From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Surface 3 audio broken between 4.11 and 4.13
 (rt5645)
Date: Fri, 13 Oct 2017 18:49:29 -0500
Message-ID: <5f93009c-e41a-f339-442a-cf5a757460cc@linux.intel.com>
References: <1507920036.5910.46.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 76F74267713
 for <alsa-devel@alsa-project.org>; Sat, 14 Oct 2017 01:49:32 +0200 (CEST)
In-Reply-To: <1507920036.5910.46.camel@hadess.net>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bastien Nocera <hadess@hadess.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 10/13/2017 01:40 PM, Bastien Nocera wrote:
> Hey,
>
> As I was trying to test PulseAudio HDMI LPE audio support fixes, I
> realised that the internal sound card of my Surface 3 wasn't working
> anymore, using the same user-space configuration.
>
> Looks like detection of the device regressed between 2 versions. Does
> this look familiar to anyone, or should I start bisecting? (which will
> take me absolutely ages, as the CPU is anemic on that machine)
Yes this looks familiar unfortunately. Surface has a BIOS quirk iirc, 
and there are reports of broken audio on other platforms that have a 
similar quirk, see
https://bugzilla.kernel.org/show_bug.cgi?id=96691 where the patch 
7827d66946ad3af734ed46d1d68c23fa6974595c is flagged as being the issue.

I tried providing a patch for what I think is the problem, but the 
reports from users were inconsistent and I don't have access to the 
hardware.

If you could try both the revert and the suggested fix (separately) it'd 
help a great deal

>
> Working:
> $ dmesg | grep rt5
> [   13.707825] rt5640 i2c-10EC5640:00: Device with ID register 0x6308 is not rt5640/39
> [   15.010548] cht-bsw-rt5645 cht-bsw-rt5645: snd-soc-dummy-dai <-> media-cpu-dai mapping ok
> [   15.011132] cht-bsw-rt5645 cht-bsw-rt5645: snd-soc-dummy-dai <-> deepbuffer-cpu-dai mapping ok
> [   15.012756] cht-bsw-rt5645 cht-bsw-rt5645: rt5645-aif1 <-> ssp2-port mapping ok
> [   15.100152] input: chtrt5645 Headset as /devices/pci0000:00/808622A8:00/cht-bsw-rt5645/sound/card0/input27
>
> $ uname -r
> 4.11.0-0.rc0.git4.21.surface3.fc26.x86_64
>
> Not working:
> $ journalctl -b -2 | grep rt5
> Oct 13 20:10:19 surface kernel: rt5640 i2c-10EC5640:00: Device with ID register 0x6308 is not rt5640/39
> Oct 13 20:10:21 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk DMIC1_MAP enabled
> Oct 13 20:10:21 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk DMIC enabled
> Oct 13 20:10:21 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk MCLK_EN enabled
> Oct 13 20:10:21 surface kernel: bytcr_rt5640 bytcr_rt5640: ASoC: CODEC DAI rt5640-aif1 not registered
> Oct 13 20:10:21 surface kernel: bytcr_rt5640 bytcr_rt5640: devm_snd_soc_register_card failed -517
> Oct 13 20:10:22 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk DMIC1_MAP enabled
> Oct 13 20:10:22 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk DMIC enabled
> Oct 13 20:10:22 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk MCLK_EN enabled
> Oct 13 20:10:22 surface kernel: bytcr_rt5640 bytcr_rt5640: ASoC: CODEC DAI rt5640-aif1 not registered
> Oct 13 20:10:22 surface kernel: bytcr_rt5640 bytcr_rt5640: devm_snd_soc_register_card failed -517
> Oct 13 20:10:23 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk DMIC1_MAP enabled
> Oct 13 20:10:23 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk DMIC enabled
> Oct 13 20:10:23 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk MCLK_EN enabled
> Oct 13 20:10:23 surface kernel: bytcr_rt5640 bytcr_rt5640: ASoC: CODEC DAI rt5640-aif1 not registered
> Oct 13 20:10:23 surface kernel: bytcr_rt5640 bytcr_rt5640: devm_snd_soc_register_card failed -517
> Oct 13 20:10:23 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk DMIC1_MAP enabled
> Oct 13 20:10:23 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk DMIC enabled
> Oct 13 20:10:23 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk MCLK_EN enabled
> Oct 13 20:10:23 surface kernel: bytcr_rt5640 bytcr_rt5640: ASoC: CODEC DAI rt5640-aif1 not registered
> Oct 13 20:10:23 surface kernel: bytcr_rt5640 bytcr_rt5640: devm_snd_soc_register_card failed -517
>
> $ journalctl -b -2 | head -n3 | tail -n1
> Oct 13 22:10:10 surface kernel: Linux version 4.13.0-0.rc2.git0.26.surface3.fc27.x86_64 (hadess@classic) (gcc version 7.1.1 20170526 (Red Hat 7.1.1-2) (GCC)) #1 SMP Tue Jul 25 18:47:03 CEST 2017
>
> Cheers
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
