From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCHv2] ASoC: tlv320aic3x: Add platform data and
 reset gpio handling
Date: Thu, 6 May 2010 13:18:35 +0300
Message-ID: <20100506131835.a9a066eb.jhnikula@gmail.com>
References: <1273053723-6304-1-git-send-email-jhnikula@gmail.com>
	<201005061109.34734.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f219.google.com (mail-ew0-f219.google.com
	[209.85.219.219])
	by alsa0.perex.cz (Postfix) with ESMTP id DBC9C2466A
	for <alsa-devel@alsa-project.org>;
	Thu,  6 May 2010 12:17:19 +0200 (CEST)
Received: by ewy19 with SMTP id 19so1528775ewy.22
	for <alsa-devel@alsa-project.org>; Thu, 06 May 2010 03:17:19 -0700 (PDT)
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
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 6 May 2010 11:09:34 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

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
> 
Yeah, Peter is right. Even this reset 'protocol' is business as usual,
reset is released after voltages are stabilized, this is kind of fix to
patch adding regulator support so the commit message is nice be there.


-- 
Jarkko
