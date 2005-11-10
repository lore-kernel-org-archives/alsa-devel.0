From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [RFC] ALSA SoC layer
Date: Thu, 10 Nov 2005 11:24:46 +0000
Message-ID: <1131621886.14631.177.camel@cearnarfon>
References: <1131618567.14631.155.camel@cearnarfon>
	 <s5h8xvw22jl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from orlando.wolfsonmicro.main (webmail.wolfsonmicro.com [212.20.225.142])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AA8381AB
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2005 12:24:47 +0100 (MET)
In-Reply-To: <s5h8xvw22jl.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Richard Purdie <rpurdie@rpsys.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-11-10 at 11:57 +0100, Takashi Iwai wrote:


> 
> SoC can superseed the existing drivers, right?
> 

Yes, providing the platform/machine and codec is supported. They can
also co-exist (as in my tree atm).


> 
> At a quick glance, the code looks promising.
> Very minor nitpicks:
> 
> - case is usually not indented in switch() in kernel codes
>   (althought not written explicitly in CodingStyle).
> 
> - *_add_widgets() can be optimized with an array.
> 

I'll fix all this in 0.7 (snapshot next week)

> - documentation is missing ;)
> 

Apologies, I know. I'll try and get something together for the next
release. Promise ;)

> 
> How is the planned schedule?

Now that the pxa2xx platform is stable, I still have the following core
functionality to implement:-

o Machine codec pin connections (for dpm - only power up output if
physically connected - machine specific)
o Some code clean up (including above)
o Machine specific kcontrols.
o Mic Bias

I'm hoping to have this done in the next 2 weeks. After this, I'll be
adding other platforms. Hopefully, I'll have added iMX and some of
au1x00 by xmas time. More codecs will also be added in this time.

After the iMX platform is added the API should be relatively stable.
I'll be looking to submit patches to alsa-dev at this point. 

> I'll merge my big patches to replace xxx_t with struct xxx likely
> in the next week just after releasing ALSA 1.0.10-final.  Although the
> backward compatibility will be kept mostly, the code rewriting (just
> running sed or whatever) will be done after that.
> 
> 

ok, I'll wait until 1.0.10 and remove ASoC xxx_t. This will make ASoC
0.8 depend on 1.0.10 and above.

Cheers

Liam



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
