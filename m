From: Fabio Estevam <festevam@gmail.com>
Subject: Re: ASoC: Failed to create component debugfs directory
Date: Wed, 21 Feb 2018 10:47:45 -0300
Message-ID: <CAOMZO5B_H0EN7c8+dCwuXvP3_KOoLz=94KQO9oZOM9PoeMX-1A@mail.gmail.com>
References: <CAOMZO5D071pPr4fL7eLwWgX6h8Mppwic2u4mUCGzUZiss-+3MQ@mail.gmail.com>
 <CAOMZO5C3joR2QS+yFDmQUs1Q69PfuVw8tBMNd+F+cjDnUMEPSQ@mail.gmail.com>
 <5b591fd8-d4d5-27bb-0850-a376da20d7f3@metafoo.de>
 <CAOMZO5Ai-EtFo--OYLKhsB+63u6D+Vyjx_hKVeG3EGXbHkY5jw@mail.gmail.com>
 <99ce1244-6646-6292-2c50-151819b01cfa@metafoo.de>
 <CAOMZO5CA99p+2DYrbWQnLzh5Lj8syX4j18V8R8WPV2KDZz-DVQ@mail.gmail.com>
 <20180221130241.GI8334@sirena.org.uk>
 <CAOMZO5DZ0W5q6OAvrRWv+8GNbWn5ttLk3q035H=4fLton-1mgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f172.google.com (mail-ot0-f172.google.com
 [74.125.82.172])
 by alsa0.perex.cz (Postfix) with ESMTP id ADD7C2675C7
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 14:47:46 +0100 (CET)
Received: by mail-ot0-f172.google.com with SMTP id a7so1418754otk.9
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 05:47:46 -0800 (PST)
In-Reply-To: <CAOMZO5DZ0W5q6OAvrRWv+8GNbWn5ttLk3q035H=4fLton-1mgg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 21, 2018 at 10:43 AM, Fabio Estevam <festevam@gmail.com> wrote:

> Had to change it to pcm->component.name_prefix = "dma"; but still see
> the warnings.

Looks like this can fix it:

--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -442,6 +442,7 @@ int snd_dmaengine_pcm_register(struct device *dev,
        if (!pcm)
                return -ENOMEM;

+       pcm->component.debugfs_prefix = "dma";
        pcm->config = config;
        pcm->flags = flags;

Would you like me to submit it?

Thanks
