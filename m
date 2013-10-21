From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [29/29] ALSA: dice: restrict the driver to playback-only
	devices
Date: Mon, 21 Oct 2013 21:42:01 +0200
Message-ID: <52658389.4040505@ladisch.de>
References: <52657E3B.7040205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <52657E3B.7040205@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

At the moment, this driver supports only playback, while FFADO supports
(only) full-duplex devices.  So, prevent conflicts by not claiming
devices that would be better handled by FFADO.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/Kconfig |   10 ++++++----
 sound/firewire/dice.c  |    9 +++++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 9153309..b3e274f 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -12,14 +12,16 @@ config SND_FIREWIRE_LIB
 	depends on SND_PCM

 config SND_DICE
-	tristate "DICE devices (EXPERIMENTAL)"
+	tristate "DICE-based DACs (EXPERIMENTAL)"
 	select SND_HWDEP
 	select SND_PCM
 	select SND_FIREWIRE_LIB
 	help
-	  Say Y here to include support for many FireWire audio interfaces
-	  based on the DICE chip family (DICE-II/Jr/Mini) from TC Applied
-	  Technologies.
+	  Say Y here to include support for many DACs based on the DICE
+	  chip family (DICE-II/Jr/Mini) from TC Applied Technologies.
+
+	  At the moment, this driver supports playback only.  If you
+	  want to use devices that support capturing, use FFADO instead.

 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-dice.
diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index 49d630b..6feee66 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -1128,6 +1128,7 @@ static int dice_interface_check(struct fw_unit *unit)
 	int key, value, vendor = -1, model = -1, err;
 	unsigned int category, i;
 	__be32 pointers[ARRAY_SIZE(min_values)];
+	__be32 tx_data[4];
 	__be32 version;

 	/*
@@ -1171,6 +1172,14 @@ static int dice_interface_check(struct fw_unit *unit)
 			return -ENODEV;
 	}

+	/* We support playback only. Let capture devices be handled by FFADO. */
+	err = snd_fw_transaction(unit, TCODE_READ_BLOCK_REQUEST,
+				 DICE_PRIVATE_SPACE +
+				 be32_to_cpu(pointers[2]) * 4,
+				 tx_data, sizeof(tx_data), 0);
+	if (err < 0 || (tx_data[0] && tx_data[3]))
+		return -ENODEV;
+
 	/*
 	 * Check that the implemented DICE driver specification major version
 	 * number matches.

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
