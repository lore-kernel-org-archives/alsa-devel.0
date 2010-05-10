From: Ben Collins <bcollins@bluecherry.net>
Subject: Re: [RFC] G.723-24 format patch
Date: Mon, 10 May 2010 13:50:26 -0400
Message-ID: <1273513826.4325.4.camel@maclara>
References: <1272728163.4822.31.camel@maclara> <s5h632ysojc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.221.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B56E8247A2
	for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 19:50:33 +0200 (CEST)
Received: by qyk9 with SMTP id 9so6207507qyk.2
	for <alsa-devel@alsa-project.org>; Mon, 10 May 2010 10:50:30 -0700 (PDT)
In-Reply-To: <s5h632ysojc.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 2010-05-08 at 11:58 +0200, Takashi Iwai wrote:
> At Sat, 01 May 2010 11:36:03 -0400,
> Ben Collins wrote:
> > 
> > I'm writing a driver for a card that only has hardware support for
> > G.723-24 ADPCM format. I am working around the lack of support in alsa
> > at the moment for this format, but wanted to take a crack at
> > implementing it properly.
> > 
> > G.723-24 is a 3-bit signed sample at a fixed 8khz mono sample rate
> > (24000 bit rate). Basically means you need to take in at least 3 bytes
> > (8 samples) minimum for processing the standard packed version.
> > 
> > I don't have hardware that supports it, but since I was in the code, I
> > added a G723_24_1B format for producing 1 sample per byte (3 lower bits
> > are actual sample), but for my use I am producing the standard packed
> > stream.
> > 
> > Only question I had is that since this is signed, should I expect or
> > want the _1B version to be a 1 byte sign extended version of the 3-bit
> > sample, or just expect the lower 3 bits of the byte to be the g723-24
> > sample? Looking at other unpacked examples, I assume the latter rather
> > than the former.
> 
> I suppose both are non-linear formats, so you shouldn't give
> signed/unsigned flags for them.  Otherwise snd_pcm_format_linear()
> will return 1.
> 
> Other than that, addition of these new formats look good to me.

I may not be understanding the implications of setting them as
signed/unsigned. G.723 decoder treats each sample as signed. Does
alsa-lib do special things when it is signed even though it doesn't
understand the actual encoding?

And my understanding of sound encoding is very limited, so if you could
explain the non-linear part too, I could answer the question better.

Thanks

> 
> thanks,
> 
> Takashi
> 
> 
> > diff --git a/include/sound/asound.h b/include/sound/asound.h
> > index 1f57bb9..16fc633 100644
> > --- a/include/sound/asound.h
> > +++ b/include/sound/asound.h
> > @@ -212,7 +212,9 @@ typedef int __bitwise snd_pcm_format_t;
> >  #define	SNDRV_PCM_FORMAT_S18_3BE	((__force snd_pcm_format_t) 41)	/* in three bytes */
> >  #define	SNDRV_PCM_FORMAT_U18_3LE	((__force snd_pcm_format_t) 42)	/* in three bytes */
> >  #define	SNDRV_PCM_FORMAT_U18_3BE	((__force snd_pcm_format_t) 43)	/* in three bytes */
> > -#define	SNDRV_PCM_FORMAT_LAST		SNDRV_PCM_FORMAT_U18_3BE
> > +#define	SNDRV_PCM_FORMAT_G723_24	((__force snd_pcm_format_t) 44) /* 8 samples in 3 bytes */
> > +#define	SNDRV_PCM_FORMAT_G723_24_1B	((__force snd_pcm_format_t) 45) /* 1 sample in 1 byte */
> > +#define	SNDRV_PCM_FORMAT_LAST		SNDRV_PCM_FORMAT_G723_24_1B
> >  
> >  #ifdef SNDRV_LITTLE_ENDIAN
> >  #define	SNDRV_PCM_FORMAT_S16		SNDRV_PCM_FORMAT_S16_LE
> > diff --git a/include/sound/pcm.h b/include/sound/pcm.h
> > index de6d981..031e2cd 100644
> > --- a/include/sound/pcm.h
> > +++ b/include/sound/pcm.h
> > @@ -173,6 +173,8 @@ struct snd_pcm_ops {
> >  #define SNDRV_PCM_FMTBIT_U18_3LE	(1ULL << SNDRV_PCM_FORMAT_U18_3LE)
> >  #define SNDRV_PCM_FMTBIT_S18_3BE	(1ULL << SNDRV_PCM_FORMAT_S18_3BE)
> >  #define SNDRV_PCM_FMTBIT_U18_3BE	(1ULL << SNDRV_PCM_FORMAT_U18_3BE)
> > +#define SNDRV_PCM_FMTBIT_G723_24	(1ULL << SNDRV_PCM_FORMAT_G723_24)
> > +#define SNDRV_PCM_FMTBIT_G723_24_1B	(1ULL << SNDRV_PCM_FORMAT_G723_24_1B)
> >  
> >  #ifdef SNDRV_LITTLE_ENDIAN
> >  #define SNDRV_PCM_FMTBIT_S16		SNDRV_PCM_FMTBIT_S16_LE
> > diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
> > index ea2bf82..c7f8da4 100644
> > --- a/sound/core/pcm_misc.c
> > +++ b/sound/core/pcm_misc.c
> > @@ -128,6 +128,10 @@ static struct pcm_format_data pcm_formats[SNDRV_PCM_FORMAT_LAST+1] = {
> >  		.width = 4, .phys = 4, .le = -1, .signd = -1,
> >  		.silence = {},
> >  	},
> > +	[SNDRV_PCM_FORMAT_G723_24] = {
> > +		.width = 3, .phys = 3, .le = -1, .signd = 1,
> > +		.silence = {},
> > +	},
> >  	/* FIXME: the following three formats are not defined properly yet */
> >  	[SNDRV_PCM_FORMAT_MPEG] = {
> >  		.le = -1, .signd = -1,
> > @@ -186,6 +190,10 @@ static struct pcm_format_data pcm_formats[SNDRV_PCM_FORMAT_LAST+1] = {
> >  		.width = 18, .phys = 24, .le = 0, .signd = 0,
> >  		.silence = { 0x02, 0x00, 0x00 },
> >  	},
> > +	[SNDRV_PCM_FORMAT_G723_24_1B] = {
> > +		.width = 3, .phys = 8, .le = -1, .signd = 1,
> > +		.silence = {},
> > +	},
> >  };
> >  
> > 
> > 
> > 
> > 
> > 
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > 
