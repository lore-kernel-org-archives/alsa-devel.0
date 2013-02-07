From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: core: Allow digital mute for capture
Date: Thu, 7 Feb 2013 05:34:47 -0800
Message-ID: <20130207133447.GQ3143@intel.com>
References: <1360173556-28048-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E8BDA2652AF
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2013 14:59:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1360173556-28048-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 06, 2013 at 05:59:16PM +0000, Mark Brown wrote:
> Help avoid noise from the power up of the capture path propagating through
> into the start of the recording (especially noise caused by the ramp of
> microphone biases) by keeping the capture muted until after we've finished
> powering things up with DAPM in the same manner we do for playback. This
> allows us to take advantage of soft mute support in the hardware more
> effectively and is more consistent.
> 
> The core code using the existing digital mute operation is updated to take
> advantage of this. Some additional cases in the soc-pcm code and suspend
> will need separate handling but these are less practically relevant than
> the main runtime stream start/stop case.
> 
> Rather than refactor the digital mute function in every single driver a
> new operation is added for drivers taking advantage of this functionality,
> the old operation should be phased out over time.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by Vinod Koul <vinod.koul@intel.com>
