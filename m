From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] ASoC: fix compile breakage - add a missing
	header include
Date: Tue, 19 Jan 2010 08:59:30 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1001190858050.4607@axis700.grange>
References: <Pine.LNX.4.64.1001190832580.4607@axis700.grange>
	<s5htyuiilg3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id F1B0C244DE
	for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2010 08:59:30 +0100 (CET)
In-Reply-To: <s5htyuiilg3.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 19 Jan 2010, Takashi Iwai wrote:

> At Tue, 19 Jan 2010 08:39:05 +0100 (CET),
> Guennadi Liakhovetski wrote:
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > 
> > It might well have been reported and / or fixed in some trees, sorry for 
> > the noise, if that's the case.
> 
> The addition is OK, but could you give compile error messages?
> I'm asking it because no error happened in my build tests.

Sure:

In file included from sound/soc/sh/siu_pcm.c:33:
include/sound/soc-dai.h:211: error: field 'capture' has incomplete type
include/sound/soc-dai.h:212: error: field 'playback' has incomplete type
sound/soc/sh/siu_pcm.c:710: error: variable 'siu_platform' has initializer but incomplete type
sound/soc/sh/siu_pcm.c:711: error: unknown field 'name' specified in initializer
sound/soc/sh/siu_pcm.c:711: warning: excess elements in struct initializer
sound/soc/sh/siu_pcm.c:711: warning: (near initialization for 'siu_platform')
sound/soc/sh/siu_pcm.c:712: error: unknown field 'pcm_ops' specified in initializer
sound/soc/sh/siu_pcm.c:712: warning: excess elements in struct initializer
sound/soc/sh/siu_pcm.c:712: warning: (near initialization for 'siu_platform')
sound/soc/sh/siu_pcm.c:713: error: unknown field 'pcm_new' specified in initializer
sound/soc/sh/siu_pcm.c:713: warning: excess elements in struct initializer
sound/soc/sh/siu_pcm.c:713: warning: (near initialization for 'siu_platform')
sound/soc/sh/siu_pcm.c:714: error: unknown field 'pcm_free' specified in initializer
sound/soc/sh/siu_pcm.c:714: warning: excess elements in struct initializer
sound/soc/sh/siu_pcm.c:714: warning: (near initialization for 'siu_platform')
make[3]: *** [sound/soc/sh/siu_pcm.o] Error 1
make[2]: *** [sound/soc/sh] Error 2
make[2]: *** Waiting for unfinished jobs....

Thanks
Guennadi

> 
> 
> thanks,
> 
> Takashi
> 
> > 
> >  include/sound/soc-dai.h |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
> > index ca24e7f..061f16d 100644
> > --- a/include/sound/soc-dai.h
> > +++ b/include/sound/soc-dai.h
> > @@ -16,6 +16,8 @@
> >  
> >  #include <linux/list.h>
> >  
> > +#include <sound/soc.h>
> > +
> >  struct snd_pcm_substream;
> >  
> >  /*
> > -- 
> > 1.6.2.4
> > 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
