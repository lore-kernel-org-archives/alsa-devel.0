From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/5] ASoC: tlv320dac33: Fix for early
 interrupt in FIFO Mode1
Date: Thu, 22 Apr 2010 17:26:51 +0100
Message-ID: <1271953611.3228.435.camel@odin>
References: <1271944670-14588-1-git-send-email-peter.ujfalusi@nokia.com>
	<1271944670-14588-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 575952454F
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 18:30:10 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id e21so3545619fga.2
	for <alsa-devel@alsa-project.org>; Thu, 22 Apr 2010 09:30:09 -0700 (PDT)
In-Reply-To: <1271944670-14588-2-git-send-email-peter.ujfalusi@nokia.com>
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

On Thu, 2010-04-22 at 16:57 +0300, Peter Ujfalusi wrote:
> Alarm threshold interrupt is triggered right after the
> playback start.
> This interrupt is recieved during the first burst period,
> and caused the state machine to write additional nSample
> command, which has to be avoided.
> To fix this issue move the DAC33 interrupt unmasking
> after we configured the PREFILL register with a small
> delay.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
>  sound/soc/codecs/tlv320dac33.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
> index 824bb35..8a7265f 100644
> --- a/sound/soc/codecs/tlv320dac33.c
> +++ b/sound/soc/codecs/tlv320dac33.c
> @@ -557,9 +557,12 @@ static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
>  	switch (dac33->fifo_mode) {
>  	case DAC33_FIFO_MODE1:
>  		dac33_write16(codec, DAC33_NSAMPLE_MSB,
> -				DAC33_THRREG(dac33->nsample));
> +			DAC33_THRREG(dac33->nsample + dac33->alarm_threshold));
>  		dac33_write16(codec, DAC33_PREFILL_MSB,
>  				DAC33_THRREG(dac33->alarm_threshold));
> +		/* Enable Alarm Threshold IRQ */
> +		msleep(2);

Does this sleep depend on rate/frame_size in any way ?

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
