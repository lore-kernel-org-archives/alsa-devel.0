From: krzysztof.h1@poczta.fm
Subject: Re: [PATCH] wss_lib: snd_wss_calibrate_mute improvement
Date: 18 Aug 2008 13:16:56 +0200
Message-ID: <20080818111656.4018E7DC939@f47.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id C9B83243F7
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Aug 2008 13:16:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@keyaccess.nl>
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>
List-Id: alsa-devel@alsa-project.org

> At Mon, 18 Aug 2008 10:50:15 +0200,
> Rene Herman wrote:
> > 
> > On 17-08-08 22:38, Krzysztof Helt wrote:
> > 
> > > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > > 
> > > Mute sound by setting mute bit without
> > > setting volume to 0. It makes both source code
> > > and binary shorter.
> > > 
> > > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > Grmmbbled-over-by: Rene Herman <rene.herman@gmail.com>
> > 
> > This should be safe and the current function indeed generates crap code
> 
> > but in the sense of always expecting the worst broken hardware variants
> 
> > to be out there I must say I'd rather have seen that GCC were beter. But
> 
> > yes, sure.
> 
> Yeah, the slightest concern is the intention of using 0x80 there.
> If this patch was already tested on some real hardwares (and I guess
> it should work), I'm willing to apply it.  Krzystof, was this tested
> on your machines?
> 

I have tested it only on cs4236 (inside laptop) and opti931 I have in the old PC at the moment. If you want I can retest on more hardware.

The second check I noticed that for some registers the volume is defined as gain (so 0 is the least audible) and for some (CS4231_MONO_CTRL, CS4231_LEFT/RIGHT_OUTPUT) is defined as attentuation (the 0 is the most audible). In two cases, the old code set volume to the loudest and mute it with mute bit, probably the opposite what was intended.

It is not a crucial patch. You may drop it.

Regards,
Krzysztof

----------------------------------------------------------------------
Wygraj laptopa lub iPoda! Wez udzial w igrzyskach!
Kliknij >>> http://link.interia.pl/f1eda 
