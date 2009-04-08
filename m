From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 0/6] ASoC: 4 channel support for twl4030
	and omap-mcbsp
Date: Wed, 8 Apr 2009 09:23:23 +0300
Message-ID: <20090408092323.bb7f7d7e.jarkko.nikula@nokia.com>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id F23151037F2
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Apr 2009 08:22:54 +0200 (CEST)
In-Reply-To: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 6 Apr 2009 14:19:26 +0200
"Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com> wrote:

> As an example, the board file for Beagle is modified to add support
> for stereo and TDM mode depending on the stream's channel count, so
> the stereo and the four channel mode are supported on Beagle.
> 
What's actually state of the TDM container format support in ASoC?
I see there is that set_tdm_slot callback in struct snd_soc_dai_ops
but only pxa-ssp.c is setting it currently.

Am I correct that DSP_x, I2S are not multichannel but should be
embedded into TDM if multichannel operation is wanted?

So should Peter's these two patches take this API into use?

"[PATCH 2/6] ASoC: OMAP mcbsp: Add 4 channel support"
"[PATCH 6/6] ASoC: Beagle: Add support for 4 channel mode"


Jarkko
