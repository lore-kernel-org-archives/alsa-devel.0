From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 0/8] ASoC: TWL4030: DAPM implementation for
	outputs (playback)
Date: Tue, 9 Dec 2008 09:47:01 +0000
Message-ID: <20081209094700.GA1630@sirena.org.uk>
References: <1228723748-22911-1-git-send-email-peter.ujfalusi@nokia.com>
	<20081208132040.GJ5159@sirena.org.uk>
	<200812090851.58378.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 27F2B1037FF
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 10:47:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200812090851.58378.peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 09, 2008 at 08:51:58AM +0200, Peter Ujfalusi wrote:

> As I see: when the twl4030_power_down is called from the 
> twl4030_set_bias_level (SND_SOC_BIAS_STANDBY, SND_SOC_BIAS_OFF) it sets the 
> codec to power-off state (CODEC_MODE:CODECPDZ = 0), which effectively turns 
> off the digital filter, analog section, so basically everything.
> When the CODECPDZ is 0, APGA, DAC, analog output settings have no effect (they 
> are powered off)

Right, that's what I thought.  You'll need to fix this in order to use
bypass paths since it will turn off the analogue.
