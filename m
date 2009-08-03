From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH - amixer] listen to D-Bus for volume-up,
 volume-down and mute signals.
Date: Mon, 03 Aug 2009 20:29:23 +0100
Message-ID: <1249327763.4248.138.camel@vega.slimlogic.co.uk>
References: <1249296201-6930-1-git-send-email-stlman@poczta.fm>
	<s5hocqxcgqb.wl%tiwai@suse.de> <4A76D239.70202@poczta.fm>
	<s5hiqh5ccyr.wl%tiwai@suse.de> <20090803121747.GD5959@sirena.org.uk>
	<4A771774.8040408@poczta.fm>
	<20090803170222.GA23621@rakim.wolfsonmicro.main>
	<4A771F89.3010103@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from slimlogic.co.uk (slimlogic.co.uk [89.16.172.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 5898C24371
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 00:35:56 +0200 (CEST)
In-Reply-To: <4A771F89.3010103@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lukasz Stelmach <stlman@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, stefan <stefan@datenfreihafen.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2009-08-03 at 19:34 +0200, Lukasz Stelmach wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Mark Brown pisze:
> > On Mon, Aug 03, 2009 at 06:59:32PM +0200, Lukasz Stelmach wrote:
> >> Mark Brown pisze:
> > 
> >>> I tend to agree, merging it into amixer seems kind of arbatrary.  Such a
> >>> daemon (and its dbus interface) may also be useful for handling things
> >>> like scenario management so I can see it growing over time.
> > 
> >> Scenario management? Could you please say something more what I
> >> have not been missing for so long ;-)
> > 
> > See http://www.slimlogic.co.uk/?p=40
> 
> Thanks. That's definitely not anything I had in mind doing that patch.
> 

We are about to start another sprint on the scenario manager in
September. Eventual aim would be to merge in into alsa-lib and salsa for
audio hardware control abstraction. i.e. abstract per device/card
hardware audio mixers/muxes/gains/attenuations/switches settings into a
generic and meaningful scenario (or use case) e.g. "Headset Phone Call".

dbus integration is something that interests me. Please take a look at
the scenario lib public header and let me know if the API fits into your
design.

http://git.slimlogic.co.uk/?p=alsa-scenario.git;a=blob;f=include/ascenario.h;h=fd341133a601e121978054d5b2064a7a1b2d78b7;hb=8bd7f83d847424eb44704cf1649974b2fda8d8f1


Thanks

Liam 
