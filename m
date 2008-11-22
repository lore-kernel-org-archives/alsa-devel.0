From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 6/7] hda - fix DisplayPort naming
Date: Sat, 22 Nov 2008 09:40:56 +0800
Message-ID: <20081122014309.364143373@linux.intel.com>
References: <20081122014050.348491872@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga102.ch.intel.com (mga12.intel.com [143.182.124.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C228103806
	for <alsa-devel@alsa-project.org>; Sat, 22 Nov 2008 04:09:01 +0100 (CET)
Content-Disposition: inline; filename=alsa-dp-name.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

DisplayPort is a digital display interface standard put forth by
the Video Electronics Standards Association (VESA). It defines a
new license-free, royalty-free, digital audio/video interconnect,
intended to be used primarily between a computer and its display monitor,
or a computer and a home-theater system.

				- From Wikipedia, the free encyclopedia

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/hda_eld.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- sound-2.6.orig/sound/pci/hda/hda_eld.c
+++ sound-2.6/sound/pci/hda/hda_eld.c
@@ -72,7 +72,7 @@ static char *cea_speaker_allocation_name
 
 static char *eld_connection_type_names[4] = {
 	"HDMI",
-	"Display Port",
+	"DisplayPort",
 	"2-reserved",
 	"3-reserved"
 };

-- 
