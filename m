From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: Microphone not working on PCI ID 8086:3b56
Date: Thu, 30 Sep 2010 23:38:20 +0800
Message-ID: <20100930153820.GB11399@localhost>
References: <Pine.LNX.4.64.1009302047410.25061@boston.corp.fedex.com>
	<s5hsk0rtlun.wl%tiwai@suse.de>
	<AANLkTinT3EU3aLSBt5WmA=qDOf1cFABUNG+RiT3Nvx3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id B7F9F10381F
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 17:38:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTinT3EU3aLSBt5WmA=qDOf1cFABUNG+RiT3Nvx3e@mail.gmail.com>
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

On Thu, Sep 30, 2010 at 11:29:45PM +0800, Jeff Chua wrote:
> On Thu, Sep 30, 2010 at 9:14 PM, Takashi Iwai <tiwai@suse.de> wrote:
> 
> > Check /sys/modules/snd_hda_intel/parameters/model whether you really
> > passed the correct value.
> 
> # cat /sys/module/snd_hda_intel/parameters/model
> lenovo-x200,(null),(null),(null),(null),(null),(null),(null)

Would you run http://www.alsa-project.org/alsa-info.sh and show us the
collected info?

> >> in my case as I'm not using udev. Here's a patch to take away the default so non-udev will still
> >> works.
> >
> > Wow, what's a conservative system :)
> 
> Keeping things simple :)  and my / root filesystem is mounted read-only.

Sounds more like "sophisticated immune" than "simple" :)

Thanks,
Fengguang
