From: airlied@gmail.com
Subject: [PATCH] alsa: hda_codec: fix number of devices query
	on hotplug
Date: Tue,  9 Jun 2015 13:39:31 +1000
Message-ID: <1433821171-23519-1-git-send-email-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BEDC261B33
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 05:39:43 +0200 (CEST)
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (Postfix) with ESMTPS id C82008F31A
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 03:39:41 +0000 (UTC)
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
Cc: Dave Airlie <airlied@redhat.com>
List-Id: alsa-devel@alsa-project.org

From: Dave Airlie <airlied@redhat.com>

The new regmap code seems to cache this, which isn't helpful
for the hotplug dock situation where this gets updated.

Use the uncached query for this.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 sound/pci/hda/hda_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index b49feff..b778221 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -436,7 +436,7 @@ static unsigned int get_num_devices(struct hda_codec *codec, hda_nid_t nid)
 	    get_wcaps_type(wcaps) != AC_WID_PIN)
 		return 0;
 
-	parm = snd_hda_param_read(codec, nid, AC_PAR_DEVLIST_LEN);
+	parm = snd_hdac_read_parm_uncached(&codec->core, nid, AC_PAR_DEVLIST_LEN);
 	if (parm == -1 && codec->bus->rirb_error)
 		parm = 0;
 	return parm & AC_DEV_LIST_LEN_MASK;
-- 
2.4.1
