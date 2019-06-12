From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] ASoC: tas571x: Fix -Wunused-const-variable
Date: Wed, 12 Jun 2019 16:55:18 -0700
Message-ID: <CAKwvOdkPQyK3oJk0qPQyfwVcvtdBSF6oN83VOW8kcy3zWyBkgA@mail.gmail.com>
References: <20190612232502.256846-1-nhuck@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C4BD9F80791
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 01:55:32 +0200 (CEST)
Received: by mail-pg1-x542.google.com with SMTP id k187so9299460pga.0
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 16:55:32 -0700 (PDT)
In-Reply-To: <20190612232502.256846-1-nhuck@google.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Nathan Huckleberry <nhuck@google.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, clang-built-linux <clang-built-linux@googlegroups.com>, cernekee@chromium.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 12, 2019 at 4:25 PM 'Nathan Huckleberry' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> Since tac5711_controls is identical to tas5721_controls we can just swap
> them

380 static const struct snd_kcontrol_new tas5711_controls[] = {
381   SOC_SINGLE_TLV("Master Volume",
382            TAS571X_MVOL_REG,
383            0, 0xff, 1, tas5711_volume_tlv),
384   SOC_DOUBLE_R_TLV("Speaker Volume",
385        TAS571X_CH1_VOL_REG,
386        TAS571X_CH2_VOL_REG,
387        0, 0xff, 1, tas5711_volume_tlv),
388   SOC_DOUBLE("Speaker Switch",
389        TAS571X_SOFT_MUTE_REG,
390        TAS571X_SOFT_MUTE_CH1_SHIFT, TAS571X_SOFT_MUTE_CH2_SHIFT,
391        1, 1),
392 };

vs

666 static const struct snd_kcontrol_new tas5721_controls[] = {
667   SOC_SINGLE_TLV("Master Volume",
668            TAS571X_MVOL_REG,
669            0, 0xff, 1, tas5711_volume_tlv),
670   SOC_DOUBLE_R_TLV("Speaker Volume",
671        TAS571X_CH1_VOL_REG,
672        TAS571X_CH2_VOL_REG,
673        0, 0xff, 1, tas5711_volume_tlv),
674   SOC_DOUBLE("Speaker Switch",
675        TAS571X_SOFT_MUTE_REG,
676        TAS571X_SOFT_MUTE_CH1_SHIFT, TAS571X_SOFT_MUTE_CH2_SHIFT,
677        1, 1),
678 };

Thanks for the patch!

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Alternatively, we could make 2 variables w/ the same variable, 1
variable.  It seems there's at least 4 `_control` variables:
tas5711_controls
tas5707_controls
tas5717_controls
tas5721_controls

so maybe `tas57X1_controls` would be appropriate?  Not sure if the
maintainers have a preference here?

(Looks like L669 also refers to tas5711, but it seems there no tas5721
equivalent for `_volume_tlv`.)
-- 
Thanks,
~Nick Desaulniers
