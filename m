From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: pcm: Require both CODEC and CPU
 support when declaring stream caps
Date: Sun, 2 Jun 2013 11:45:46 -0300
Message-ID: <CAOMZO5Bwo4hFG4vkN+Xnnm4FFUO1Enbs+83Yx1C50KWW0mmY-Q@mail.gmail.com>
References: <1370124976-25047-1-git-send-email-broonie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f47.google.com (mail-vb0-f47.google.com
 [209.85.212.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BC682610A8
 for <alsa-devel@alsa-project.org>; Sun,  2 Jun 2013 16:45:47 +0200 (CEST)
Received: by mail-vb0-f47.google.com with SMTP id x13so2083105vbb.34
 for <alsa-devel@alsa-project.org>; Sun, 02 Jun 2013 07:45:46 -0700 (PDT)
In-Reply-To: <1370124976-25047-1-git-send-email-broonie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@linaro.org>
Cc: Marek Vasut <marex@denx.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Sat, Jun 1, 2013 at 7:16 PM, Mark Brown <broonie@linaro.org> wrote:
> When declaring playback and capture capabilities check for both CODEC
> side and CPU side support rather than only checking for CODEC side
> support.  While it is unusual some CPUs do have unidirectional DAIs.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Now I got it working and your patch does fix the "aplay -l/arecord -l"
issue that I reported earlier:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

I also need to patch sound/soc/mxs/mxs-saif.c and will send a separate
patch for this.

Thanks a lot, really appreaciated!

Fabio Estevam
