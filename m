From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/5] ALSA: hdac: Add
	snd_hdac_get_hdac_stream()
Date: Sun, 23 Aug 2015 11:15:42 +0530
Message-ID: <20150823054542.GT13546@localhost>
References: <1440173181-3150-1-git-send-email-vinod.koul@intel.com>
 <1440173181-3150-4-git-send-email-vinod.koul@intel.com>
 <s5hy4h4txaa.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A4292260470
 for <alsa-devel@alsa-project.org>; Sun, 23 Aug 2015 07:43:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hy4h4txaa.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 21, 2015 at 06:35:09PM +0200, Takashi Iwai wrote:
> On Fri, 21 Aug 2015 18:06:19 +0200,
> > +/**
> > + * snd_hdac_get_hdac_stream - return hdac_stream based on stream_tag and
> > + * direction
> > + *
> > + * @bus: HD-audio core bus
> > + */
> 
> Please complete the description.
Okay will add more details

> > +EXPORT_SYMBOL_GPL(snd_hdac_get_hdac_stream);
> >  /*
> 
> Put the empty line after EXPORT_SYMBOL_GPL().
Sure


-- 
~Vinod
