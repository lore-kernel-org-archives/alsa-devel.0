From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2] ALSA: hda - restore BCLK M/N values
 when resuming HSW/BDW display controller
Date: Fri, 27 Jun 2014 06:38:47 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B5815DC@SHSMSX101.ccr.corp.intel.com>
References: <cf161a8248cc08c0a3e1d9a59be572d1941fe2b6.1403779411.git.mengdong.lin@intel.com>
 <s5h7g44vt2d.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F82B5803B1@SHSMSX101.ccr.corp.intel.com>
 <s5h4mz7x4l5.wl%tiwai@suse.de> <s5hwqc3vl43.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 56435265053
 for <alsa-devel@alsa-project.org>; Fri, 27 Jun 2014 08:38:52 +0200 (CEST)
In-Reply-To: <s5hwqc3vl43.wl%tiwai@suse.de>
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

Hi Takashi,

Sorry. This patch cannot handle the following case:
If only embedded DP is connected on boot, the gfx driver will turn off the display power well on boot case before the audio driver probes and request this power.
So the M/V values programmed by BIOS in EM4/5 registers will be lost at the very beginning. And so the audio driver will save invalid M/N values on suspend and restore these invalid values on resume. 
One phenomenon is: if HDMI or DP monitor is connected after boot, audio playback rate is ~20% faster than normal.
And I guess it's the patch cannot fix the Haswell issue https://bugzilla.kernel.org/show_bug.cgi?id=74861

There are two possible solutions:
(1) Follows Windows model: Windows, gfx driver notifies BIOS on LPSP (when only eDP is connected) exit and BIOS reprograms those EM4/5 registers.
   There is no such implementation in Linux gfx driver now. We need time to check the effort.

(2) Gfx driver notify audio driver on exiting LPSP and CDCLK value (by reading GPU registers), so audio driver can reprograms EM4/5 registers.
  The open source interface between audio/gfx driver is still not ready. Would an private API to get CDCLK from gfx driver will be a possible workaround atm?

Could you share your opinion on this issue?

Thanks
Mengdong

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, June 26, 2014 9:47 PM

> > I'd just open-code a few read and write lines.
> 
> Thinking of this again, maybe it's better to keep the patch smaller at this
> stage, just concentrating on the fix.
> 
> We can get rid of ICH6 prefix later with a series of cleanup patches.
> 
> I'm going to take your rev2 patch then.
> 
> 
> thanks,
> 
> Takashi
