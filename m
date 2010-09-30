From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: Microphone not working on PCI ID 8086:3b56
Date: Thu, 30 Sep 2010 23:45:57 +0800
Message-ID: <20100930154557.GD11399@localhost>
References: <Pine.LNX.4.64.1009302047410.25061@boston.corp.fedex.com>
	<s5hsk0rtlun.wl%tiwai@suse.de>
	<AANLkTinT3EU3aLSBt5WmA=qDOf1cFABUNG+RiT3Nvx3e@mail.gmail.com>
	<s5h4od7tf43.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id C7B9C103834
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 17:46:05 +0200 (CEST)
Content-Disposition: inline
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 30, 2010 at 11:39:40PM +0800, Takashi Iwai wrote:
> At Thu, 30 Sep 2010 23:29:45 +0800,
> Jeff Chua wrote:
> > 
> > On Thu, Sep 30, 2010 at 9:14 PM, Takashi Iwai <tiwai@suse.de> wrote:
> > 
> > > Check /sys/modules/snd_hda_intel/parameters/model whether you really
> > > passed the correct value.
> > 
> > # cat /sys/module/snd_hda_intel/parameters/model
> > lenovo-x200,(null),(null),(null),(null),(null),(null),(null)
> 
> OK, and did you get the corresponding kernel message?

As a kindly reminder, these verbose options are pretty useful:

CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y

Thanks,
Fengguang
