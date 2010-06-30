From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [RFC 10/15] ASoC: multi-component - RMI Alchemy
 AU1x Platform
Date: Wed, 30 Jun 2010 07:40:19 +0100
Message-ID: <1277880019.12813.26.camel@vega>
References: <1277639534-5104-1-git-send-email-lrg@slimlogic.co.uk>
	<1277639534-5104-11-git-send-email-lrg@slimlogic.co.uk>
	<20100629123015.GA20441@wormhole>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 414831037F9
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Jun 2010 08:40:37 +0200 (CEST)
Received: by wyf23 with SMTP id 23so58045wyf.38
	for <alsa-devel@alsa-project.org>; Tue, 29 Jun 2010 23:40:33 -0700 (PDT)
In-Reply-To: <20100629123015.GA20441@wormhole>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

I'm on the road atm so will answer this one since it's quick (I'll
answer the others later in the week).

On Tue, 2010-06-29 at 14:30 +0200, Manuel Lauss wrote:
> Hi Liam,
> 
> On Sun, Jun 27, 2010 at 12:52:09PM +0100, Liam Girdwood wrote:
> > Update the RMI Alchemy platform and machines to new multi-component model.
> > 
> > This patch changes the machine drivers for multi-component as follows :-
> > 
> >  o Removed socdev
> >  o Each DAI link entry now contains platform and codec fields.
> >  o DAI link init() now passed snd_soc_pcm_runtime instread of snd_soc_codec.
> > 
> > This patch also changes the DAI and platform DAM drivers as follows :-
> > 
> >  o Each platform DAI and platform DMA driver is a kernel device and can
> >    have platform data.
> >  o DAI and Platform DMA drivers have private data accessors.
> 
> Forgive the probably stupid question, but does that mean I can have
> 2 or more independent ASoC devices?  (A board I have has independent
> AC97 and I2S systems).

Yes, nothing will stop you having 2 or more independent devices.

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
