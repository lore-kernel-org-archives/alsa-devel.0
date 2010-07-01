From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [RFC 12/15] ASoC: multi-component - Cirrus Logic
 ep93xx Platform
Date: Thu, 01 Jul 2010 07:52:45 +0100
Message-ID: <1277967165.12813.90.camel@vega>
References: <1277639534-5104-1-git-send-email-lrg@slimlogic.co.uk>
	<1277639534-5104-13-git-send-email-lrg@slimlogic.co.uk>
	<4C27C4CF.3010801@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2220E10382A
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Jul 2010 08:52:51 +0200 (CEST)
Received: by fxm15 with SMTP id 15so944199fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 30 Jun 2010 23:52:51 -0700 (PDT)
In-Reply-To: <4C27C4CF.3010801@bluewatersys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-06-28 at 09:38 +1200, Ryan Mallon wrote:
> On 06/27/2010 11:52 PM, Liam Girdwood wrote:
> > Update the Cirrus Logic EP93xx platform and machines to new multi-component model.
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
> > 
> > Other notable changes required for multi-component support:-
> > 
> >  o Add platform devices for I2S and PCM.
> > 
> > Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
> > Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> 
> Hi Liam,
> 
> Where does this patch apply to? The codec-id fix, along with the patch I
> just posted for fixing the tlv320aic23 codec, gets the ep93xx/Snapper
> CL15 audio working under on your multi-component branch, so this patch
> should be fine. Would like to test though.

They should apply to 2.6.35-rc1 atm.

Thanks

Liam
