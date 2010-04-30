From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: tlv320dac33: Support for turning
 off the codec in BIAS_STANDBY
Date: Fri, 30 Apr 2010 09:41:00 +0100
Message-ID: <20100430084100.GB28241@rakim.wolfsonmicro.main>
References: <1272612715-13387-1-git-send-email-peter.ujfalusi@nokia.com>
	<1272612715-13387-5-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3E51C1037EE
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 10:41:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1272612715-13387-5-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 30, 2010 at 10:31:55AM +0300, Peter Ujfalusi wrote:
> When the codec is in STANDBY we can actually turn it off.
> When the codec is off, than the associated regulator can be also turned
> off (if the number of users on the regulator is 0).

You can just set idle_bias_off in the CODEC and then the core will push
you down into _BIAS_OFF.  

> There are few scenarios, which has to be taken care::
> 1. Analog bypass caused BIAS_STANDBY -> BIAS_ON
>    We need to power on the codec, and do the chip init, but we does not
>    need to execute the playback related configuration

Moving the playback related configuration into events on the DAC widgets
(or probably a supply connected to the DAC widgets) seems like a good
move for a lot of these scenarios?  The core will then take care of
ensuring that the startup sequence for the playback is called for you
and the states can do what they're supposed to more directly.
