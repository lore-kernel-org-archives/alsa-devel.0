From: Pascal Terjan <pterjan@mandriva.com>
Subject: [PATCH 1/3] [ALSA] Add quirk for Sony Vaio VGN-SZ650N
Date: Mon, 28 Sep 2009 11:43:11 +0200
Message-ID: <1254130993-8235-2-git-send-email-pterjan@mandriva.com>
References: <1254130993-8235-1-git-send-email-pterjan@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1254130993-8235-1-git-send-email-pterjan@mandriva.com>
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
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/195605/comments/25

Signed-off-by: Pascal Terjan <pterjan@mandriva.com>
---
 sound/pci/hda/patch_sigmatel.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 826137e..cd91d95 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -5815,6 +5815,8 @@ static unsigned int *stac9872_brd_tbl[STAC_9872_MODELS] = {
 static struct snd_pci_quirk stac9872_cfg_tbl[] = {
 	SND_PCI_QUIRK_MASK(0x104d, 0xfff0, 0x81e0,
 			   "Sony VAIO F/S", STAC_9872_VAIO),
+	SND_PCI_QUIRK(0x104d, 0x9008,
+			   "Sony Vaio VGN-SZ650N", STAC_9872_VAIO),
 	{} /* terminator */
 };
 
-- 
1.6.4.2
