From: "Xu, Hong" <Hong.Xu@atmel.com>
Subject: Re: [PATCH] ASoC: Add MICBIAS routing information for
	WM8904
Date: Mon, 19 Mar 2012 09:15:59 +0800
Message-ID: <4C79549CB6F772498162A641D92D532804D86730@penmb01.corp.atmel.com>
References: <1331888098-28717-1-git-send-email-hong.xu@atmel.com>
	<20120316190450.GE3158@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C2222433B
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 02:16:26 +0100 (CET)
Content-class: urn:content-classes:message
In-Reply-To: <20120316190450.GE3158@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Saturday, March 17, 2012 3:05 AM
> To: Xu, Hong
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [PATCH] ASoC: Add MICBIAS routing information for WM8904
> 
> On Fri, Mar 16, 2012 at 04:54:58PM +0800, Hong Xu wrote:
> 
> >  static const struct snd_soc_dapm_route adc_intercon[] = {
> > +	{ "MICBIAS", NULL, "IN1L" },
> > +	{ "MICBIAS", NULL, "IN1R" },
> > +
> > +	{ "Left Capture Mux", NULL, "MICBIAS" },
> > +	{ "Right Capture Mux", NULL, "MICBIAS" },
> > +	{ "Left Capture Inverting Mux", NULL, "MICBIAS" },
> > +	{ "Right Capture Inverting Mux", NULL, "MICBIAS" },
> > +
> 
> No, this is not something that the CODEC driver should do - the
machine
> driver should add connections for MICBIAS as this is something that's
> determined by the board design.  The board could for example use some
or
> all of the inputs as simple line inputs (no bias needed), or it could
> use an external MICBIAS for some reason.

OK, got it. Thanks.

BR,
Eric
