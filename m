From: s864@ii.uib.no (Ronny V. Vindenes)
Subject: Re: Hercules Gamesurround Fortissimo III 7.1
Date: 01 Jul 2003 12:01:58 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <vh38yri5zvt.fsf@rovflue.ii.uib.no>
References: <200306271848.20758.gtdev@spearhead.de>
	<3EFD89F2.5000609@cucumelo.org>
	<200306281504.24313.gtdev@spearhead.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200306281504.24313.gtdev@spearhead.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nicos Gollan <gtdev@spearhead.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Nicos Gollan <gtdev@spearhead.de> writes:

> On Saturday 28 June 2003 14:28, Benny Sjostrand wrote:
> > But, amp_hercules(...) and hercules_mixer_init(...) function have only
> > been implemented to do some specific initializations to the Game Theater XP
> > card, which probably is very similar to the Fortissimo card, but my guess is
> > that something slight diferenent is needed on the initialization phase.
> > [...]
> > If you say that it works better with the external_amp=1, then this card
> > must have some similarity with the Santa Cruz card ... the amp_voyectra(...)
> > function will also  set some GPIO's on the seconary cs4294 codec, who knows
> > if this is good or bad for the Fortissimo card ....
> 
> It worked for some time (with the mentioned distortion and crackling but seems 
> to have stopped working now. Sound now dies after about a minute from module 
> load, even after a cold reboot. Behaviour now is the same independent from 
> external_amp. I don't have the slightest idea why this is so. I had the 
> machine switched off for a week, turned it on and it was like this. The only 
> thing that changed is the VGA card, but it does the same thing even in pure 
> text mode, without DRM drivers or AGPGART modules loaded.
> 
> So in conclusion, I can only say that external_amp was good for the card but 
> only for some time :-/
> 
> Also, the problems now seem to be somewhat independent from Windows drivers 
> having seen the card before. In the past, I had all kinds of different side 
> effects, ranging from the card running better after a reboot from Windows to 
> complete inactivity.
> 
> > What about the other functions on the card:
> > Have you tested the SPDIF output/input AC3 pass-through?
> >  the different outputs, center, rear, surround speakers ?
> 
> Sorry, I don't have any hardware that knows SPDIF. The analog speaker outputs 
> all seemed to be dead.
> 

Are you sure it's not just the card that is dead/dying? I've been
running the card since last year without any problems, except the
"distortion at full pcm volume" problem.

-- 
Ronny V. Vindenes <s864@ii.uib.no>


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
