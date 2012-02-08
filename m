From: Liam Girdwood <lrg@ti.com>
Subject: Re: FW: [PATCH v3] ASoC: Add support for TI LM49453
	Audio codec
Date: Wed, 08 Feb 2012 09:18:43 +0000
Message-ID: <1328692723.3955.4.camel@odin>
References: <290463D19D2E064191F1F96ECA480A89434AC4A96E@EXMAIL02.scwf.nsc.com>
	<4F323BF5.4010309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E79D2459C
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 10:18:58 +0100 (CET)
Received: by mail-ww0-f45.google.com with SMTP id dt12so288121wgb.14
	for <alsa-devel@alsa-project.org>; Wed, 08 Feb 2012 01:18:45 -0800 (PST)
In-Reply-To: <4F323BF5.4010309@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: M R Swami Reddy <MR.Swami.Reddy@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-02-08 at 14:40 +0530, M R Swami Reddy wrote:
> > -----Original Message-----
> > From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com] 
> > Sent: Tuesday, February 07, 2012 10:34 PM
> > To: Reddy, MR Swami
> > Cc: Girdwood, Liam; alsa-devel@alsa-project.org
> > Subject: Re: [PATCH v3] ASoC: Add support for TI LM49453 Audio codec
> > 
> > On Mon, Feb 06, 2012 at 06:20:26AM -0800, Reddy, MR Swami wrote:
> > 
> >> Changes made in v3:
> >> o Updated the lm49453_set_dai_pll() as per review comments in v2 patch.
> >>     o Removed pll disable code in _set_dai_pll().
> > 
> > This doesn't really seem to address the issue at all - you still have the problems with the set_pll() function not doing anything it's supposed to do with the input and output frequencies, and now there's no way to disable the PLL.
> 
> OK. So its ideal to remove the _set_dai_pll(), as its not doing anything here.

The set_pll() function is meant to take the input and output frequencies
passed in as parameters and then use these to configure the PLL. If the
output frequency is 0 then you should switch OFF your PLL to conserve
power. 

Your function is just enabling the PLLs. Where do you configure the PLL
dividers (to divide the input frequency into the output frequency)?
Where do you switch the PLL off when it's not in use ?

Liam
