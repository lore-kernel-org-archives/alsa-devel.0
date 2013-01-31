From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ALSA: core: don't return uninitialized
 snd_compr_tstamp
Date: Wed, 30 Jan 2013 18:53:54 -0800
Message-ID: <20130131025354.GA3143@intel.com>
References: <1359599832-6210-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E56C32615E1
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 04:19:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1359599832-6210-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Vinod Koul <vinod.koul@linux.jf.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 31, 2013 at 10:37:12AM +0800, Mark Brown wrote:
> From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> 
> The snd_compr_update_tstamp() can only fill in the snd_compr_tstamp
> if the codec implements the pointer() function. If that happened
> the code was previously returning uninitialized garbage in the
> tstamp because it wasn't initialized anywhere.
> 
> This change zero-fills the tstamp in the two places it is used
> before calling snd_compr_update_tstamp(), and also has
> snd_compr_update_tstamp() return an error indication if it
> can't provide a tstamp. For the case of snd_compr_calc_avail()
> it ignores this error because we still need to return info on
> the available buffer space even if we can't provide tstamp
> info - when the tstamp is not valid all fields are now
> guaranteed to be zero.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>

--
~Vinod
