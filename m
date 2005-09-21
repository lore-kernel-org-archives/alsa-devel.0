From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-user] dmix not working with intel8x0 (ICH4)
Date: Wed, 21 Sep 2005 03:05:59 -0400
Message-ID: <1127286360.1421.5.camel@mindpipe>
References: <431527EA.6000300@nilsen.com>	<4318EBBD.8060000@nilsen.com>
	 <s5hfysjsevv.wl%tiwai@suse.de>  <431C8E81.1080701@nilsen.com>
	 <1125948816.1772.15.camel@mindpipe> <431C9E94.6010408@nilsen.com>
	 <433018DE.4060607@nilsen.com> <1127222378.20689.11.camel@mindpipe>
	 <4330203D.9040405@nilsen.com> <1127240311.20689.92.camel@mindpipe>
	 <433101BA.9080805@nilsen.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <433101BA.9080805@nilsen.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a bit over my head, someone on alsa-devel can probably answer.

You can't easily "fix it" - softvol and dmix are incompatible so
ICH4.conf is incorrect.  You have to use one or the other for now.

Lee

On Wed, 2005-09-21 at 08:46 +0200, Morten Nilsen wrote:
> Lee Revell wrote:
> > On Tue, 2005-09-20 at 16:44 +0200, Morten Nilsen wrote:
> > 
> >>mortenn@onihime ~$ xmms
> >>Message: device: default
> >>ALSA lib pcm_direct.c:777:(snd_pcm_direct_initialize_slave) unable to 
> >>install hw params
> >>ALSA lib pcm_dmix.c:814:(snd_pcm_dmix_open) unable to initialize slave
> >>
> >>** WARNING **: alsa_setup(): Failed to open pcm device (default): 
> >>Inappropriate ioctl for device
> > 
> > OK it's the interaction with dmix and softvol.
> > 
> > alsa/alsa-lib/src/pcm/pcm_dmix.c:
> > 
> > ICH4.conf:
> > 
> > So these files disagree on whether dmix + softvol is legal.  
> > Who does snd_pcm_type(spcm) not trigger the assert?  
> > Did someone forget to add softvol to the list of types?
> 
> I did some poking about in pcm.c, and this wasn't enough to fix it, in 
> any case..
> 
> --- alsa-lib-1.0.9.org/src/pcm/pcm.c    2005-05-24 16:14:31.000000000 +0200
> +++ alsa-lib-1.0.9/src/pcm/pcm.c        2005-09-21 10:31:11.898017056 +0200
> @@ -1512,6 +1512,7 @@
>          PCMTYPE(LADSPA),
>          PCMTYPE(DMIX),
>          PCMTYPE(JACK),
> +       PCMTYPE(SOFTVOL),
>   };
> 
>   static const char *snd_pcm_subformat_names[] = {



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
