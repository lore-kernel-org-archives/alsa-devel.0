From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: RFC: support for 12 & 24Khz
Date: Thu, 25 Jul 2013 21:02:42 +0530
Message-ID: <20130725153242.GM18642@intel.com>
References: <20130724172640.GE18642@intel.com> <51F0C97B.6040307@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B809626084C
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 18:11:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51F0C97B.6040307@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.jf.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 25, 2013 at 08:45:15AM +0200, David Henningsson wrote:
> On 07/24/2013 07:26 PM, Vinod Koul wrote:
> >Hey Takashi,
> >
> >For compressed audio we also need to support the PCM rates of 12 and 24KHz.
> >
> >Looking at pcm.h these are not defined so we can simply add them at the end.
> >But am worried about wider impact of adding these rates.
> >
> >Can you let me know if more is required to be done or below is fine
> >
> >diff --git a/include/sound/pcm.h b/include/sound/pcm.h
> >index 84b10f9..e418d8d 100644
> >--- a/include/sound/pcm.h
> >+++ b/include/sound/pcm.h
> >@@ -126,6 +126,8 @@ struct snd_pcm_ops {
> >  #define SNDRV_PCM_RATE_96000           (1<<10)         /* 96000Hz */
> >  #define SNDRV_PCM_RATE_176400          (1<<11)         /* 176400Hz */
> >  #define SNDRV_PCM_RATE_192000          (1<<12)         /* 192000Hz */
> >+#define SNDRV_PCM_RATE_12000           <1<<13>         /* 12000Hz */
> >+#define SNDRV_PCM_RATE_24000           <1<<14>         /* 24000Hz */
> 
> You probably meant (1<<13), not <1<<13> ?
Yup :)

~Vinod
