From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v2 22/22] ASoC: core: Probe components on demand
Date: Tue, 28 Jul 2015 15:19:53 +0200
Message-ID: <1438089593-7696-23-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
 [209.85.212.174])
 by alsa0.perex.cz (Postfix) with ESMTP id A762026526D
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 15:21:21 +0200 (CEST)
Received: by wicmv11 with SMTP id mv11so179342186wic.0
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 06:21:21 -0700 (PDT)
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Takashi Iwai <tiwai@suse.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

When looking up a component through its firmware node, probe it if it
hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2: None

 sound/soc/soc-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c81aec9c872a..4c55da97f9ed 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -865,10 +865,12 @@ static const struct snd_soc_dai_ops null_dai_ops = {
 };
 
 static struct snd_soc_component *soc_find_component(
-	const struct device_node *of_node, const char *name)
+	struct device_node *of_node, const char *name)
 {
 	struct snd_soc_component *component;
 
+	fwnode_ensure_device(&of_node->fwnode);
+
 	lockdep_assert_held(&client_mutex);
 
 	list_for_each_entry(component, &component_list, list) {
@@ -890,6 +892,8 @@ static struct snd_soc_dai *snd_soc_find_dai(
 	struct snd_soc_dai *dai;
 	struct device_node *component_of_node;
 
+	fwnode_ensure_device(&dlc->of_node->fwnode);
+
 	lockdep_assert_held(&client_mutex);
 
 	/* Find CPU DAI from registered DAIs*/
-- 
2.4.3
