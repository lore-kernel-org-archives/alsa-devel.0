From: Dhiv <s.divya@accelfrontline.com>
Subject: Re: Problem with MX27 ASoC audio
Date: Thu, 11 Jul 2013 12:24:44 +0000 (UTC)
Message-ID: <loom.20130711T142313-372@post.gmane.org>
References: <AANLkTikAybX=rP-DfWm5z8eVcC1EaujyEofsSoSJQ1M8@mail.gmail.com>
 <20100812125625.GA27749@pengutronix.de>
 <AANLkTinCWxRNBeXxTHRFBDgmgM6vZTqTKgoCubNYSV5u@mail.gmail.com>
 <20100812150145.GC11362@sirena.org.uk>
 <AANLkTiks+PBmKf6UrxwfLR2jGHO47-p4=o10Y-EE0kJw@mail.gmail.com>
 <4C690693.80706@eukrea.com>
 <AANLkTi=Jst17bqqH6H=jdPYZSGdz5G7yiOJQ=aRLm-3x@mail.gmail.com>
 <AANLkTimSMLLcOVzxocQV_nQ57wwxKLUGQUt7wn2wPa2p@mail.gmail.com>
 <20100818084137.GA26804@opensource.wolfsonmicro.com>
 <AANLkTinm96norAT4YQhTqg+eP80gwoeZf13V2QQa0_QV@mail.gmail.com>
 <20100818090223.GD26804@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 7ADBE2657E7
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 14:35:08 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1UxG5Q-0003V9-0f
 for alsa-devel@alsa-project.org; Thu, 11 Jul 2013 14:35:04 +0200
Received: from ms229.managedbiz.net ([ms229.managedbiz.net])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 14:35:04 +0200
Received: from s.divya by ms229.managedbiz.net with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 14:35:04 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Mark Brown <broonie <at> opensource.wolfsonmicro.com> writes:

> 
> On Wed, Aug 18, 2010 at 04:58:12PM +0800, Randolph Chung wrote:
> 
> > The codec (at least the variant of tlv320aic3x that I am using) can
> > have two pins in the hardware, but it's up to the board whether it's
> > hooked up that way. The codec driver as currently implemented assumes
> > the rates are symmetric, but it need not be.
> 
> In that case the driver should be setting the symmetric_rates flag
> anyway since it does have this constraint - if it implements support for
> asymmetric rates then the flag can be removed then.
> 
> > I see that there is a symmetric_rates flag for the dai_link too.
> 
> This is still a good idea if your board has a single LRCLK anyway in
> case someone does do asymmetric rates.
> 


Hi experts,
       We are also working on getting the audio work with the same codec
tlv320aic3x
(TLV320AIC3106) with AT91SAMAD34 board. Playback is working fine with the board.
But we have issues with capture. On "arecord" , nothing is being recorded in
the file.
Can you please tell us the TLV320AIC3X register settings that has to be to
make the capture work.

Thanks in adavnce,
Dhiv. 
