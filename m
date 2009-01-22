From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: gusclassic alsa configuration
Date: Thu, 22 Jan 2009 23:11:05 +0100
Message-ID: <20090122231105.3ff437c2.krzysztof.h1@poczta.fm>
References: <20090121223507.778f954d.krzysztof.h1@poczta.fm>
	<20090121215037.GC4996@sci.fi> <s5h8wp37glk.wl%tiwai@suse.de>
	<20090122173332.a5b8f459.krzysztof.h1@poczta.fm>
	<s5h8wp35mg9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E6CA10380A
	for <alsa-devel@alsa-project.org>; Thu, 22 Jan 2009 23:08:03 +0100 (CET)
In-Reply-To: <s5h8wp35mg9.wl%tiwai@suse.de>
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

On Thu, 22 Jan 2009 17:34:30 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 22 Jan 2009 17:33:32 +0100,
> Krzysztof Helt wrote:
> > 
> > Hi Takashi,
> > 
> > Any chance that this GUS.conf get into the alsa-lib
> > so a non-ALSA-savvy Linux user would have at least working
> > stereo playback "out of the box"?
> 
> Yes, sure, it should be fixed.
> But before applying it -- I wonder whether you can simply use "type
> plug" instead of route plugin.  Could you check it?
> 

It works. The "plug" is even better as it allows conversion for u-law PCM
and does not require to define the ttable.

> Or, can't you simply remove these pcm.hw and pcm.default definitions
> and use the system-default one?
> 

aplay returns error: "unable to install hw params".

Regards,
Krzysztof

----------------------------------------------------------------------
Speak Up. Angielski szybko i skutecznie. 3 miesiace nauki gratis.
Sprawdz. >> http://link.interia.pl/f2019
