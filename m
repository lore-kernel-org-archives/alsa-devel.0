From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH] drm/i915: HDMI - Clear Audio Enable bit
 for Hot Plug unconditionally
Date: Thu, 13 Sep 2012 03:37:42 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC48900FF6254D@SHSMSX102.ccr.corp.intel.com>
References: <1347504976-2342-1-git-send-email-xingchao.wang@intel.com>
 <20120913031345.GA21291@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D721261743
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 05:37:47 +0200 (CEST)
In-Reply-To: <20120913031345.GA21291@localhost>
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
To: "Wu, Fengguang" <fengguang.wu@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Zhao,
 Yakui" <yakui.zhao@intel.com>, "Fu, Michael" <michael.fu@intel.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Wu, Fengguang
> Sent: Thursday, September 13, 2012 11:14 AM
> To: Wang, Xingchao
> Cc: intel-gfx@lists.freedesktop.org; alsa-devel@alsa-project.org;
> daniel.vetter@ffwll.ch; tiwai@suse.de; Zhao, Yakui; Fu, Michael
> Subject: Re: [PATCH] drm/i915: HDMI - Clear Audio Enable bit for Hot Plug
> unconditionally
> 
> >  	u32 enable_bits = SDVO_ENABLE;
> >
> > -	if (intel_hdmi->has_audio)
> > -		enable_bits |= SDVO_AUDIO_ENABLE;
> > +	enable_bits |= SDVO_AUDIO_ENABLE;
> 
> The two lines can be combined:
> 
>   	u32 enable_bits = SDVO_ENABLE | SDVO_AUDIO_ENABLE;

Looks better, I send out V2 patch for Daniel.

-- Xingchao
