From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 0/4] ASoC: tlv320dac33: Support for
	turning off codec
Date: Fri, 30 Apr 2010 13:50:13 +0100
Message-ID: <20100430125013.GG28241@rakim.wolfsonmicro.main>
References: <1272628776-23185-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ECA961037E3
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 14:50:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1272628776-23185-1-git-send-email-peter.ujfalusi@nokia.com>
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

On Fri, Apr 30, 2010 at 02:59:32PM +0300, Peter Ujfalusi wrote:

> Changes since v1:
> - patch 1: Removed extra register writes
> - patch 4:
>  - Let core to bring the codec to BIAS_OFF (set idle_bias_off)
>  - dac33_set_bias_level only takes care of power and minimum initialization
>  - PRE_DAPM widget event is replacing the dac33_pcm_pointer call to take
>    care of the initialization needed before _every_ playback.

These all look fine to me

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
