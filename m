From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCHv2] ASoC: tlv320aic3x: Add platform data and
 reset gpio handling
Date: Thu, 06 May 2010 09:17:55 +0100
Message-ID: <1273133875.2992.14.camel@odin>
References: <1273053723-6304-1-git-send-email-jhnikula@gmail.com>
	<201005061109.34734.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CF339245ED
	for <alsa-devel@alsa-project.org>;
	Thu,  6 May 2010 10:18:02 +0200 (CEST)
Received: by wwb24 with SMTP id 24so3460989wwb.38
	for <alsa-devel@alsa-project.org>; Thu, 06 May 2010 01:18:01 -0700 (PDT)
In-Reply-To: <201005061109.34734.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-05-06 at 11:09 +0300, Peter Ujfalusi wrote:
> On Wednesday 05 May 2010 13:02:03 ext Jarkko Nikula wrote:
> > Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> > 
> > ---
> > 
> > v2:
> > 
> > - Removed added regulator_bulk_disable brain fart from aic3x_i2c_probe
> > - Added comment to gpio_reset number in aic3x_pdata
> 
> Would have been nice to have a commit message for this just in case.
> Something like this would do:
> Handle the reset GPIO within the codec driver in order to follow the startup 
> protocol for the tlv320aic3x codecs.
> 
> Can you Liam add this message (if Jarkko agrees)?

I can add a message if required.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
