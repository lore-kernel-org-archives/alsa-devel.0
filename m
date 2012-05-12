From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: ASoC: wm9712: Microphone doesn't work: Mux
	handling broken?
Date: Sat, 12 May 2012 02:15:56 +0200
Message-ID: <20120512001556.GA26105@mars>
References: <20120426112726.GF3207@opensource.wolfsonmicro.com>
	<1335448142.20000.40.camel@mars>
	<20120426172010.GP3207@opensource.wolfsonmicro.com>
	<1335474693.3628.26.camel@lovely>
	<20120426213745.GA18260@opensource.wolfsonmicro.com>
	<1335513602.3504.4.camel@mars>
	<20120427134638.GI18260@opensource.wolfsonmicro.com>
	<20120504132845.GA24245@lovely.krouter>
	<20120507215506.GA5063@lovely.krouter>
	<20120508102947.GA8226@lovely.krouter>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BF996104791
	for <alsa-devel@alsa-project.org>;
	Sat, 12 May 2012 02:22:06 +0200 (CEST)
Received: by werh12 with SMTP id h12so1441495wer.38
	for <alsa-devel@alsa-project.org>; Fri, 11 May 2012 17:22:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120508102947.GA8226@lovely.krouter>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, "Hans J. Koch" <hjk@hansjkoch.de>, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lrg@ti.com>, linux-fbdev@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

> > Framebuffer driver mx3fb configured for a 800x600 display:
> > 
> >   soc-audio soc-audio: ASoC machine PhyCORE-ac97-audio should use snd_soc_register_card()
> >   asoc: platform pcm constructor failed
> >   asoc: can't create pcm HiFi :-12
> >   asoc: failed to instantiate card PhyCORE-ac97-audio: -12
> 
> When I do decrease from 800x600 to 800x594, wm9712 works. 
> 
> Any ideas?

It seems to be a dma problem and not directly related to wm9712.


But the not working microphone input still bothers me. I suppose this
is related to not beeing able to change some muxes:

$ amixer sset "Mic Select Source" 'Mic 2'
 Simple mixer control 'Mic Select Source',0
   Capabilities: enum
   Items: 'Mic 1' 'Differential' 'Mic 2' 'Stereo'
   Item0: 'Mic 1'

$ amixer sset "Differential Source" 'Line'
Simple mixer control 'Differential Source',0
  Capabilities: enum
  Items: 'Mic' 'Line'
  Item0: 'Mic'

They refuse to change their Item0 because they are defined as
SND_SOC_DAPM_MUX without a correlating path->name so that
snd_soc_dapm_mux_update_power() (in sound/soc/soc-dapmc) doesn't
change anything.

It works in 2.6.33, but current kernel has different mux handling and
it seems that no one since cared that much about microphone support.

Mark, can you confirm this, purpose a fix or even come up with
a patch?


Thanks,
 -- Christoph
