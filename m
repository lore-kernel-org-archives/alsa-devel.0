From: Pascal Terjan <pterjan@mandriva.com>
Subject: [PATCH 2/3] [ALSA] Add quirk for Sony Vaio VGN-AR51M
Date: Mon, 28 Sep 2009 11:43:12 +0200
Message-ID: <1254130993-8235-3-git-send-email-pterjan@mandriva.com>
References: <1254130993-8235-1-git-send-email-pterjan@mandriva.com>
	<1254130993-8235-2-git-send-email-pterjan@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1254130993-8235-2-git-send-email-pterjan@mandriva.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Pascal Terjan <pterjan@mandriva.com>
List-Id: alsa-devel@alsa-project.org

From
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/195605/comments/35

Signed-off-by: Pascal Terjan <pterjan@mandriva.com>
---
 sound/pci/hda/patch_sigmatel.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index cd91d95..9d73311 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -5817,6 +5817,8 @@ static struct snd_pci_quirk stac9872_cfg_tbl[] = {
 			   "Sony VAIO F/S", STAC_9872_VAIO),
 	SND_PCI_QUIRK(0x104d, 0x9008,
 			   "Sony Vaio VGN-SZ650N", STAC_9872_VAIO),
+	SND_PCI_QUIRK(0x104d, 0x9016,
+			   "Sony Vaio VGN-AR51M", STAC_9872_VAIO),
 	{} /* terminator */
 };
 
-- 
1.6.4.2
