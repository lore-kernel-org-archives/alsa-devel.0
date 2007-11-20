From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH] Fix inverted Bass, Treble,
 Mono volume and Phone volume WM9712 mixer controls.
Date: Tue, 20 Nov 2007 14:08:33 +0200
Message-ID: <4742CE41.3010107@compulab.co.il>
References: <1195550746-6892-1-git-send-email-broonie@opensource.wolfsonmicro.com>	<1195550746-6892-2-git-send-email-broonie@opensource.wolfsonmicro.com>	<1195550746-6892-3-git-send-email-broonie@opensource.wolfsonmicro.com>	<1195550746-6892-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-5-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sa5.bezeqint.net (sa5.bezeqint.net [192.115.104.19])
	by alsa0.perex.cz (Postfix) with ESMTP id EB690249F7
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 13:19:12 +0100 (CET)
In-Reply-To: <1195550746-6892-5-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, liam.girdwood@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Joe Sauer <jsauer@vernier.com>
List-Id: alsa-devel@alsa-project.org



Mark Brown wrote:
> From: Joe Sauer <jsauer@vernier.com>
> 
> Signed-off-by: Joe Sauer <jsauer@vernier.com>
> Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm9712.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
> index 986b5d5..111c266 100644
> --- a/sound/soc/codecs/wm9712.c
> +++ b/sound/soc/codecs/wm9712.c
> @@ -102,7 +102,7 @@ SOC_SINGLE("Speaker Playback ZC Switch", AC97_MASTER, 7, 1, 0),
>  SOC_SINGLE("Speaker Playback Invert Switch", AC97_MASTER, 6, 1, 0),
>  SOC_SINGLE("Headphone Playback ZC Switch", AC97_HEADPHONE, 7, 1, 0),
>  SOC_SINGLE("Mono Playback ZC Switch", AC97_MASTER_MONO, 7, 1, 0),
> -SOC_SINGLE("Mono Playback Volume", AC97_MASTER_MONO, 0, 31, 0),
> +SOC_SINGLE("Mono Playback Volume", AC97_MASTER_MONO, 0, 31, 1),

I think there also should be "Mono Playback Switch", otherwise there's no way
you can unmute mono playback:
+ SOC_SINGLE("Mono Playback Switch", AC97_MASTER_MONO, 15, 1, 1),


>  SOC_SINGLE("ALC Target Volume", AC97_CODEC_CLASS_REV, 12, 15, 0),
>  SOC_SINGLE("ALC Hold Time", AC97_CODEC_CLASS_REV, 8, 15, 0),
> @@ -131,7 +131,7 @@ SOC_SINGLE("Aux Playback Headphone Volume", AC97_CD, 12, 7, 1),
>  SOC_SINGLE("Aux Playback Speaker Volume", AC97_CD, 8, 7, 1),
>  SOC_SINGLE("Aux Playback Phone Volume", AC97_CD, 4, 7, 1),
>  
> -SOC_SINGLE("Phone Volume", AC97_PHONE, 0, 15, 0),
> +SOC_SINGLE("Phone Volume", AC97_PHONE, 0, 15, 1),
>  SOC_DOUBLE("Line Capture Volume", AC97_LINE, 8, 0, 31, 1),
>  
>  SOC_SINGLE("Capture 20dB Boost Switch", AC97_REC_SEL, 14, 1, 0),
> @@ -145,8 +145,8 @@ SOC_ENUM("Bass Control", wm9712_enum[5]),
>  SOC_SINGLE("Bass Cut-off Switch", AC97_MASTER_TONE, 12, 1, 1),
>  SOC_SINGLE("Tone Cut-off Switch", AC97_MASTER_TONE, 4, 1, 1),
>  SOC_SINGLE("Playback Attenuate (-6dB) Switch", AC97_MASTER_TONE, 6, 1, 0),
> -SOC_SINGLE("Bass Volume", AC97_MASTER_TONE, 8, 15, 0),
> -SOC_SINGLE("Treble Volume", AC97_MASTER_TONE, 0, 15, 0),
> +SOC_SINGLE("Bass Volume", AC97_MASTER_TONE, 8, 15, 1),
> +SOC_SINGLE("Treble Volume", AC97_MASTER_TONE, 0, 15, 1),
>  
>  SOC_SINGLE("Capture ADC Switch", AC97_REC_GAIN, 15, 1, 1),
>  SOC_ENUM("Capture Volume Steps", wm9712_enum[6]),

-- 
Sincerely yours,
Mike.
