From: Fabio Estevam <festevam@gmail.com>
Subject: Re: ASoC: Failed to create component debugfs directory
Date: Tue, 20 Feb 2018 16:37:33 -0300
Message-ID: <CAOMZO5CA99p+2DYrbWQnLzh5Lj8syX4j18V8R8WPV2KDZz-DVQ@mail.gmail.com>
References: <CAOMZO5D071pPr4fL7eLwWgX6h8Mppwic2u4mUCGzUZiss-+3MQ@mail.gmail.com>
 <CAOMZO5C3joR2QS+yFDmQUs1Q69PfuVw8tBMNd+F+cjDnUMEPSQ@mail.gmail.com>
 <5b591fd8-d4d5-27bb-0850-a376da20d7f3@metafoo.de>
 <CAOMZO5Ai-EtFo--OYLKhsB+63u6D+Vyjx_hKVeG3EGXbHkY5jw@mail.gmail.com>
 <99ce1244-6646-6292-2c50-151819b01cfa@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 by alsa0.perex.cz (Postfix) with ESMTP id D1E11266F0D
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 20:37:35 +0100 (CET)
Received: by mail-oi0-f45.google.com with SMTP id c12so3520427oic.7
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 11:37:35 -0800 (PST)
In-Reply-To: <99ce1244-6646-6292-2c50-151819b01cfa@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 20, 2018 at 4:30 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> Because on linux-next they are all components now, before one was a
> platform, the other a component. So they were created in different
> sub-directories. Now they are created in the same sub-directory.

Thanks for your clarification.

What is the best way to avoid the "Failed to create
component debugfs directory" warning?

--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -319,8 +319,6 @@ static void soc_init_component_debugfs(struct
snd_soc_component *component)
        }

        if (!component->debugfs_root) {
-               dev_warn(component->dev,
-                       "ASoC: Failed to create component debugfs directory\n");
                return;
        }


or

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3987673..270109c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -329,6 +329,8 @@ static void soc_init_component_debugfs(struct
snd_soc_component *component)

        if (component->init_debugfs)
                component->init_debugfs(component);
+
+       component->card->debugfs_card_root = NULL;
 }

 static void soc_cleanup_component_debugfs(struct snd_soc_component *component)

Thanks
