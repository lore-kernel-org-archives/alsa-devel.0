From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - Fix runtime PM accounting
Date: Sun, 2 Sep 2012 15:51:33 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F81DDAA8@SHSMSX101.ccr.corp.intel.com>
References: <s5hwr0l7msk.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F81DA4D0@SHSMSX101.ccr.corp.intel.com>
 <s5h7gsj6i6x.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F81DAFDF@SHSMSX101.ccr.corp.intel.com>
 <s5hr4qp6cus.wl%tiwai@suse.de>	<s5hligx68xn.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F81DB7AA@SHSMSX101.ccr.corp.intel.com>
 <s5ha9xc5thz.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F81DCD51@SHSMSX101.ccr.corp.intel.com>
 <s5h4nnj594c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id D7CBA264F06
 for <alsa-devel@alsa-project.org>; Sun,  2 Sep 2012 17:51:38 +0200 (CEST)
In-Reply-To: <s5h4nnj594c.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Saturday, September 01, 2012 12:17 AM

> > I think 'codec->d3_stop_clk_ok' flag is more suitable than
> 'codec->power_on' for this check:
> > if (!codec->d3_stop_clk_ok)				... either not suspended or
> d3_stop_clk_ok is not set for last suspending
> > 	hda_call_pm_notify(codec->bus, false);
> 
> Right, this should be something like that.
> 
> It's overall confusing to check codec->d3_stop_clk_ok at that point, though.
> And the confusion comes from the fact that we are using this flag for
> multiple purposes -- the flag indicating the hardware status and the flag
> indicating whether the pm-notification has been done.
> 
> So I did a few clean ups in my tree now.  Essentially I replaced
> codec->d3_stop_clk_ok with codec->pm_down_notified to make the
> meaning
> clearer.  Also the check of D3_STOP_CLK_OK bit was moved to the
> hda_power_down_work() so that it's performed only in the power save.
> 

Yeah, the flag's new name is more direct and make code easy to understand.

Thanks
Mengdong
