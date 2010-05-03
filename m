From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCHv2 0/4] ASoC: tlv320dac33: Support for
	turning off codec
Date: Mon, 03 May 2010 13:19:32 +0100
Message-ID: <1272889172.3000.18.camel@odin>
References: <1272628776-23185-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id E35F724580
	for <alsa-devel@alsa-project.org>;
	Mon,  3 May 2010 14:19:38 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 21so221099wya.38
	for <alsa-devel@alsa-project.org>; Mon, 03 May 2010 05:19:38 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-04-30 at 14:59 +0300, Peter Ujfalusi wrote:
> Hello,
> 
> Changes since v1:
> - patch 1: Removed extra register writes
> - patch 4:
>  - Let core to bring the codec to BIAS_OFF (set idle_bias_off)
>  - dac33_set_bias_level only takes care of power and minimum initialization
>  - PRE_DAPM widget event is replacing the dac33_pcm_pointer call to take
>    care of the initialization needed before _every_ playback.
> 
> There are few scenarios, which has to be taken care::
> 1. Analog bypass caused BIAS_OFF -> BIAS_ON
>    We need to power on the codec, and do the chip init, but we does not
>    need to execute the playback related configuration
> 2. Playback caused  BIAS_OFF -> BIAS_ON
>    We need to power on the codec, and do the chip init, and also we need
>    to execute the playback related configuration.
> 3. Playback start, while Analog bypass is on (BIAS_ON -> BIAS_ON)
>    We need to execute the playback related configuration. The codec is
>    already on.
> 4. Analog bypass enable, while playback (BIAS_ON -> BIAS_ON)
>    Nothing need to be done.
> 5. Playback start withing soc power down timeout (BIAS_ON -> BIAS_ON)
>    We need to execute the playback related configuration. The codec is
>    still on.
> 
> Since the power up, and the codec init is optimized, the added overhead
> in stream start is minimal.
> 
> Withing this patch, the hard_power function is now only doing what it
> supposed to: only handle the powers, and GPIO reset line.
> The codec initialization and state restore has been moved out.
> 

Applied.

Thanks !

Liam
