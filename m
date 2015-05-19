From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Sync HD-Audio-Models.txt for
	Realtek codecs
Date: Tue, 19 May 2015 10:23:08 +0200
Message-ID: <1432023788-1666-2-git-send-email-tiwai@suse.de>
References: <1432023788-1666-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 67CB1260695
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 10:23:09 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 29C8AAC5D
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 08:23:09 +0000 (UTC)
In-Reply-To: <1432023788-1666-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Added missing model entries and updated the codec names.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/alsa/HD-Audio-Models.txt | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt b/Documentation/sound/alsa/HD-Audio-Models.txt
index d92b85d38adc..ec099d4343f2 100644
--- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -11,7 +11,10 @@ ALC880
 
 ALC260
 ======
-  N/A
+  gpio1		Enable GPIO1
+  coef		Enable EAPD via COEF table
+  fujitsu	Quirk for FSC S7020
+  fujitsu-jwse	Quirk for FSC S7020 with jack modes and HP mic support
 
 ALC262
 ======
@@ -20,8 +23,9 @@ ALC262
 ALC267/268
 ==========
   inv-dmic	Inverted internal mic workaround
+  hp-eapd	Disable HP EAPD on NID 0x15
 
-ALC269/270/275/276/28x/29x
+ALC22x/23x/25x/269/27x/28x/29x (and vendor-specific ALC3xxx models)
 ======
   laptop-amic		Laptops with analog-mic input
   laptop-dmic		Laptops with digital-mic input
@@ -32,8 +36,12 @@ ALC269/270/275/276/28x/29x
   headset-mode		More comprehensive headset support for ALC269 & co
   headset-mode-no-hp-mic Headset mode support without headphone mic
   lenovo-dock   	Enables docking station I/O for some Lenovos
+  hp-gpio-led		GPIO LED support on HP laptops
   dell-headset-multi	Headset jack, which can also be used as mic-in
   dell-headset-dock	Headset jack (without mic-in), and also dock I/O
+  alc283-dac-wcaps	Fixups for Chromebook with ALC283
+  alc283-sense-combo	Combo jack sensing on ALC283
+  tpt440-dock		Pin configs for Lenovo Thinkpad Dock support
 
 ALC66x/67x/892
 ==============
-- 
2.4.1
