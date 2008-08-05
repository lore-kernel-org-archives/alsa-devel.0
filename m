From: krzysztof.h1@poczta.fm
Subject: Re: [PATCH 03/11] wss_lib: rename cs4321_foo to wss_foo
Date: 05 Aug 2008 08:18:17 +0200
Message-ID: <20080805061817.9D87F1465021@f15.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 8CFFE24573
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Aug 2008 08:18:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>, Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

> On 31-07-08 21:03, Krzysztof Helt wrote:
> 
> Takashi, you already applied these but is it possible to still get my 
> Acked-by (or Reviewed-by, whatever you want) on them? When a problem is 
> bisected to one of these, people tend to put the people in the patch 
> tags in CC and I looked at them and would like to be informed of any 
> trouble. I tested most users by now, and we'll get the azt2320 fixed 
> before this hits the streets but I still like to be in the loop on any 
> traffic concerning them.
> 
> Acked-by: Rene Herman <rene.herman@gmail.com>
> 
> (or Reviewed-by, Tested-by, ...)
> 
> Below comments not important:
> 
> > @@ -679,23 +679,25 @@ static int __devinit snd_opl3sa2_probe(s
> 
> [ ... ]
> 
> > -	chip->cs4231 = cs4231;
> > -	if ((err = snd_cs4231_pcm(cs4231, 0, NULL)) < 0)
> > +	chip->wss = wss;
> > +	err = snd_wss_pcm(wss, 0, NULL);
> > +	if (err < 0)
> >  		return err;
> > -	if ((err = snd_cs4231_mixer(cs4231)) < 0)
> > +	err = snd_wss_mixer(wss);
> > +	if (err < 0)
> >  		return err;
> >  	if ((err = snd_opl3sa2_mixer(chip)) < 0)
> >  		return err;
> 
> <mumble>
> 

I think about doing some code improvements in the opl3sa2 e.g. use
WSS tlv macros instead of the tlv macros defined localy.

Regards,
Krzysztof

----------------------------------------------------------------------
Tani Telefon!
Sprawdz >>>  http://link.interia.pl/f1ec0  
