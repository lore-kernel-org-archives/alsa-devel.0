From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: Re: [PATCH] sscape: support for audio part of VIVO
 cards
Date: Mon, 17 Sep 2007 15:58:03 +0200
Message-ID: <20070917155803.8ed52f7d.krzysztof.h1@gmail.com>
References: <20070916225024.b72b4547.krzysztof.h1@gmail.com>
	<s5hodg1eaox.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by alsa0.perex.cz (Postfix) with ESMTP id A3A83103867
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Sep 2007 15:50:43 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so1008323nfd
	for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2007 06:50:43 -0700 (PDT)
In-Reply-To: <s5hodg1eaox.wl%tiwai@suse.de>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Sep 2007 14:30:22 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Sun, 16 Sep 2007 22:50:24 +0200,
> Krzysztof Helt wrote:
> > 
> > @@ -358,6 +360,8 @@ static void soundscape_free(struct snd_c
> >  {
> >  	register struct soundscape *sscape = get_card_soundscape(c);
> >  	release_and_free_resource(sscape->io_res);
> > +	if (sscape->wss_res)
> > +		release_and_free_resource(sscape->wss_res);
> 
> You don't need NULL check here.
> 

I need it as the SS PnP does not request a separate region for codec (wss_port). So the SS PnP do not allocate this resource and it must not be freed.

> > @@ -1253,6 +1323,8 @@ _release_dma:
> >  	free_dma(dma1[dev]);
> >  
> >  _release_region:
> > +	if (wss_res)
> > +		release_and_free_resource(wss_res);
> 

The same as the above. The SS PnP never sets wss_ret.

Regards,
Krzysztof
