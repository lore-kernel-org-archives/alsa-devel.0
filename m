From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: Microphone not working on PCI ID 8086:3b56
Date: Fri, 1 Oct 2010 01:31:33 +0800
Message-ID: <AANLkTinuE=p3Pe0JDKQb=BstpZ=r-xXu3uSZueT2HFCR@mail.gmail.com>
References: <Pine.LNX.4.64.1009302047410.25061@boston.corp.fedex.com>
	<s5hsk0rtlun.wl%tiwai@suse.de>
	<AANLkTinT3EU3aLSBt5WmA=qDOf1cFABUNG+RiT3Nvx3e@mail.gmail.com>
	<s5h4od7tf43.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7293010382B
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 19:31:33 +0200 (CEST)
Received: by wyb42 with SMTP id 42so2134861wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2010 10:31:33 -0700 (PDT)
In-Reply-To: <s5h4od7tf43.wl%tiwai@suse.de>
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

On Thu, Sep 30, 2010 at 11:39 PM, Takashi Iwai <tiwai@suse.de> wrote:

>> # cat /sys/module/snd_hda_intel/parameters/model
>> lenovo-x200,(null),(null),(null),(null),(null),(null),(null)
>
> OK, and did you get the corresponding kernel message?

HDA Intel 0000:00:1b.0: PCI INT B -> GSI 17 (level, low) -> IRQ 17
HDA Intel 0000:00:1b.0: irq 45 for MSI/MSI-X
HDA Intel 0000:00:1b.0: setting latency timer to 64
ALSA device list:
#0: HDA Intel at 0xf2520000 irq 45


Thanks,
Jeff.
