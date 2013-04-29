From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ALSA: compress: fix the states to check
 for allowing read
Date: Mon, 29 Apr 2013 14:27:11 +0530
Message-ID: <20130429085711.GK24632@intel.com>
References: <1367136322-24531-1-git-send-email-vinod.koul@intel.com>
 <s5hmwsh1ztj.wl%tiwai@suse.de> <20130429084531.GJ24632@intel.com>
 <s5hehdt1ymt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 43E2E261A08
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2013 11:30:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hehdt1ymt.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 29, 2013 at 11:20:42AM +0200, Takashi Iwai wrote:
> > I started with switch and then didnt want to code for all the PCM_STATES... but
> > yes that makes more sense, i will send that right away.
> 
> You can code like
> 	switch (stream->runtime->state) {
> 	case SNDRV_PCM_STATE_RUNNING:
> 	case SNDRV_PCM_STATE_DRAINING:
> 	case SNDRV_PCM_STATE_PAUSED:
> 	case SNDRV_PCM_STATE_SETUP:
> 		break; /* OK */
> 	default:
> 		retval = -EBADFD;
> 		break;
> 	}
Yup, and i did exactly opposite, let me know if you want like this :)

--
~Vinod
