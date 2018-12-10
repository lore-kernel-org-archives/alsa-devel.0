From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/7] ALSA: hda: Refactor display power
 management
Date: Mon, 10 Dec 2018 14:52:05 -0600
Message-ID: <1ff2c83b-fb5e-2972-77d0-e32c247e9912@linux.intel.com>
References: <20181209093318.27829-1-tiwai@suse.de>
 <20181209093318.27829-3-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id EE974267AFE
 for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2018 21:52:07 +0100 (CET)
In-Reply-To: <20181209093318.27829-3-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


On 12/9/18 3:33 AM, Takashi Iwai wrote:
> The current HD-audio code manages the DRM audio power via too complex
> redirections, and this seems even still unbalanced in a corner case as
> Intel DRM CI has been intermittently reporting.  This patch is a big
> surgery for addressing the complexity and the possible unbalance.
>
> Basically the patch changes the display PM in the following ways:
>
> - Both HD-audio controller and codec drivers call a single helper,
>    snd_hdac_display_power().  (Formerly, the display power control from
>    a codec was done indirectly via link_power bus ops.)
>
> - snd_hdac_display_power() receives the codec address index.  For
>    turning on/off from the controller, pass HDA_CODEC_IDX_CONTROLLER.

The need for this virtual index==16 isn't fully clear to me, especially 
if you use the bitfields instead of reference counts.

Isn't there a risk of the controller setting the bit16 to zero, but you 
still have bit4 on (assuming the idx is 4). If you use this virtual 
index, it should override the actual physical bits when set/cleared.

Or is this meant to actually implement a preemption mechanism, where the 
display power remains on for as long as the controller wishes, 
regardless of what the patch_hdmi and hdac_hdmi code requests?

Also don't we already have the HDMI codec address already after the 
probe, so couldn't we provide the address directly?
