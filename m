From: Vishal Thanki <vishalthanki@gmail.com>
Subject: [PATCH] ASoC: simple-card: Add a NULL pointer check in
	asoc_simple_card_dai_link_of
Date: Tue, 3 Mar 2015 18:44:30 +0530
Message-ID: <CAC3a_SBrJxS6x+qCwi0p5DcbEbVFX3AOP=-NxWbugY6bEvirLg@mail.gmail.com>
Reply-To: vishal.thanki@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com
 [209.85.213.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EBC726149D
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2015 14:14:51 +0100 (CET)
Received: by igbhl2 with SMTP id hl2so27120195igb.3
 for <alsa-devel@alsa-project.org>; Tue, 03 Mar 2015 05:14:50 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Make sure devm_kzalloc() succeeds.

Signed-off-by: Vishal Thanki <vishalthanki@gmail.com>

diff --git a/sound/soc/generic/simple-card.c
b/sound/soc/generic/simple-card.c
index f7c6734..fb550b5 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -372,6 +372,11 @@ static int asoc_simple_card_dai_link_of(struct
device_node *node,
     strlen(dai_link->cpu_dai_name)   +
     strlen(dai_link->codec_dai_name) + 2,
     GFP_KERNEL);
+ if (!name) {
+ ret = -ENOMEM;
+ goto dai_link_of_err;
+ }
+
  sprintf(name, "%s-%s", dai_link->cpu_dai_name,
  dai_link->codec_dai_name);
  dai_link->name = dai_link->stream_name = name;
--
