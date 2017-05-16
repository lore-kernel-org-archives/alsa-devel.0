From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH 10/13] sound: fix the comments that refers to kernel-doc
Date: Tue, 16 May 2017 07:46:53 -0300
Message-ID: <20170516074653.187d499f@vento.lan>
References: <cover.1494775891.git.mchehab@s-opensource.com>
        <3514c2b81341c160bf6753cb47fa2346f3b5a0e7.1494775891.git.mchehab@s-opensource.com>
        <s5hshk6bied.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <s5hshk6bied.wl-tiwai@suse.de>
Sender: linux-doc-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, alsa-devel@alsa-project.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Em Mon, 15 May 2017 11:04:26 +0200
Takashi Iwai <tiwai@suse.de> escreveu:

> On Sun, 14 May 2017 17:38:44 +0200,
> Mauro Carvalho Chehab wrote:
> > 
> > The markup inside the #if 0 comment actually refers to a
> > kernel-doc markup. As we're getting rid of DocBook update it.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>  
> 
> I guess you prefer taking it from your tree?  Feel free to take my
> ack:
>   Reviewed-by: Takashi Iwai <tiwai@suse.de>

In the specific case of this patch, it doesn't matter much from what
tree it would be merged, as no other patch depends on it ;)

So, if you prefer, you can merge it directly on your tree. Otherwise,
I'll keep it on my pile of patches to be send to docs -next.


> 
> 
> thanks,
> 
> Takashi
> 
> > ---
> >  include/sound/pcm.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/sound/pcm.h b/include/sound/pcm.h
> > index 361749e60799..bbf97d4c4c17 100644
> > --- a/include/sound/pcm.h
> > +++ b/include/sound/pcm.h
> > @@ -1054,7 +1054,7 @@ int snd_pcm_format_unsigned(snd_pcm_format_t format);
> >  int snd_pcm_format_linear(snd_pcm_format_t format);
> >  int snd_pcm_format_little_endian(snd_pcm_format_t format);
> >  int snd_pcm_format_big_endian(snd_pcm_format_t format);
> > -#if 0 /* just for DocBook */
> > +#if 0 /* just for kernel-doc */
> >  /**
> >   * snd_pcm_format_cpu_endian - Check the PCM format is CPU-endian
> >   * @format: the format to check
> > -- 
> > 2.9.3
> > 
> >   



Thanks,
Mauro
