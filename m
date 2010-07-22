From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 0/1] *** SUBJECT HERE ***
Date: Thu, 22 Jul 2010 13:02:08 +0100
Message-ID: <20100722120208.GF4737@rakim.wolfsonmicro.main>
References: <1279791534-20028-1-git-send-email-matti.j.aaltonen@nokia.com>
	<20100722094832.GC4737@rakim.wolfsonmicro.main>
	<A1C7E76B4973664FBB6C554A75234AC62BEEEB72A5@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6D397243E4
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 14:02:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <A1C7E76B4973664FBB6C554A75234AC62BEEEB72A5@NOK-EUMSG-02.mgdnok.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: matti.j.aaltonen@nokia.com
Cc: alsa-devel@alsa-project.org, peter.ujfalusi@nokia.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 22, 2010 at 01:18:32PM +0200, matti.j.aaltonen@nokia.com wrote:
> From: ext Mark Brown [broonie@opensource.wolfsonmicro.com]

> >> >> +static int wl1273_set_dai_fmt(struct snd_soc_dai *codec_dai,
> >> >> +                           unsigned int fmt)
> >> >> +{
> >> >> +     return 0;
> >> >> +}

> >> >Remove unused functions.

> >> I tried leaving this out but then the codec stopped working. I guess I should
> >> mention that my test environment is 2.6.32. I'm only able to test that
> >> the codec compiles under 2.6.35. Anyway I left the function in.

> >Could you please be a little more specific - what do you mean when you
> >say "the CODEC stopped working?  The set_dai_fmt() function has always
> >been optional.

> I get this error message:

> aplay  -f dat -Dhw:wl1273 /root/sumppi.wav 
> [  297.179626] Can't set codec DAI configuration: -22
> [  297.184539] asoc: BT/FM PCM startup failed

So, obviously if your machine driver tries to configure the DAI format
on a device that doesn't support configuring the DAI format that's not
going to work.  You should just remove the attempt to do something
unsupported from the machine driver rather than adding a null function.
If there is a function there it needs to at least do validation of the
parameters.

> >So why do you believe that the soc_card driver needs to know the CODEC
> >mode?  This was the gist of my original question...

[Reflowed into 80 colummns, please fix your MUA configuration.]
> OK, sorry... The problem in a sense is that the codec supports three
> different modes: BT, FM RX and FM TX. All digital audio goes over a
> single McBSP connection. The BT part handles the audio routing, which
> is completely external to the radio driver and this codec. And the user
> of the codec is in principle responsible for keeping the codec mode in
> sync with the route setting. And the soc_card driver needs to know the
> setting also to do its thing.

Which is...

You've still not provided any information about what use this will be
put to.
