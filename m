From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [PATCH] drm/i915: HDMI - Clear Audio Enable bit
 for Hot Plug unconditionally
Date: Thu, 13 Sep 2012 11:13:45 +0800
Message-ID: <20120913031345.GA21291@localhost>
References: <1347504976-2342-1-git-send-email-xingchao.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DF6C2616E9
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 05:13:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347504976-2342-1-git-send-email-xingchao.wang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wang Xingchao <xingchao.wang@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, daniel.vetter@ffwll.ch, intel-gfx@lists.freedesktop.org, yakui.zhao@intel.com, michael.fu@intel.com
List-Id: alsa-devel@alsa-project.org

>  	u32 enable_bits = SDVO_ENABLE;
>  
> -	if (intel_hdmi->has_audio)
> -		enable_bits |= SDVO_AUDIO_ENABLE;
> +	enable_bits |= SDVO_AUDIO_ENABLE;

The two lines can be combined:

  	u32 enable_bits = SDVO_ENABLE | SDVO_AUDIO_ENABLE;

Thanks,
Fengguang
