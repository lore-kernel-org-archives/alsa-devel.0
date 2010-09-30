From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: Microphone not working on PCI ID 8086:3b56
Date: Thu, 30 Sep 2010 23:29:45 +0800
Message-ID: <AANLkTinT3EU3aLSBt5WmA=qDOf1cFABUNG+RiT3Nvx3e@mail.gmail.com>
References: <Pine.LNX.4.64.1009302047410.25061@boston.corp.fedex.com>
	<s5hsk0rtlun.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 446E324408
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 17:29:47 +0200 (CEST)
Received: by wwb28 with SMTP id 28so2107646wwb.20
	for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2010 08:29:46 -0700 (PDT)
In-Reply-To: <s5hsk0rtlun.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 30, 2010 at 9:14 PM, Takashi Iwai <tiwai@suse.de> wrote:

> Check /sys/modules/snd_hda_intel/parameters/model whether you really
> passed the correct value.

# cat /sys/module/snd_hda_intel/parameters/model
lenovo-x200,(null),(null),(null),(null),(null),(null),(null)

>> in my case as I'm not using udev. Here's a patch to take away the default so non-udev will still
>> works.
>
> Wow, what's a conservative system :)

Keeping things simple :)  and my / root filesystem is mounted read-only.

Thanks,
Jeff
