From: Alex Wiggins <alex.d.wiggins@gmail.com>
Subject: Re: [PATCH - oss plugin update revised 1/2] oss: Add
 support of 32-bit and other formats
Date: Sat, 6 Jul 2013 22:47:47 +0100
Message-ID: <CACwMDQp4zbS9_MW+8QQm4u9xoDO3jjAG3uDNzd=sMLbEAOcJcA@mail.gmail.com>
References: <51cf8030.0867b40a.36ac.ffffad56@mx.google.com>
 <s5h1u7ilit4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f45.google.com (mail-la0-f45.google.com
 [209.85.215.45])
 by alsa0.perex.cz (Postfix) with ESMTP id A00DC261700
 for <alsa-devel@alsa-project.org>; Sat,  6 Jul 2013 23:47:48 +0200 (CEST)
Received: by mail-la0-f45.google.com with SMTP id fr10so2883364lab.4
 for <alsa-devel@alsa-project.org>; Sat, 06 Jul 2013 14:47:48 -0700 (PDT)
In-Reply-To: <s5h1u7ilit4.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks again for the review Takashi.

What do you mean by making a conversion table? Do you mean like a
2-dimensional associative array to do the mapping? I'm not sure the best
way of implementing something like that in C.

Best Regards,

Alex


On 1 July 2013 10:40, Takashi Iwai <tiwai@suse.de> wrote:

