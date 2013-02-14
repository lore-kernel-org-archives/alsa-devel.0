From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] compress: add support for gapless playback
Date: Thu, 14 Feb 2013 15:02:45 +0530
Message-ID: <20130214093244.GA27887@intel.com>
References: <1360831371-27602-1-git-send-email-vinod.koul@intel.com>
 <s5hip5vtfze.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A4DB26529D
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2013 10:33:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hip5vtfze.wl%tiwai@suse.de>
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
Cc: Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 14, 2013 at 10:13:57AM +0100, Takashi Iwai wrote:
> At Thu, 14 Feb 2013 14:12:51 +0530,
> Vinod Koul wrote:
> > 
> > this add new API for sound compress to support gapless playback.
> > As noted in Documentation change, we add API to send metadata of encoder and
> > padding delay to DSP. Also add API for indicating EOF and switching to
> > subsequent track
> > 
> > Also bump the compress API version
> > 
> > Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  v5:
> > - update metadata value with 8 words
> 
> What's the reason behind this change?  I can think of metadata like EQ
> parameters, but the magic number 8 is in question :)
Yes the concern was that there might be an issue with parameters which are not
single dwords, so 8 dwords was what came to my mind. 8 why, i picked the number
:). Seems decent enough and not too big. For even bigger pparameters I was
thinking to split..

If you think we should have 16/32 dwrods, am okay with it.

> I'm no enthusiastic over minimalism like Apple, so I don't mind this
> change, but just out of curiosity...
> 
> Also, another spot:
> 
> > @@ -145,6 +160,10 @@ struct snd_compr_codec_caps {
> >  						struct snd_compr_codec_caps)
> >  #define SNDRV_COMPRESS_SET_PARAMS	_IOW('C', 0x12, struct snd_compr_params)
> >  #define SNDRV_COMPRESS_GET_PARAMS	_IOR('C', 0x13, struct snd_codec)
> > +#define SNDRV_COMPRESS_SET_METADATA	_IOW('C', 0x14,\
> > +						 struct snd_compr_metadata)
> > +#define SNDRV_COMPRESS_GET_METADATA	_IOW('C', 0x15,\
> > +						 struct snd_compr_metadata)
Yes!
> 
> Isn't it _IOWR()?
If this is only thing, let me send the update or you want a beverage :)

--
~Vinod
