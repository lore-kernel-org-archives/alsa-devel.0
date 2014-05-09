From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: hda - using POS_FIX_LPIB on
 Broadwell HDMI Audio
Date: Fri, 09 May 2014 09:58:18 -0500
Message-ID: <536CED0A.9060902@linux.intel.com>
References: <1399485804-75028-1-git-send-email-libin.yang@intel.com>
 <s5hzjisq2kj.wl%tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D195232A6@SHSMSX103.ccr.corp.intel.com>
 <s5htx90q0mi.wl%tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19523313@SHSMSX103.ccr.corp.intel.com>
 <s5hr444pzap.wl%tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D1952333A@SHSMSX103.ccr.corp.intel.com>
 <s5hoaz8pydg.wl%tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D195233B1@SHSMSX103.ccr.corp.intel.com>
 <536BAB70.3010905@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F82B40F3CB@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B179D261A40
 for <alsa-devel@alsa-project.org>; Fri,  9 May 2014 16:58:20 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F82B40F3CB@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>, David Henningsson <david.henningsson@canonical.com>, "Yang, Libin" <libin.yang@intel.com>, Takashi Iwai <tiwai@suse.de>, "anssi.hannula@iki.fi" <anssi.hannula@iki.fi>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 5/9/14, 5:08 AM, Lin, Mengdong wrote:
> Hi,
>
> We found the Broadwell HDMI audio regression is introduced by this patch:
>
> commit dcb32ecd9a533f47ab652c5c5680bc50a7a822cd
> Author: Anssi Hannula <anssi.hannula@iki.fi>
> Date: Tue Apr 8 12:36:42 2014 +0300
> ALSA: hda - Do not assign streams in reverse order
>
> We'll further check the root cause.
> Since this patch seems only affect the stream ID. Actually Intel GPU tool only find the stream ID is changed by this patch.
>
> In addition, Haswell HDMI audio is not affected and works well. It seems there is HW behavior difference between HSW and BDW.

It's unlikely that the wallclock is the issue here. LPIB and wallclock 
only make sense for the short link to the GPU, where the data is 
reshuffled. It'd look into how the audio data is inserted in the HDMI 
frame, the fact that the behavior is linked to a channel order or stream 
ID points to GPU-level configuration, not a counter issue at the HDAudio 
controller level.
-Pierre
