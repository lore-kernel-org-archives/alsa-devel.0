From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Fix uninitialized HDMI
	controllers with VGA-switcheroo
Date: Thu,  7 Jun 2012 12:15:16 +0200
Message-ID: <1339064116-18579-3-git-send-email-tiwai@suse.de>
References: <1339064116-18579-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 4694310B955
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 12:15:49 +0200 (CEST)
In-Reply-To: <1339064116-18579-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Airlie <airlied@linux.ie>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, =?UTF-8?q?J=C3=B6rg-Volker=20Peetz?= <jvpeetz@web.de>, dri-devel@lists.freedesktop.org, Steven Newbury <steve@snewbury.org.uk>
List-Id: alsa-devel@alsa-project.org

When VGA-switcheroo is built in but unused on systems with multiple
graphics cards, the initializations of non-default graphics cards are
skipped and never enabled (because the switcheroo is activated only
when the controller supports).  The current behavior is for avoiding
the system lockup by accessing the disabled GPU, but due to the recent
change in VGA-switcheroo, it determines the state simply by checking
with the default VGA device.  This is the culprit.

Now with the new vga_switcheroo_get_client_state(), we can know the
initial state of the bound GPU, thus can determine the initial audio
client state more correctly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 2b6392b..5f0375f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2670,7 +2670,7 @@ static bool __devinit check_hdmi_disabled(struct pci_dev *pci)
 	struct pci_dev *p = get_bound_vga(pci);
 
 	if (p) {
-		if (vga_default_device() && p != vga_default_device())
+		if (vga_switcheroo_get_client_state(p) == VGA_SWITCHEROO_OFF)
 			vga_inactive = true;
 		pci_dev_put(p);
 	}
-- 
1.7.10.4
