From: Antonio Borneo <borneo.antonio@gmail.com>
Subject: [PATCH v2 2/3] ASoC: soc-core: fix unbalanced of_node_get()/of_node_put()
Date: Fri, 28 Jul 2017 01:26:11 +0200
Message-ID: <20170727232612.23543-3-antonio.borneo@st.com>
References: <20170727232612.23543-1-antonio.borneo@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170727232612.23543-1-antonio.borneo@st.com>
In-Reply-To: <20170725214952.6491-1-borneo.antonio@gmail.com>
References: <20170725214952.6491-1-borneo.antonio@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: Antonio Borneo <borneo.antonio@gmail.com>, linux-kernel@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>, John Stultz <john.stultz@linaro.org>, linux-arm-kernel@lists.infradead.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

From: Antonio Borneo <borneo.antonio@gmail.com>

On Hikey target board, enabling CONFIG_OF_DYNAMIC triggers several
errors at kernel boot, like the following one
OF: ERROR: Bad of_node_put() on /soc/i2s@f7118000/ports/port@0/endpoint
each followed by stack dump.

of_graph_get_port_parent() walks through the parents looking for a
node named "ports". At each step it uses of_get_next_parent() that
drops the current node with of_node_put().
Avoid dropping the initial node by calling of_node_get() before
of_graph_get_port_parent().

Tested with kernel v4.13-rc2 with hikey_defconfig taken from
https://git.linaro.org/people/john.stultz/android-dev.git
branch dev/hikey-mainline-WIP

This fixes commit a180e8b98843 ("ASoC: add snd_soc_get_dai_id()
function").

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
---
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
To: Takashi Iwai <tiwai@suse.com>
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/soc-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 921622a..a0f39de 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4087,6 +4087,11 @@ int snd_soc_get_dai_id(struct device_node *ep)
 	struct device_node *node;
 	int ret;
 
+	/*
+	 * of_graph_get_port_parent() will call
+	 * of_node_put(). So, call of_node_get() here
+	 */
+	of_node_get(ep);
 	node = of_graph_get_port_parent(ep);
 
 	/*
-- 
1.9.1
