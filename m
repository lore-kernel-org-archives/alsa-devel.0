From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-twl4030: Update the header file to
	support more boards
Date: Thu, 6 Dec 2012 15:35:25 +0100
Message-ID: <1354804525-5330-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B88E2615C7
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2012 15:35:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The common machine driver will be able to support new boards where the voice
port is also in use.
At the same time add possibility to fine tune the connections from twl4030
on the board: jack detection GPIO, input/output selection

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Mark, Liam Tony,

I just finalized a series which I intend to send for 3.9:
It is going to update the omap-twl4030 ASoC machine driver to support more
boards, thus allowing me to remove the driver for zoom2 and sdp3440.
The issue is that in order to do it I need to make modification in
arch/arm/mach-omap2/ and sound/soc/omap/ as well.
One patch which changes the header file is the only compile time requirement
for the changes.

As a reference this is how my tree looks like regarding to this change (need to
sort them still),
git log --oneline :
1702213 ASoC: OMAP: Remove obsolete machine drivers for Zoom2 and SDP3403
41ff1a6 ARM: OMAP: sdp3430: Audio support via the common omap-twl4030 machine driver
f51363ed ARM: OMAP: zoom: Audio support via the common omap-twl4030 machine driver
159e443 ASoC: omap-twl4030: Add support for routing, voice port and jack detect
77bda45 ARM: OMAP2+: twl-common: Allow boards to customize the twl4030 audio setup
0db92ac ARM: OMAP2+: twl-common: Add default twl4030 audio configuration
9005d5b ARM: OMAP: zoom: Zoom2 does not have extmute functionality
c7ffd18 ASoC: sdp3430: No need to configure pin mux for extmute
43dc9d9 ASoC: twl4030: Configure extmute pinmux when the dedicated pin is in use
db9207c ARM: OMAP: 3430sdp: Enable extmute functionality for audio
e6aea6f ASoC: twl4030: Convert MICBIAS to SUPPLY widget
8eadb74 ASoC: sdp3430: No need to configure the Voice port anymore
f11c1be ASoC: zoom2: No need to configure the Voice port anymore
63da45d ASoC: twl4030: Correct the support for Voice port
a98e934 ASoC: omap-twl4030: Update the header file to support more boards

I know it is quite late already, but Mark would you be able the squeeze in this
patch for 3.8?
If this is in, I can separate the arch/arm/mach-omap2/ and sound/soc/omap/
patches and queue them via the appropriate tree without creating cross tree merge
issues (yes, again cross tree issue).
All of these will come together for 3.9 and in linux-next.

This header change does not affect the current driver since the new parameters
are ignored by the current driver

Mark, would you be able to do this?

Thank you,
Peter

 include/linux/platform_data/omap-twl4030.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/platform_data/omap-twl4030.h b/include/linux/platform_data/omap-twl4030.h
index c7bef78..ee60ef7 100644
--- a/include/linux/platform_data/omap-twl4030.h
+++ b/include/linux/platform_data/omap-twl4030.h
@@ -25,8 +25,34 @@
 #ifndef _OMAP_TWL4030_H_
 #define _OMAP_TWL4030_H_
 
+/* To select if only one channel is connected in a stereo port */
+#define OMAP_TWL4030_LEFT	(1 << 0)
+#define OMAP_TWL4030_RIGHT	(1 << 1)
+
 struct omap_tw4030_pdata {
 	const char *card_name;
+	/* Voice port is connected to McBSP3 */
+	bool voice_connected;
+
+	/* The driver will parse the connection flags if this flag is set */
+	bool	custom_routing;
+	/* Flags to indicate connected audio ports. */
+	u8	has_hs;
+	u8	has_hf;
+	u8	has_predriv;
+	u8	has_carkit;
+	bool	has_ear;
+
+	bool	has_mainmic;
+	bool	has_submic;
+	bool	has_hsmic;
+	bool	has_carkitmic;
+	bool	has_digimic0;
+	bool	has_digimic1;
+	u8	has_linein;
+
+	/* Jack detect GPIO or  <= 0 if it is not implemented */
+	int jack_detect;
 };
 
 #endif /* _OMAP_TWL4030_H_ */
-- 
1.8.0
