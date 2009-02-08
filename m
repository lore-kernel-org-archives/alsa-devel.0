From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] ALSA: hda - Bind new ecs mobo id (1019:2950)
	to model=ecs202
Date: Sun, 8 Feb 2009 19:50:34 -0200
Message-ID: <200902081950.34449.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B676243C3
	for <alsa-devel@alsa-project.org>; Sun,  8 Feb 2009 22:50:38 +0100 (CET)
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 072383EA5
	for <alsa-devel@alsa-project.org>; Sun,  8 Feb 2009 16:50:53 -0500 (EST)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id C6JrYgoqAkBO for <alsa-devel@alsa-project.org>;
	Sun,  8 Feb 2009 16:50:52 -0500 (EST)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id AAE303EA4
	for <alsa-devel@alsa-project.org>; Sun,  8 Feb 2009 16:50:52 -0500 (EST)
Received: from palo.localnet (unknown [172.21.225.10])
	by fox.conectiva (Postfix) with ESMTP id 553052F243
	for <alsa-devel@alsa-project.org>; Sun,  8 Feb 2009 18:50:35 -0300 (BRT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This adds a new sound quirk entry (model=ecs202) for an ecs motherboard
with IDT STAC9221 codec (1019:2950).

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
---
 sound/pci/hda/patch_sigmatel.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 85dc642..d16d5c6 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -2108,6 +2108,8 @@ static struct snd_pci_quirk stac922x_cfg_tbl[] = {
 		      "ECS/PC chips", STAC_ECS_202),
 	SND_PCI_QUIRK(0x1019, 0x2820,
 		      "ECS/PC chips", STAC_ECS_202),
+	SND_PCI_QUIRK(0x1019, 0x2950,
+		      "ECS/PC chips", STAC_ECS_202),
 	{} /* terminator */
 };
 
-- 
1.6.1.2
