From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: Microphone not working on PCI ID 8086:3b56
Date: Thu, 30 Sep 2010 21:29:37 +0800
Message-ID: <20100930132937.GA5728@localhost>
References: <Pine.LNX.4.64.1009302047410.25061@boston.corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 9655224383
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 15:31:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1009302047410.25061@boston.corp.fedex.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 30, 2010 at 09:11:07PM +0800, Jeff Chua wrote:
> 
> 
> On Tue, Sep 28, 2010 at 9:42 PM, Takashi Iwai <tiwai@suse.de> wrote:
> > Enable all CONFIG_SND_HDA_*.
> 
> Done that. Still no mic.
> 
> 
> On Tue, Sep 28, 2010 at 9:42 PM, Wu Fengguang <fengguang.wu@intel.com> 
> wrote:
> > It's easier to enable all of them. They are small modules.
> 
> Tried just about everything, still no mic. Sounds works in all cases.
> 
> 
> I found that with SND_HDA_CODEC_INTELHDMI selected, SND_DYNAMIC_MINORS 
> will be enabled by default which won't work in my case as I'm not using 
> udev. Here's a patch to take away the default so non-udev will still 
> works.

Intel HDMI audio selects SND_DYNAMIC_MINORS because it runs out of the
static minor numbers. I initially proposed an extended static
allocation scheme here:
http://comments.gmane.org/gmane.linux.alsa.devel/72916 however the
idea was rejected.

> Do I really need udev to get mic to work?

You can disable SND_HDA_CODEC_INTELHDMI for now. You don't need it.

Thanks,
Fengguang

> 
> 
> 
> --- lx/sound/pci/hda/Kconfig.org	2010-09-14 16:34:52.000000000 +0800
> +++ lx/sound/pci/hda/Kconfig	2010-09-14 16:35:09.000000000 +0800
> @@ -145,7 +145,6 @@
> 
>   config SND_HDA_CODEC_INTELHDMI
>   	bool "Build INTEL HDMI HD-audio codec support"
> -	select SND_DYNAMIC_MINORS
>   	default y
>   	help
>   	  Say Y here to include INTEL HDMI HD-audio codec support in
