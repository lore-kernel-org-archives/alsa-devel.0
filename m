From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: hdac: add missing \n to end of dev_err messages
Date: Fri, 16 Sep 2016 17:36:05 +0100
Message-ID: <20160916163605.11615-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Mark Brown <broonie@kernel.org>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Trival fix, some dev_err messages are missing a \n, so add it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/hda/ext/hdac_ext_stream.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
index 2441273..3be051a 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -424,7 +424,7 @@ void snd_hdac_ext_stream_spbcap_enable(struct hdac_ext_bus *ebus,
 	struct hdac_bus *bus = &ebus->bus;
 
 	if (!bus->spbcap) {
-		dev_err(bus->dev, "Address of SPB capability is NULL");
+		dev_err(bus->dev, "Address of SPB capability is NULL\n");
 		return;
 	}
 
@@ -453,7 +453,7 @@ int snd_hdac_ext_stream_set_spib(struct hdac_ext_bus *ebus,
 	struct hdac_bus *bus = &ebus->bus;
 
 	if (!bus->spbcap) {
-		dev_err(bus->dev, "Address of SPB capability is NULL");
+		dev_err(bus->dev, "Address of SPB capability is NULL\n");
 		return -EINVAL;
 	}
 
@@ -476,7 +476,7 @@ int snd_hdac_ext_stream_get_spbmaxfifo(struct hdac_ext_bus *ebus,
 	struct hdac_bus *bus = &ebus->bus;
 
 	if (!bus->spbcap) {
-		dev_err(bus->dev, "Address of SPB capability is NULL");
+		dev_err(bus->dev, "Address of SPB capability is NULL\n");
 		return -EINVAL;
 	}
 
@@ -516,7 +516,7 @@ void snd_hdac_ext_stream_drsm_enable(struct hdac_ext_bus *ebus,
 	struct hdac_bus *bus = &ebus->bus;
 
 	if (!bus->drsmcap) {
-		dev_err(bus->dev, "Address of DRSM capability is NULL");
+		dev_err(bus->dev, "Address of DRSM capability is NULL\n");
 		return;
 	}
 
@@ -545,7 +545,7 @@ int snd_hdac_ext_stream_set_dpibr(struct hdac_ext_bus *ebus,
 	struct hdac_bus *bus = &ebus->bus;
 
 	if (!bus->drsmcap) {
-		dev_err(bus->dev, "Address of DRSM capability is NULL");
+		dev_err(bus->dev, "Address of DRSM capability is NULL\n");
 		return -EINVAL;
 	}
 
-- 
2.9.3
