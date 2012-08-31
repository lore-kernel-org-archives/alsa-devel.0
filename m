From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - Fix runtime PM accounting
Date: Fri, 31 Aug 2012 01:57:09 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F81DCD51@SHSMSX101.ccr.corp.intel.com>
References: <s5hwr0l7msk.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F81DA4D0@SHSMSX101.ccr.corp.intel.com>
 <s5h7gsj6i6x.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F81DAFDF@SHSMSX101.ccr.corp.intel.com>
 <s5hr4qp6cus.wl%tiwai@suse.de>	<s5hligx68xn.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F81DB7AA@SHSMSX101.ccr.corp.intel.com>
 <s5ha9xc5thz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 78F2B2663DF
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2012 03:57:17 +0200 (CEST)
In-Reply-To: <s5ha9xc5thz.wl%tiwai@suse.de>
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
> Sent: Thursday, August 30, 2012 10:45 PM
> 
> Yeah, the check seems slipped from my previous post by some reason.
> Maybe I cherry-picked a wrong branch.
> It should be
> 	if (codec->power_on)
> 		hda_call_pm_notify(codec->bus, false); and it should be called
> before module_put().
> 
> It's not needed.  In the case of snd_hda_codec_free(), the only interest is
> whether pm_notify down was already called for this this particular codec.
> And this can be checked by codec->power_on flag.
> 

Yes, an extra power flag is not needed. 

I think 'codec->d3_stop_clk_ok' flag is more suitable than 'codec->power_on' for this check:
if (!codec->d3_stop_clk_ok)				... either not suspended or d3_stop_clk_ok is not set for last suspending
	hda_call_pm_notify(codec->bus, false);

It's because the codec will call pm_notify down only when PS-ClkStopOk is set on its last suspending to D3.
And PS-ClkStopOk is dynamic flag while CLKSTOP is static. It's possible that a codec supports CLKSTOP but
does not set PS-ClkStopOk on every transition to D3.

Thanks
Mengdong
