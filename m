From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: tlv320dac33: Fix compillation
 error
Date: Thu, 09 Dec 2010 09:45:17 +0000
Message-ID: <1291887917.3271.14.camel@odin>
References: <1291813977-17944-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1983010383B
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 10:45:21 +0100 (CET)
Received: by wyi11 with SMTP id 11so2056972wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 09 Dec 2010 01:45:20 -0800 (PST)
In-Reply-To: <1291813977-17944-1-git-send-email-peter.ujfalusi@nokia.com>
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

On Wed, 2010-12-08 at 15:12 +0200, Peter Ujfalusi wrote:
> Fix the compilation error introduced by patch:
> ASoC: tlv320dac33: Avoid multiple soft power up
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
>  sound/soc/codecs/tlv320dac33.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
> index a0ba5d1..d13fda0 100644
> --- a/sound/soc/codecs/tlv320dac33.c
> +++ b/sound/soc/codecs/tlv320dac33.c
> @@ -638,6 +638,7 @@ static int dac33_add_widgets(struct snd_soc_codec *codec)
>  static int dac33_set_bias_level(struct snd_soc_codec *codec,
>  				enum snd_soc_bias_level level)
>  {
> +	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
>  	int ret;
>  
>  	switch (level) {

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
