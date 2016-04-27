From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RESEND] ASoC: arizona: Do not create OUT4R
 widget for CS47L24/WM1831
Date: Wed, 27 Apr 2016 10:57:27 +0100
Message-ID: <1461751047.3071.2.camel@rf-debian.wolfsonmicro.main>
References: <1461749873-18373-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D68B265090
 for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2016 11:57:32 +0200 (CEST)
In-Reply-To: <1461749873-18373-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2016-04-27 at 10:37 +0100, Richard Fitzgerald wrote:
> The CS47L24 and WM1831 codecs only use the OUT4L widget so we can
> skip creation of the OUT4R widget.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/arizona.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
> index da61c62..0cd27e0 100644
> --- a/sound/soc/codecs/arizona.c
> +++ b/sound/soc/codecs/arizona.c
> @@ -223,6 +223,8 @@ int arizona_init_spk(struct snd_soc_codec *codec)
>  
>  	switch (arizona->type) {
>  	case WM8997:
> +	case CS47L24:
> +	case WM1831:
>  		break;
>  	default:
>  		ret = snd_soc_dapm_new_controls(dapm, &arizona_spkr, 1);

Sorry, ignore this.
I didn't get an ack email but I can see that it has already been
applied.
