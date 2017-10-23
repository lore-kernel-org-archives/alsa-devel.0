From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 02/14] soundwire: Add SoundWire bus type
Date: Mon, 23 Oct 2017 12:52:54 +0100
Message-ID: <1508759574.29460.4.camel@linux.intel.com>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-3-git-send-email-vinod.koul@intel.com>
 <20171020104528.GC3210@kroah.com>
 <CAOFm3uExqnB45SDFKJo811aaEfeaEC02TUdpmPj1Wq9QEWqy_g@mail.gmail.com>
 <20171020162042.GW30097@localhost> <20171020162723.GB6674@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AC28266A73
 for <alsa-devel@alsa-project.org>; Mon, 23 Oct 2017 13:53:04 +0200 (CEST)
In-Reply-To: <20171020162723.GB6674@kroah.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, plai@codeaurora.org, Shreyas NC <shreyas.nc@intel.com>, Pierre <pierre-louis.bossart@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Philippe Ombredanne <pombredanne@nexb.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

> > I quick grep on Dual license users looks like we already have this
> > in kernel
> > code. See drivers/ntb/hw/intel/ntb_hw_intel.c
> 
> Just because someone did something wrong in the past, doesn't mean
> they
> should keep doing more wrong things in the future :)

What makes you think it's wrong ? It's the same approach the kernel has
been using since back to Linux 1.2 and maybe earlier.

I know it's not your intention but you are also going to look bad to
the BSD and other communities if you try and break dual licensing as a
standard Linux thing for some code. It goes back decades (Ted's random
driver for example).

Alan
