From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ASLA: emu10k1: constify snd_emux_operators
	structure
Date: Sun, 19 Feb 2017 21:35:27 +0900
Message-ID: <0987811c-2f10-62aa-883e-d8630a756be1@sakamocchi.jp>
References: <1487499690-32683-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id B1F1126583C
 for <alsa-devel@alsa-project.org>; Sun, 19 Feb 2017 13:35:31 +0100 (CET)
In-Reply-To: <1487499690-32683-1-git-send-email-bhumirks@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Feb 19 2016 19:21, Bhumika Goyal wrote:
> Declare snd_emux_operators structure as const as it is only copied into
> another structure. So, snd_emux_operators structures having this property
> can be made const.
>
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

...The 'ASLA' reminds me of the god in Indian myth[0]. When Buddhism 
disseminated to Japan via China, the god changed its name and became the 
god in Japanese Buddhism, too.

...I'm just a kidding. The title should be fixed with 'ALSA' ;)

> ---
>  sound/pci/emu10k1/emu10k1_callback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/pci/emu10k1/emu10k1_callback.c b/sound/pci/emu10k1/emu10k1_callback.c
> index d2c7ea3..aa2cc27 100644
> --- a/sound/pci/emu10k1/emu10k1_callback.c
> +++ b/sound/pci/emu10k1/emu10k1_callback.c
> @@ -61,7 +61,7 @@ static struct snd_emux_voice *get_voice(struct snd_emux *emux,
>  /*
>   * set up operators
>   */
> -static struct snd_emux_operators emu10k1_ops = {
> +static const struct snd_emux_operators emu10k1_ops = {
>  	.owner =	THIS_MODULE,
>  	.get_voice =	get_voice,
>  	.prepare =	start_voice,

[0] https://en.wikipedia.org/wiki/Asura
[1] https://en.wikipedia.org/wiki/Asura_(Buddhism)


Regards

Takashi Sakamoto
