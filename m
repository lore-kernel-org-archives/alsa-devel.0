From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Fix powerup/down of micbias
Date: Wed, 10 Jan 2018 10:41:33 -0200
Message-ID: <CAOMZO5AOxE4sJKcQQgQK1q1WnM4ZY26-Mtvm1XXd205qkFLPMg@mail.gmail.com>
References: <DD64F087E8F0B540A1C9216D6716FFBDF99455C9@defrsexc01.swissphone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FE61266DEC
 for <alsa-devel@alsa-project.org>; Wed, 10 Jan 2018 13:41:35 +0100 (CET)
Received: by mail-oi0-f67.google.com with SMTP id u83so4285575oie.7
 for <alsa-devel@alsa-project.org>; Wed, 10 Jan 2018 04:41:35 -0800 (PST)
In-Reply-To: <DD64F087E8F0B540A1C9216D6716FFBDF99455C9@defrsexc01.swissphone.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Fischer, Christian" <fischerc@swissphone.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Christian,

On Wed, Jan 10, 2018 at 8:07 AM, Fischer, Christian
<fischerc@swissphone.de> wrote:
> The bias-bias-voltage should powered up/down automatically.
> Added missing DAPM_PRE and DAPM_POST widgets to fire up the mic_bias_event function.

Thanks for submitting the patch.

You missed your Signed-off-by tag.

Please resend it.

Thanks
