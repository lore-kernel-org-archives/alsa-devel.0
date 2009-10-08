From: krzysztof.h1@poczta.fm
Subject: Re:
	=?utf-8?q?sscape=3A_make_more_code_=5F=5Fdevinit_and?=
	=?utf-8?q?_other_improvements?=
Date: 08 Oct 2009 09:01:39 +0200
Message-ID: <20091008070140.117A13E8853@f38.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id D91F010396F
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 09:01:40 +0200 (CEST)
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org



"Takashi Iwai" <tiwai@suse.de> pisze:
> At Wed, 7 Oct 2009 18:45:37 +0200,
> Krzysztof Helt wrote:
> > 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > Make code to upload firmware marked as __devinit.
> 
> I guess the mark would be removed again if you implement suspend/resume
> :)
> If you are not going to implement PM, I'm willing to apply this patch,
> though.
> 

I haven't thought about this. Drop the patch then.

> > General code and coding style improvements.
> > 
> > Add a missing argument for CMD_XXX_MIDI_VOL command.
> > 
> > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> > ---
> > This is the last my patch for the sscape driver.
> > 
> > I will examine if the OSS aedsp16 driver can be removed as well. The
> corresponding 
> > ALSA driver is snd-sc6000.
> 
> Yeah, that'll be nice.
> 
> 

I have a strange problem. The sscape and aedsp16 drivers do not work correctly with OSS drivers (DMA/IRQ problem) but they work correctly with ALSA + OSS emulation. I will check more cards (e.g. SB16). It may a new bug in the OSS layer.

Regards,
Krzysztof


----------------------------------------------------------------------
Zobacz najwiekszy samolot na swiecie!  
Kliknij >>> http://link.interia.pl/f238f
