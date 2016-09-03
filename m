From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/4] ALSA: control: return payload length
 for TLV operation
Date: Sat, 3 Sep 2016 12:53:08 +0900
Message-ID: <cefef785-21e5-71c1-6132-1c894711f20b@sakamocchi.jp>
References: <1472514285-3769-1-git-send-email-o-takashi@sakamocchi.jp>
 <1472514285-3769-2-git-send-email-o-takashi@sakamocchi.jp>
 <8bb43ca3-eaf1-9f03-1f73-540f96941ae1@ladisch.de>
 <9f0188ab-31c9-d42d-ba2c-8718d5b97c49@sakamocchi.jp>
 <20160830145136.GE9355@localhost>
 <38f437e4-56e7-dc7a-6892-c1d812fd56d3@sakamocchi.jp>
 <20160831042040.GO9355@localhost> <57C65D4A.9090209@sakamocchi.jp>
 <20160831090552.GZ21682@localhost.localdomain> <s5hzintgtsr.wl-tiwai@suse.de>
 <e95db80c-682d-b186-ea9e-a4a8a5501329@ladisch.de>
 <a21ab28c-12d5-41c2-9209-4127fe3ca79a@sakamocchi.jp>
 <s5hlgzae17q.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id B8D862673BF
 for <alsa-devel@alsa-project.org>; Sat,  3 Sep 2016 05:53:18 +0200 (CEST)
In-Reply-To: <s5hlgzae17q.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, broonie@linaro.org, Vinod Koul <vinod.koul@intel.com>, Clemens Ladisch <clemens@ladisch.de>, omair.m.abdullah@intel.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Sep 3 2016 01:05, Takashi Iwai wrote:
> But, the addition of the flag is helpful alone.  Could you concentrate
> on that and resubmit?

Before starting it, I'd like to wait for comments from Clemens Ladisch,
Charles Keepax and Vinod Koul, in a view of application interfaces
stable, safe and tolerant for long term usage. I'm unwilling to use my
time more for light-minded work done to bring confusions to hardware-
abstraction layers for user land applications.

But, if possible, I'd request you to re-think about my proposal to
return processed byte of TLV packet payload to user land, again. It
looks to be intrusive, but in my taste, it doesn't bring much impacts to
applications, than adding new flags to kernel/userspace interfaces.

The length of processed bytes from drivers in ALSA SoC part might help
developers to get current value of 'struct soc_bytes_ext.max' of each
control element set. As of kernel 4.8, soc-da7218/nau8825/wm5102 modules
implements the coefficients, and it's already in ALSA topology design. I
believe it better to assist developers for the feature, than judging
it's coarse and abuse for good APIs.


Regards

Takashi Sakamoto
