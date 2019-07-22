From: Curtis Malainey <cujomalainey@google.com>
Subject: Re: Applied "ASoC: rt5677: remove superfluous set" to
	the asoc tree
Date: Mon, 22 Jul 2019 07:16:28 -0600
Message-ID: <CAOReqxjuZW8SP2JaReQNVej5=8qx7J_JfHPUAE9UhhME6_yVrg@mail.gmail.com>
References: <20190711002838.35363-1-cujomalainey@chromium.org>
 <20190722122208.F2A0427429D9@ypsilon.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D537F800E8
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 15:16:40 +0200 (CEST)
Received: by mail-lf1-x144.google.com with SMTP id b29so19365661lfq.1
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 06:16:40 -0700 (PDT)
In-Reply-To: <20190722122208.F2A0427429D9@ypsilon.sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Curtis Malainey <cujomalainey@chromium.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Can you please remove this patch? I made an error in my testing and
the patch should not be applied.

Curtis

On Mon, Jul 22, 2019 at 6:22 AM Mark Brown <broonie@kernel.org> wrote:
>
> The patch
>
>    ASoC: rt5677: remove superfluous set
>
> has been applied to the asoc tree at
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
>
> From 4dc057a786dc23fd1ed70e6bcab691c0f26daa1e Mon Sep 17 00:00:00 2001
> From: Curtis Malainey <cujomalainey@chromium.org>
> Date: Wed, 10 Jul 2019 17:28:38 -0700
> Subject: [PATCH] ASoC: rt5677: remove superfluous set
>
> We define this variable with the same value, no need to set it twice
>
> Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
> Link: https://lore.kernel.org/r/20190711002838.35363-1-cujomalainey@chromium.org
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  sound/soc/codecs/rt5677.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
> index c779dc3474f9..deaed5132dc9 100644
> --- a/sound/soc/codecs/rt5677.c
> +++ b/sound/soc/codecs/rt5677.c
> @@ -5098,7 +5098,6 @@ static irqreturn_t rt5677_irq(int unused, void *data)
>                         goto exit;
>                 }
>
> -               irq_fired = false;
>                 for (i = 0; i < RT5677_IRQ_NUM; i++) {
>                         if (reg_irq & rt5677_irq_descs[i].status_mask) {
>                                 irq_fired = true;
> --
> 2.20.1
>
