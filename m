From: <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: omap: rx51: Add stereo output
 support to audio jack
Date: Wed, 5 Jan 2011 18:12:21 +0000
Message-ID: <CF32F28EDF8D20468EEDCBE4975DA0272A7BD0@008-AM1MPN1-027.mgdnok.nokia.com>
References: <1294242360-1903-1-git-send-email-jhnikula@gmail.com>
	<20110105155509.GC746@opensource.wolfsonmicro.com>
	<20110105182924.cf90b12c.jhnikula@gmail.com>,
	<20110105163900.GD746@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (mgw-da01.ext.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 89E9C244E4
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 19:12:39 +0100 (CET)
In-Reply-To: <20110105163900.GD746@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, jhnikula@gmail.com
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

> ________________________________________
> From: ext Mark Brown [broonie@opensource.wolfsonmicro.com]
> Sent: Wednesday, January 05, 2011 18:39
> To: Jarkko Nikula
> Cc: alsa-devel@alsa-project.org; Liam Girdwood; Ujfalusi Peter (Nokia-MS/Tampere)
> Subject: Re: [PATCH] ASoC: omap: rx51: Add stereo output support to audio jack
> 
> As far as I remember from the previous discussion that had been that
> making it a CODEC driver would be the simplest thing.  Peter said in
> reply to my mail saying this:
> 
> | At least with my device I need to add some delay before enabling the amp, so
> | anyway I need to ahve the DAPM_HP in the machine driver.
> 
> but it'd seem that the amp driver could do this just as well, possibly
> based off platform data?

Yes that could be done with platform data (the additional delay after amp enable).
The only thing is that the tpa6130a2 driver must have DAPM_HP widget.
If we do that, than it would be also useful to have the SOC_DAPM_PIN_SWITCH() defined
in the tpa6130a2 driver, which might cause some problems with the rx51 machine driver,
as Jarkko handling the pins within that.
In rx51, we have several functions on the jack, so SOC_DAPM_PIN_SWITCH() will not going
to work there, but in my board, I'm using that.
While we are here, I'd also like to customize the DAPM_HP name as well, since I do not want
to have TPA6XXXX HP or something visible for user space.
Also:
Calling dapm_sync from machine driver might cause some locking issues:
http://mailman.alsa-project.org/pipermail/alsa-devel/2010-November/033362.html

I have another issue with my setup, which needs the exported enable/disable function, which
is the playback start, while the codec BIAS is on, since I need to do some tricks to remove 
some unwanted clicks.

We can add optional DAPM widget to the driver, as I already commented, I have no problems with
that, but it has to be really optional.

Peter