> At Sun, 30 Jun 2013 01:47:07 +0100,
> alex.d.wiggins@gmail.com wrote:
> >
> > From: Alex Wiggins <alex.d.wiggins@gmail.com>
> >
> > Added support of 32-bit and other audio formats via 3 changes:
> >
> >  - Additional audio format definitions
> >    at the top of the file (if required);
> >
> >  - Additional audio formats in oss_hw_params
> >    (to allow as input to pass to OSS);
> >
> >  - Additional audio formats in oss_hw_constraint
> >    (to allow to report to ALSA).
> >
> > Signed-off-by: Alex Wiggins <alex.d.wiggins@gmail.com>
> >
> > diff --git a/oss/pcm_oss.c b/oss/pcm_oss.c
> > index d43b44c..d5b5bc4 100644
> > --- a/oss/pcm_oss.c
> > +++ b/oss/pcm_oss.c
> > @@ -24,6 +24,32 @@
> >  #include <alsa/pcm_external.h>
> >  #include <linux/soundcard.h>
> >
> > +/* definitions for additional OSS formats if required */
> > +#ifndef AFMT_S32_LE
> > +#define AFMT_S32_LE 0x00001000
> > +#endif
> > +#ifndef AFMT_S32_BE
> > +#define AFMT_S32_BE 0x00002000
> > +#endif
> > +#ifndef AFMT_S24_LE
> > +#define AFMT_S24_LE 0x00008000
> > +#endif
> > +#ifndef AFMT_S24_BE
> > +#define AFMT_S24_BE 0x00010000
> > +#endif
> > +#ifndef AFMT_S24_PACKED
> > +#define AFMT_S24_PACKED 0x00040000
> > +#endif
> > +#ifndef AFMT_FLOAT
> > +#define AFMT_FLOAT 0x00004000
> > +#endif
> > +#ifndef AFMT_SPDIF_RAW
> > +#define AFMT_SPDIF_RAW 0x00020000
> > +#endif
> > +#ifndef AFMT_VORBIS
> > +#define AFMT_VORBIS 0x00000800
> > +#endif
> > +
> >  typedef struct snd_pcm_oss {
> >       snd_pcm_ioplug_t io;
> >       char *device;
> > @@ -165,6 +191,145 @@ static int oss_hw_params(snd_pcm_ioplug_t *io,
> >       case SND_PCM_FORMAT_S16_BE:
> >               oss->format = AFMT_S16_BE;
> >               break;
> > +     /* allow additional data formats (such as 32 bit) as input
> > +        to pass to OSS (set in OSS driver) */
> > +     case SND_PCM_FORMAT_S32_LE:
> > +             oss->format = AFMT_S32_LE;
> > +             break;
> > +     case SND_PCM_FORMAT_S32_BE:
> > +             oss->format = AFMT_S32_BE;
> > +             break;
> > +     case SND_PCM_FORMAT_S8:
> > +             oss->format = AFMT_S8;
> > +             break;
> > +     case SND_PCM_FORMAT_U16_LE:
> > +             oss->format = AFMT_U16_LE;
> > +             break;
> > +     case SND_PCM_FORMAT_U16_BE:
> > +             oss->format = AFMT_U16_BE;
> > +             break;
> > +     case SND_PCM_FORMAT_S24_LE:
> > +             oss->format = AFMT_S24_LE;
> > +             break;
> > +     case SND_PCM_FORMAT_S24_BE:
> > +             oss->format = AFMT_S24_BE;
> > +             break;
> > +     case SND_PCM_FORMAT_MU_LAW:
> > +             oss->format = AFMT_MU_LAW;
> > +             break;
> > +     case SND_PCM_FORMAT_A_LAW:
> > +             oss->format = AFMT_A_LAW;
> > +             break;
> > +     case SND_PCM_FORMAT_IMA_ADPCM:
> > +             oss->format = AFMT_IMA_ADPCM;
> > +             break;
> > +     case SND_PCM_FORMAT_MPEG:
> > +             oss->format = AFMT_MPEG;
> > +             break;
> > +     case SND_PCM_FORMAT_S24_3LE:
> > +             oss->format = AFMT_S24_PACKED;
> > +             break;
> > +     case SND_PCM_FORMAT_FLOAT:
> > +             oss->format = AFMT_FLOAT;
> > +             break;
> > +     case SND_PCM_FORMAT_IEC958_SUBFRAME:
> > +             oss->format = AFMT_SPDIF_RAW;
> > +             break;
> > +     /* following formats need defining checking native endian: */
> > +     #if 0
>
> Please align #if/#endif without indentation.
>
> > +     case SND_PCM_FORMAT_S16:
> > +             oss->format = AFMT_S16_NE;
> > +             break;
> > +     case SND_PCM_FORMAT_U16:
> > +             oss->format = AFMT_U16_NE;
> > +             break;
> > +     case SND_PCM_FORMAT_S24:
> > +             oss->format = AFMT_S24_NE;
> > +             break;
> > +     case SND_PCM_FORMAT_S32:
> > +             oss->format = AFMT_S32_NE;
> > +     #endif
> > +     /* following formats found in ALSA but not in OSS: */
> > +     #if 0
> > +     case SND_PCM_FORMAT_U24_LE:
> > +             oss->format = AFMT_U24_LE;
> > +             break;
> > +     case SND_PCM_FORMAT_U24_BE:
> > +             oss->format = AFMT_U24_BE;
> > +             break;
> > +     case SND_PCM_FORMAT_U32_LE:
> > +             oss->format = AFMT_U32_LE;
> > +             break;
> > +     case SND_PCM_FORMAT_U32_BE:
> > +             oss->format = AFMT_U32_BE;
> > +             break;
> > +     case SND_PCM_FORMAT_FLOAT_LE:
> > +             oss->format = AFMT_FLOAT_LE;
> > +             break;
> > +     case SND_PCM_FORMAT_FLOAT_BE:
> > +             oss->format = AFMT_FLOAT_BE;
> > +             break;
> > +     case SND_PCM_FORMAT_FLOAT64_LE:
> > +             oss->format = AFMT_FLOAT64_LE;
> > +             break;
> > +     case SND_PCM_FORMAT_FLOAT64_BE:
> > +             oss->format = AFMT_FLOAT64_BE;
> > +             break;
> > +     case SND_PCM_FORMAT_IEC958_SUBFRAME_LE:
> > +             oss->format = AFMT_SPDIF_RAW_LE;
> > +             break;
> > +     case SND_PCM_FORMAT_IEC958_SUBFRAME_BE:
> > +             oss->format = AFMT_SPDIF_RAW_BE;
> > +             break;
> > +     case SND_PCM_FORMAT_GSM:
> > +             oss->format = AFMT_GSM;
> > +             break;
> > +     case SND_PCM_FORMAT_SPECIAL:
> > +             oss->format = AFMT_SPECIAL;
> > +             break;
> > +     case SND_PCM_FORMAT_S24_3BE:
> > +             oss->format = AFMT_S24_PACKED_BE;
> > +             break;
> > +     case SND_PCM_FORMAT_U24_3LE:
> > +             oss->format = AFMT_U24_PACKED;
> > +             break;
> > +     case SND_PCM_FORMAT_U24_3BE:
> > +             oss->format = AFMT_U24_PACKED_BE;
> > +             break;
> > +     case SND_PCM_FORMAT_S20_3LE:
> > +             oss->format = ;
> > +             break;
> > +     case SND_PCM_FORMAT_S20_3BE:
> > +             oss->format = ;
> > +             break;
> > +     case SND_PCM_FORMAT_U20_3LE:
> > +             oss->format = ;
> > +             break;
> > +     case SND_PCM_FORMAT_U20_3BE:
> > +             oss->format = ;
> > +             break;
> > +     case SND_PCM_FORMAT_S18_3LE:
> > +             oss->format = ;
> > +             break;
> > +     case SND_PCM_FORMAT_S18_3BE:
> > +             oss->format = ;
> > +             break;
> > +     case SND_PCM_FORMAT_U18_3LE:
> > +             oss->format = ;
> > +             break;
> > +     case SND_PCM_FORMAT_U18_3BE:
> > +             oss->format = ;
> > +             break;
> > +     case SND_PCM_FORMAT_U24:
> > +             oss->format = AFMT_U24_NE;
> > +             break;
> > +     case SND_PCM_FORMAT_U32:
> > +             oss->format = AFMT_U32_NE;
> > +             break;
> > +     case SND_PCM_FORMAT_FLOAT64:
> > +             oss->format = AFMT_FLOAT64;
> > +             break;
> > +     #endif
> >       default:
> >               fprintf(stderr, "*** OSS: unsupported format %s\n",
> snd_pcm_format_name(io->format));
> >               return -EINVAL;
> > @@ -239,7 +404,7 @@ static int oss_hw_constraint(snd_pcm_oss_t *oss)
> >               SND_PCM_ACCESS_MMAP_INTERLEAVED
> >       };
> >       unsigned int nformats;
> > -     unsigned int format[5];
> > +     unsigned int format[20];
> >       unsigned int nchannels;
> >       unsigned int channel[6];
> >       /* period and buffer bytes must be power of two */
> > @@ -273,6 +438,40 @@ static int oss_hw_constraint(snd_pcm_oss_t *oss)
> >               format[nformats++] = SND_PCM_FORMAT_S16_BE;
> >       if (tmp & AFMT_MU_LAW)
> >               format[nformats++] = SND_PCM_FORMAT_MU_LAW;
> > +     /* allow additional data formats (such as 32 bit)
> > +        to be reported from OSS to ALSA below */
> > +     if (tmp & AFMT_S32_LE)
> > +             format[nformats++] = SND_PCM_FORMAT_S32_LE;
> > +     if (tmp & AFMT_S32_BE)
> > +             format[nformats++] = SND_PCM_FORMAT_S32_BE;
> > +     if (tmp & AFMT_A_LAW)
> > +             format[nformats++] = SND_PCM_FORMAT_A_LAW;
> > +     if (tmp & AFMT_IMA_ADPCM)
> > +             format[nformats++] = SND_PCM_FORMAT_IMA_ADPCM;
> > +     if (tmp & AFMT_S8)
> > +             format[nformats++] = SND_PCM_FORMAT_S8;
> > +     if (tmp & AFMT_U16_LE)
> > +             format[nformats++] = SND_PCM_FORMAT_U16_LE;
> > +     if (tmp & AFMT_U16_BE)
> > +             format[nformats++] = SND_PCM_FORMAT_U16_BE ;
> > +     if (tmp & AFMT_MPEG)
> > +             format[nformats++] = SND_PCM_FORMAT_MPEG;
> > +     if (tmp & AFMT_FLOAT)
> > +             format[nformats++] = SND_PCM_FORMAT_FLOAT;
> > +     if (tmp & AFMT_S24_LE)
> > +             format[nformats++] = SND_PCM_FORMAT_S24_LE;
> > +     if (tmp & AFMT_S24_BE)
> > +             format[nformats++] = SND_PCM_FORMAT_S24_BE;
> > +     if (tmp & AFMT_SPDIF_RAW)
> > +             format[nformats++] = SND_PCM_FORMAT_IEC958_SUBFRAME;
> > +     if (tmp & AFMT_S24_PACKED)
> > +             format[nformats++] = SND_PCM_FORMAT_S24_3LE;
> > +     /* following formats found in OSS but not in ALSA */
> > +     if (tmp & AFMT_AC3)
> > +             format[nformats++] = SND_PCM_FORMAT_UNKNOWN;
> > +     if (tmp & AFMT_VORBIS)
> > +             format[nformats++] = SND_PCM_FORMAT_UNKNOWN;
>
> This conversion to SND_PCM_FORMAT_UNKNOWN isn't useful at all...
>
> > +     /* assume signed 16 bit (native CPU endian) if not found above */
> >       if (! nformats)
> >               format[nformats++] = SND_PCM_FORMAT_S16;
> >       if ((err = snd_pcm_ioplug_set_param_list(io,
> SND_PCM_IOPLUG_HW_FORMAT,
>
> Other than these, the changes are OK.
>
> But, looking at the patch again, it'd be cleaner to make a conversion
> table.  It's up to you whether you fold it into the existing patch or
> give another refactoring patch on the top of existing patch.
>
>
> thanks,
>
> Takashi
>
