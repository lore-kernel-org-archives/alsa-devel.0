From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l52: fix default value for
	MASTERA_VOL.
Date: Thu, 23 May 2013 15:40:24 +0000
Message-ID: <C335A5BC-FE49-4163-AACA-E6ADD68036D4@cirrus.com>
References: <1369320782-2371-1-git-send-email-nschichan@freebox.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DCA5262635
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2013 17:40:37 +0200 (CEST)
In-Reply-To: <1369320782-2371-1-git-send-email-nschichan@freebox.fr>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolas Schichan <nschichan@freebox.fr>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Georgi Vlaev <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org



On May 23, 2013, at 4:54, "Nicolas Schichan" <nschichan@freebox.fr> wrote:

> The default register value for MASTERA_VOL is 0x00, the same as
> MASTERB_VOL.
> 
> Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
> ---
> sound/soc/codecs/cs42l52.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
> index 8465c1fa..030f53c 100644
> --- a/sound/soc/codecs/cs42l52.c
> +++ b/sound/soc/codecs/cs42l52.c
> @@ -86,7 +86,7 @@ static const struct reg_default cs42l52_reg_defaults[] = {
>    { CS42L52_BEEP_VOL, 0x00 },    /* r1D Beep Volume off Time */
>    { CS42L52_BEEP_TONE_CTL, 0x00 },    /* r1E Beep Tone Cfg. */
>    { CS42L52_TONE_CTL, 0x00 },    /* r1F Tone Ctl */
> -    { CS42L52_MASTERA_VOL, 0x88 },    /* r20 Master A Volume */
> +    { CS42L52_MASTERA_VOL, 0x00 },    /* r20 Master A Volume */
>    { CS42L52_MASTERB_VOL, 0x00 },    /* r21 Master B Volume */
>    { CS42L52_HPA_VOL, 0x00 },    /* r22 Headphone A Volume */
>    { CS42L52_HPB_VOL, 0x00 },    /* r23 Headphone B Volume */
> -- 
> 1.7.10.4
> 
> 
Acked-by: Brian Austin <brian.austin@cirrus.com>
