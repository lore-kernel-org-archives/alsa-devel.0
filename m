From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/13] ASoC: Add helper function to cast
	component back to CODEC
Date: Tue, 18 Mar 2014 09:02:10 +0100
Message-ID: <1395129736-11938-8-git-send-email-lars@metafoo.de>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-224.synserver.de (smtp-out-230.synserver.de
 [212.40.185.230])
 by alsa0.perex.cz (Postfix) with ESMTP id 68C19261B0E
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 09:01:47 +0100 (CET)
In-Reply-To: <1395129736-11938-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Add a helper function to cast back from a component struct to the CODEC struct
it is embedded in. This is useful in situations where we know that a certain
component is a CODEC and want to get access to some CODEC specific properties.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index f6d7ef4f..a355d0f 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1093,6 +1093,19 @@ struct soc_enum {
 	const unsigned int *values;
 };
 
+/**
+ * snd_soc_component_to_codec() - Casts a component to the CODEC it is embedded in
+ * @component: The component to cast to a CODEC
+ *
+ * This function must only be used on components that are known to be CODECs.
+ * Otherwise the behavior is undefined.
+ */
+static inline struct snd_soc_codec *snd_soc_component_to_codec(
+	struct snd_soc_component *component)
+{
+	return container_of(component, struct snd_soc_codec, component);
+}
+
 /* codec IO */
 unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg);
 unsigned int snd_soc_write(struct snd_soc_codec *codec,
-- 
1.8.0
