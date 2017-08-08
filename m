From: "Zhang, Keqiao" <keqiao.zhang@intel.com>
Subject: Re: XRUN support in alsabat
Date: Tue, 8 Aug 2017 14:24:14 +0000
Message-ID: <57E804B13068CF489D6E1F6E5365559B575CAC82@SHSMSX103.ccr.corp.intel.com>
References: <57E804B13068CF489D6E1F6E5365559B575CAC37@SHSMSX103.ccr.corp.intel.com>
 <s5hlgmui1l6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 51AFF2664EB
 for <alsa-devel@alsa-project.org>; Tue,  8 Aug 2017 16:24:22 +0200 (CEST)
In-Reply-To: <s5hlgmui1l6.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Keyon Jie <yang.jie@linux.intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

Thanks for your input. I will give it a try.
	
Thanks 
Keqiao

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Tuesday, August 8, 2017 10:20 PM
To: Zhang, Keqiao <keqiao.zhang@intel.com>
Cc: alsa-devel@alsa-project.org; Girdwood, Liam R <liam.r.girdwood@intel.com>; Keyon Jie <yang.jie@linux.intel.com>
Subject: Re: XRUN support in alsabat

On Tue, 08 Aug 2017 16:15:22 +0200,
Zhang, Keqiao wrote:
> 
> Hi Takashi and all,
> 
> Sorry to bother you. I'm trying to get alsabat(alsa-utils:BAT) to 
> support XRUN for driver testing and there have been no effective 
> solutions on how to inject XRUN for playback or capture. So could you 
> give me some suggestions on this?  Thanks in advance~

You can inject xrun by writing to a proc file, /proc/sound/card*/pcm*/sub*/xrun_injection,
when CONFIG_SND_PCM_XRUN_DEBUG is set.


Takashi
