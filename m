From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 1/2] ASoC: OMAP: Use single-phase for DSP
	mode
Date: Thu, 16 Apr 2009 12:07:50 +0300
Message-ID: <20090416120750.f3cf99ed.jarkko.nikula@nokia.com>
References: <1239799136-28729-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239799136-28729-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 35B421038AA
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 11:07:11 +0200 (CEST)
In-Reply-To: <1239799136-28729-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 15 Apr 2009 14:38:55 +0200
"Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com> wrote:

> Use single-phase mode for the DSP mode and keep the dual phase
> mode for the I2S mode.
> 
> The mono (1 channel) mode already used single phase mode,
> now it is more cleaner. There is no need to configure the
> second phase, when the single phase is used.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
I did a little bit of hacking and testing with this to see are can this
even be a fix on top of my DSP_B fix for 2.6.30 but looks like there is
no currently any difference or potential bug fix are we using single
or dual phase mode for stereo samples. For testing I hacked to use word
length of 20-bits (only the interface, not samples) and both phase modes
produced the same bit stream.

But as this is more generic case and only option for multichannel
configuration let's start to use it and let only I2S to continue use the
dual-phase mode.

Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>
