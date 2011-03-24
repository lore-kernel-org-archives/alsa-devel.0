From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320dac33: Move codec power up to
	DAPM
Date: Thu, 24 Mar 2011 10:15:58 +0000
Message-ID: <20110324101557.GC28306@opensource.wolfsonmicro.com>
References: <1300950709-13695-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 52775103A3A
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2011 11:15:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1300950709-13695-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 24, 2011 at 09:11:49AM +0200, Peter Ujfalusi wrote:
> Move the codec power on (in reg 0x01, bit 4) from
> set_bias_level:SND_SOC_BIAS_ON to a DAPM supply.
> In this way we can be sure, that all the things within
> the codec is powered before the external amp is
> going to be enabled.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
