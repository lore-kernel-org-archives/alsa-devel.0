From: Fabio Estevam <festevam@gmail.com>
Subject: Re: ASoC: Failed to create component debugfs directory
Date: Tue, 20 Feb 2018 13:40:53 -0300
Message-ID: <CAOMZO5DVkrj3t63f5mkdotRCGsSoADdEH_pdmACwx_1K-vYPoQ@mail.gmail.com>
References: <CAOMZO5D071pPr4fL7eLwWgX6h8Mppwic2u4mUCGzUZiss-+3MQ@mail.gmail.com>
 <CAOMZO5C3joR2QS+yFDmQUs1Q69PfuVw8tBMNd+F+cjDnUMEPSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f173.google.com (mail-ot0-f173.google.com
 [74.125.82.173])
 by alsa0.perex.cz (Postfix) with ESMTP id BE622266F0D
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 17:40:58 +0100 (CET)
Received: by mail-ot0-f173.google.com with SMTP id 95so10446726ote.5
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 08:40:58 -0800 (PST)
In-Reply-To: <CAOMZO5C3joR2QS+yFDmQUs1Q69PfuVw8tBMNd+F+cjDnUMEPSQ@mail.gmail.com>
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

On Tue, Feb 20, 2018 at 11:18 AM, Fabio Estevam <festevam@gmail.com> wrote:

> Any ideas why this second debugfs registration is being attempted?

The change below avoids the double component debugfs registration:

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

Not sure what a proper fix would be.
