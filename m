From: Sangbeom Kim <sbkim73@samsung.com>
Subject: RE: [alsa-devel] [PATCH 1/4] ASoC: SAMSUNG: Modify I2S driver to
	support idma
Date: Mon, 13 Jun 2011 16:58:52 +0900
Message-ID: <005101cc299f$bde608d0$39b21a70$@com>
References: <1307606950-8310-1-git-send-email-sbkim73@samsung.com>
 <1307606950-8310-2-git-send-email-sbkim73@samsung.com>
 <BANLkTikbB6RG5Q+xGUEtxDzFGWSpe+c+6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <BANLkTikbB6RG5Q+xGUEtxDzFGWSpe+c+6Q@mail.gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Jassi Brar' <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, broonie@opensource.wolfsonmicro.com, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 9, 2011 at 8:31 PM, Jassi Brar wrote:
> 
> >        case 2:
> > +               if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> > +                       i2s->dma_playback.dma_size = 4;
> > +               else
> > +                       i2s->dma_capture.dma_size = 4;
> > +               break;
> 
> Why do we need this ?
This code don't need here, I will delete it.
> 
> 
> 
> > +       case 1:
> > +               if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> > +                       i2s->dma_playback.dma_size = 2;
> > +               else
> > +                       i2s->dma_capture.dma_size = 2;
> 
> I2S doesn't support Mono.
Yes, But some application require mono recording.
It is needed mono recording support.

> 
> >  #define SAMSUNG_I2S_RCLKSRC_0  0
> >  #define SAMSUNG_I2S_RCLKSRC_1  1
> > -#define SAMSUNG_I2S_CDCLK              2
> > +#define SAMSUNG_I2S_CDCLK      2
> Please avoid inconsequential changes.
OK,

> The need of i2s.h is for machine drivers. Please move these register/bit
> definitions to a new header(say i2s-regs.h) if we have to share them with
> idma.c
OK, I2S register have to share with idma, I will create new header file.

> 
> > +#define msecs_to_loops(t)      (loops_per_jiffy / 1000 * HZ * t)
> > +
> > +#define ST_RUNNING             (1<<0)
> > +#define ST_OPENED              (1<<1)
> These should be moved to the c file that uses them.
I will move it.

Thanks,
