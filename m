From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: CS4232 Playback bug on Tecra 500
Date: Fri, 23 Jan 2009 13:08:28 +0100
Message-ID: <20090123130828.ae7236b2.krzysztof.h1@poczta.fm>
References: <405205790901212040s79ce94a4if4ff742a9c18bc67@mail.gmail.com>
	<20090122134150.f6d0e192.krzysztof.h1@poczta.fm>
	<405205790901220743k32d76edeh733b2dacfbf0497e@mail.gmail.com>
	<20090122172856.e39ae951.krzysztof.h1@poczta.fm>
	<s5h7i4n5mar.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id EAC4B24400
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 13:05:25 +0100 (CET)
In-Reply-To: <s5h7i4n5mar.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Stanley Pinchak <stanley.pinchak@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 22 Jan 2009 17:37:48 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 22 Jan 2009 17:28:56 +0100,
> Krzysztof Helt wrote:
>>
> > Next thing is that your have a second driver loaded: 
> > the snd-cs4236. Do not load this driver. AFAIR, the 
> > snd-cs4236 driver should be blacklisted or removed
> > on laptop with the cs4232 chip and PNP BIOS. The 
> > cs4236 and cs4232 have the same PNP BIOS id-s.
> > The snd-cs4236 was incorrectly loaded instead of 
> > the snd-cs4232 at least on my laptop (old Dell).
> 
> Isn't there any way to check this conflict between CS4232 and CS4236?
> If we can know that the particular card is for snd-cs4232, snd-cs4236
> could give a warning and quit...
> 

I don't know. A chip inside my laptop is identified as CS4236 but works
with the snd-cs4232 driver. I have to open the laptop to verify. 
I remember problems when it run with the snd-cs4236 driver.

Regards,
Krzysztof


----------------------------------------------------------------------
Zobacz gry internetowe dla dzieci!
sprawdz >>>http://link.interia.pl/f202c
