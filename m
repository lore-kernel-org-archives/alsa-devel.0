From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Intel SST and HP ElitePad 1000 G2
Date: Wed, 25 Nov 2015 08:40:17 -0600
Message-ID: <5655C851.4020405@linux.intel.com>
References: <6A230045C5A9854B97A1D40971AC8BE1023ACE6013@NTMBOX.central.cirsa.com>
 <6A230045C5A9854B97A1D40971AC8BE1023ACE601C@NTMBOX.central.cirsa.com>
 <565346A2.8060702@linux.intel.com>
 <6A230045C5A9854B97A1D40971AC8BE1023ACE601E@NTMBOX.central.cirsa.com>
 <56547FE6.6050204@linux.intel.com>
 <6A230045C5A9854B97A1D40971AC8BE1023ACE6022@NTMBOX.central.cirsa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 05A49261A83
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 15:40:19 +0100 (CET)
In-Reply-To: <6A230045C5A9854B97A1D40971AC8BE1023ACE6022@NTMBOX.central.cirsa.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jorge Fernandez Monteagudo <jorgefm@cirsa.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 11/25/15 2:49 AM, Jorge Fernandez Monteagudo wrote:
> Hi,
>
> I've generated a new kernel, a 4.3.0, only with
>
> CONFIG_SND_SST_MFLD_PLATFORM=m
> CONFIG_SND_SST_IPC=m
> CONFIG_SND_SST_IPC_ACPI=m
> CONFIG_SND_SOC_INTEL_SST=m
> CONFIG_SND_SOC_INTEL_SST_ACPI=m
> CONFIG_SND_SOC_INTEL_BAYTRAIL=m
> CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH=m
> CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
> CONFIG_SND_SOC_I2C_AND_SPI=m
>
> and I've downloaded the firmware this repository (I don't know this git is the official one)
> from http://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git
>
> But I have no audio. The firmware is loaded, I see this traces
>
> [    4.013712] baytrail-pcm-audio baytrail-pcm-audio: FW version: 04.05.13.a0
> [    4.013714] baytrail-pcm-audio baytrail-pcm-audio: Build type: a0
> [    4.013716] baytrail-pcm-audio baytrail-pcm-audio: Build date: Apr  2 2014 14:14:39
>
> but the mapping is not done. In the 4.2.5 kernel I see
>
> [    4.256939] byt-rt5640 byt-rt5640: rt5640-aif1 <-> baytrail-pcm-audio mapping ok

You are mixing two incompatible options that result in a broken 
configuration. this message is for the 'old' machine driver. Use only

CONFIG_SND_SST_MFLD_PLATFORM=m
CONFIG_SND_SST_IPC=m
CONFIG_SND_SST_IPC_ACPI=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m

as I mentioned.

I tried to add a mutually exclusive choice but menuconfig complains 
about circular dependencies, need to find a better way of handling these 
two drivers so that they can't be enabled at the same time
