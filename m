From: "Cyril.Coquilleau@UTBM.fr" <Cyril.Coquilleau@utbm.fr>
Subject: Re: capture with non-interleaved mode
Date: Wed, 15 Oct 2003 21:09:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1066244996.3f8d9b8432ca9@webmail.utbm.fr>
References: <200310141219.h9ECJShP002900@oud> <1066145440.3f8c16a008002@webmail.utbm.fr> <s5hn0c3u7mm.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0c3u7mm.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > > >Hi. I'm developping a signal processing program which needs to compute
> data
> > > 
> > > >from each channel of soundcards separately. 
> > > >After searches I found that I must open the soundcard with the 
> > > >SND_PCM_ACCESS_RW_NONINTERLEAVED flag but it doesn't works well : for
> each
> > > 
> > > >readn operation i get the -32 error code . Meanwhile, I tested capture
> in 
> > > >interleaved mode and it works well.
> > > >I had to use hw:x,y for the interleaved capture and plughw:x,y for the
> > > non-
> > > >interleaved capture, I don't know if non-interleaved capture works
> with
> > > hw:x,y.
> > > 
> > > [ We need a FAQ ... ]
> > > 
> > > ALSA's "hw" devices can only be used with parameters that match
> > > capabilities offered by the underlying hardware. There's not much
> > > hardware out there that supports non-interleaved I/O, so as a result,
> > > most "hw" devices can't do this. The Hammerfall and ice1712 series are
> > > notable exceptions. But there is a corollary: if you were using a
> > > hammerfall, the "hw" device cannot do interleaved I/O either.
> > > 
> > > as to your error, its probably a bug in your code. JACK uses
> > > non-interleaved mode by default, and it works with both plughw and hw
> > > models of many different kinds. if you posted the relevant parts of it
> > > here, somebody can probably help you.
> > > 
> > > 
> > 
> > I join the relevant parts of the source (without error handlers) :
> > 
> > #define BUF_SIZE 128
> > #define ECHANT 44100
> > 
> > struct snd_card
> > {
> >   snd_pcm_t *handle;
> >   snd_pcm_hw_params_t *params;
> > 
> >   short inputBuffer[BUF_SIZE*2];  
> >   void *buffer[2];
> > };
> > typedef struct snd_card snd_card_t;
> > 
> > int 
> > main (....)
> > {
> >   char card_id[32];
> >   int err;
> >   itn card = 0;
> >   snd_card_t *card1;
> >   
> >   card1 = calloc(1,sizeof(snd_card_t));
> >   card1->buffer[0] = card1->inputBuffer;
> >   card1->buffer[1] = &card1->inputBuffer[BUF_SIZE];
> >   snprintf (card_id, 32, "plughw:%d", card);
> >   
> >   snd_pcm_open (&card1->handle, card_id, SND_PCM_STREAM_CAPTURE, 0);
> >   snd_pcm_hw_params_malloc (&card1->params);
> >   snd_pcm_hw_params_any (card1->handle, card1->params);
> >   snd_pcm_hw_params_set_channels (card1->handle, card1->params, 2);
> >   snd_pcm_hw_params_set_access (card1->handle, card1->params,
> > SND_PCM_ACCESS_RW_NONINTERLEAVED);
> >   snd_pcm_hw_params_set_format (card1->handle, card1->params,
> > SND_PCM_FORMAT_S16_LE);
> >   snd_pcm_hw_params_set_rate_near (card1->handle, card1->params, ECHANT,
> 0);
> >   snd_pcm_hw_params (card1->handle, card1->params);
> >   snd_pcm_hw_params_free (card1->params);
> >   snd_pcm_prepare (card1->handle);
> > 
> >   while (...)
> >   {
> >     err = snd_pcm_readn (card1->handle, card1->buffer, BUF_SIZE);
> >     printf("err=%d, buff=%d\n", err, card1->buffer[0]);
> >     ...
> >   }
> >  ...
> > }
> > 
> > 
> > 
> > And here is the result of printf 
> > err=-32, buff=-1
> 
> -32 is EPIPE.  it's likely buffer under/overrun.
> 
> 

I've not managed to fix this bug into my program... Do you see the error on my 
code (bad soundcard initialization or other) or have you got another way to 
propose me to capture the two channels of my soundcard separately ?

Cyril


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
