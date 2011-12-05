From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove references to corgi and spitz
	from machine driver document
Date: Mon,  5 Dec 2011 19:29:25 +0000
Message-ID: <1323113365-14389-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1C9862417E
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 20:29:28 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

They're not currently actively worked on, the hardware being rather
obsolete by now.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 Documentation/sound/alsa/soc/machine.txt |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/sound/alsa/soc/machine.txt b/Documentation/sound/alsa/soc/machine.txt
index 3e2ec9c..d50c14d 100644
--- a/Documentation/sound/alsa/soc/machine.txt
+++ b/Documentation/sound/alsa/soc/machine.txt
@@ -50,8 +50,7 @@ Machine DAI Configuration
 The machine DAI configuration glues all the codec and CPU DAIs together. It can
 also be used to set up the DAI system clock and for any machine related DAI
 initialisation e.g. the machine audio map can be connected to the codec audio
-map, unconnected codec pins can be set as such. Please see corgi.c, spitz.c
-for examples.
+map, unconnected codec pins can be set as such.
 
 struct snd_soc_dai_link is used to set up each DAI in your machine. e.g.
 
@@ -83,8 +82,7 @@ Machine Power Map
 The machine driver can optionally extend the codec power map and to become an
 audio power map of the audio subsystem. This allows for automatic power up/down
 of speaker/HP amplifiers, etc. Codec pins can be connected to the machines jack
-sockets in the machine init function. See soc/pxa/spitz.c and dapm.txt for
-details.
+sockets in the machine init function.
 
 
 Machine Controls
-- 
1.7.7.3
