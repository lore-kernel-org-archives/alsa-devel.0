From: Ralf Baechle <ralf@linux-mips.org>
Subject: [SOUND] hda_intel: build fix
Date: Sat, 10 Mar 2007 19:05:13 +0000
Message-ID: <20070310190513.GA24435__39204.7468260445$1173553730$gmane$org@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from ftp.linux-mips.org (ftp.linux-mips.org [194.74.144.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C7D81037E9
	for <alsa-devel@alsa-project.org>; Sat, 10 Mar 2007 20:07:14 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:2970 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021915AbXCJTHN (ORCPT <rfc822;alsa-devel@alsa-project.org>);
	Sat, 10 Mar 2007 19:07:13 +0000
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>, perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

  CC [M]  sound/pci/hda/hda_intel.o
sound/pci/hda/hda_intel.c:1508: error: position_fix_list causes a section type conflict

Gcc like its __devinitdata readable not const, it seems.  An alternative
fix would be to remove the __devinitdata attribute but that would result
in slight runtime bloat.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index b9a8e23..63b6854 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1505,7 +1505,7 @@ static int azx_dev_free(struct snd_device *device)
 /*
  * white/black-listing for position_fix
  */
-static const struct snd_pci_quirk position_fix_list[] __devinitdata = {
+static struct snd_pci_quirk position_fix_list[] __devinitdata = {
 	SND_PCI_QUIRK(0x1028, 0x01cc, "Dell D820", POS_FIX_NONE),
 	{}
 };

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
