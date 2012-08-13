From: Wang Xingchao <xingchao.wang@intel.com>
Subject: [PATCH 2/3] ALSA: hda - fix Copyright debug message
Date: Mon, 13 Aug 2012 14:11:10 +0800
Message-ID: <1344838271-3528-2-git-send-email-xingchao.wang@intel.com>
References: <1344838271-3528-1-git-send-email-xingchao.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BA61265CA9
 for <alsa-devel@alsa-project.org>; Mon, 13 Aug 2012 07:53:36 +0200 (CEST)
In-Reply-To: <1344838271-3528-1-git-send-email-xingchao.wang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

As spec said, 1 indicates no copyright is asserted.

Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
---
 sound/pci/hda/hda_proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index a222aae..bb9e8f9 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -412,7 +412,7 @@ static void print_digital_conv(struct snd_info_buffer *buffer,
 	if (digi1 & AC_DIG1_EMPHASIS)
 		snd_iprintf(buffer, " Preemphasis");
 	if (digi1 & AC_DIG1_COPYRIGHT)
-		snd_iprintf(buffer, " Copyright");
+		snd_iprintf(buffer, " Non-Copyright");
 	if (digi1 & AC_DIG1_NONAUDIO)
 		snd_iprintf(buffer, " Non-Audio");
 	if (digi1 & AC_DIG1_PROFESSIONAL)
-- 
1.7.9.5
