From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 021/102] ASoC: ssm2602: Omit superfluous
 elements in input select array
Date: Tue, 18 Feb 2014 12:59:31 +0100
Message-ID: <53034B23.703@metafoo.de>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
 <1392723422-12689-6-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-025.synserver.de (smtp-out-136.synserver.de
 [212.40.185.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 036EE26587B
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:59:23 +0100 (CET)
In-Reply-To: <1392723422-12689-6-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 02/18/2014 12:36 PM, Takashi Iwai wrote:
> The array contains too many elements although it should have only
> two.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/soc/codecs/ssm2602.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
> index f444d585b916..e32b82ff6304 100644
> --- a/sound/soc/codecs/ssm2602.c
> +++ b/sound/soc/codecs/ssm2602.c
> @@ -75,15 +75,16 @@ static const u16 ssm2602_reg[SSM2602_CACHEREGNUM] = {
>
>   /*Appending several "None"s just for OSS mixer use*/
>   static const char *ssm2602_input_select[] = {
> -	"Line", "Mic", "None", "None", "None",
> -	"None", "None", "None",
> +	"Line", "Mic",
>   };

I never dared to change it because of the comment above the array. I must 
admit that I have no idea though why those extra None entries are necessary 
for OSS.
