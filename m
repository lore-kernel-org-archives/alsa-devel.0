From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH v2 02/11] ALSA: hdac: Fix codec name after machine driver is unloaded and reloaded
Date: Mon, 17 Jun 2019 13:36:35 +0200
Message-ID: <20190617113644.25621-3-amadeuszx.slawinski@linux.intel.com>
References: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Currently on each driver reload internal counter is being increased. It
causes failure to enumerate driver devices, as they have hardcoded:
.codec_name = "ehdaudio0D2",
As there is currently no devices with multiple hda codecs and there is
currently no established way to reliably differentiate, between them,
always assign bus->idx = 0;

This fixes a problem when we unload and reload machine driver idx gets
incremented, so .codec_name would've needed to be set to "ehdaudio1D2"
after first reload and so on.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/hda/ext/hdac_ext_bus.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index a3a113ef5d56..4f9f1d2a2ec5 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -85,7 +85,6 @@ int snd_hdac_ext_bus_init(struct hdac_bus *bus, struct device *dev,
 			const struct hdac_ext_bus_ops *ext_ops)
 {
 	int ret;
-	static int idx;
 
 	/* check if io ops are provided, if not load the defaults */
 	if (io_ops == NULL)
@@ -96,7 +95,12 @@ int snd_hdac_ext_bus_init(struct hdac_bus *bus, struct device *dev,
 		return ret;
 
 	bus->ext_ops = ext_ops;
-	bus->idx = idx++;
+	/* FIXME:
+	 * Currently only one bus is supported, if there is device with more
+	 * buses, bus->idx should be greater than 0, but there needs to be a
+	 * reliable way to always assign same number.
+	 */
+	bus->idx = 0;
 	bus->cmd_dma_state = true;
 
 	return 0;
-- 
2.17.1
