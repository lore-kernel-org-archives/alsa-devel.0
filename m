From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v2] ASoC: tlv320dac33: Power down digital
 parts, when not needed
Date: Fri, 10 Dec 2010 22:51:03 +0000
Message-ID: <1292021463.3422.19.camel@odin>
References: <1291980391-5202-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 0398824619
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 23:51:06 +0100 (CET)
Received: by wyi11 with SMTP id 11so4007248wyi.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 14:51:06 -0800 (PST)
In-Reply-To: <1291980391-5202-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-12-10 at 13:26 +0200, Peter Ujfalusi wrote:
> If the following scenario has been followed:
> 1. Enable analog bypass
> amixer sset 'Analog Left Bypass' on
> amixer sset 'Analog Right Bypass' on
> 
> 2. Start playback
> aplay -fdat -d3 /dev/zero
> 
> After the playback stopped (3 sec), and the soc timeout (5 sec),
> the digital parts of the codec will remain powered up.
> This means that the DAI clocks are continue to run, the
> oscillator remain operational, etc.
> 
> Use the SND_SOC_DAPM_POST_PMD widget to get notification
> about the stopped stream, and power down the digital
> part of the codec.
> If the analog bypass is enabled, than the codec will remain in
> BIAS_ON level, and things will work correctly.
> In case, if the bypass is disabled, than the codec will
> fall to BIAS_STANDBY than to BIAS_OFF level, as it used
> to.
> 
> The digital part of DAC33 is initialized at every stream start
> (DAPM_PRE:PRE_PMU event), so subsequent streams (within 5 sec)
> will have working DAI.
> When the codec is coming out from BIAS_OFF, the full power-up
> sequence followed by the same DAPM_PRE widget event will power up
> the digital part.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
