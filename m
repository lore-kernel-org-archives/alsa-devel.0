From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: hda_codec: Unknown model for ALC268
Date: Mon, 12 Jan 2009 10:04:24 +0800
Message-ID: <20090112020424.GB7505@localhost>
References: <49691579.2070600@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 1212A1037ED
	for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2009 03:04:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49691579.2070600@web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stefanie <21_halfthetruth@web.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 10, 2009 at 10:39:05PM +0100, Stefanie wrote:
> Hello!
> 
> I have problems with the sound chip of my notebook. It is a Medion akoya
> WIM 2220. Actually, there is a driver for the chip, but somehow, I can't
> get it to work. I'm desperate and don't know what to do.
> 
> My friend helped my to gather the following information:
> 
> This is from lspci:
> 
> 00:1b.0 0403: 8086:284b (rev 04)
> 
> 00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio
> Controller (rev 04)
>         Subsystem: Wistron Corp. Device 4085
>         Flags: fast devsel, IRQ 22
>         Memory at fa200000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [50] Power Management version 2
>         Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+
> Count=1/1 Enable-
>         Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
>         Capabilities: [100] Virtual Channel <?>
>         Capabilities: [130] Root Complex Link <?>
>         Kernel modules: snd-hda-intelk <?>
>  
> I have found this in my syslog while trying to load snd-hda-intel:
> 
> Jan 10 21:30:16 Mescalin HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22
> (level, low) -> IRQ 22
> Jan 10 21:30:16 Mescalin HDA Intel 0000:00:1b.0: setting latency timer to 64
> Jan 10 21:30:16 Mescalin hda_codec: Unknown model for ALC268, trying
> auto-probe from BIOS...
> Jan 10 21:30:16 Mescalin hda_codec: Cannot set up configuration from
> BIOS.  Using base mode...
> Jan 10 21:30:16 Mescalin SPDIF already defined
> Jan 10 21:30:16 Mescalin HDA Intel 0000:00:1b.0: PCI INT A disabled
> Jan 10 21:30:16 Mescalin HDA Intel: probe of 0000:00:1b.0 failed with
> error -16

Hi Stefanie,

There are some pre-defined models for ALC268:

static const char *alc268_models[ALC268_MODEL_LAST] = {
        [ALC267_QUANTA_IL1]     = "quanta-il1",
        [ALC268_3ST]            = "3stack",
        [ALC268_TOSHIBA]        = "toshiba",
        [ALC268_ACER]           = "acer",
        [ALC268_ACER_DMIC]      = "acer-dmic",
        [ALC268_ACER_ASPIRE_ONE]        = "acer-aspire",
        [ALC268_DELL]           = "dell",
        [ALC268_ZEPTO]          = "zepto",
#ifdef CONFIG_SND_DEBUG
        [ALC268_TEST]           = "test",
#endif  
        [ALC268_AUTO]           = "auto",
};      

You can try them with commands like

        modprobe snd-hda-intel model=3stack

and report the one works for you, so that we integrate this knowledge
into future kernel versions.

You are also welcome to provide your hardware information by running 
        http://www.alsa-project.org/alsa-info.sh
and upload the data collected by it.

Thanks,
Fengguang
