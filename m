From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH MC Next Gen 05/20] media: Media Controller export non locking __media_entity_setup_link()
Date: Fri,  2 Oct 2015 16:07:17 -0600
Message-ID: <be68adb0a1119de9ce6905451292ecbb6fe6dfb5.1443822799.git.shuahkh@osg.samsung.com>
References: <cover.1443822799.git.shuahkh@osg.samsung.com>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <cover.1443822799.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1443822799.git.shuahkh@osg.samsung.com>
References: <cover.1443822799.git.shuahkh@osg.samsung.com>
Sender: linux-media-owner@vger.kernel.org
To: mchehab@osg.samsung.com, hans.verkuil@cisco.com, laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com, tiwai@suse.de, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, perex@perex.cz, dan.carpenter@oracle.com, tskd08@gmail.com, arnd@arndb.de, ruchandani.tina@gmail.com, corbet@lwn.net, k.kozlowski@samsung.com, chehabrafael@gmail.com, prabhakar.csengg@gmail.com, elfring@users.sourceforge.net, Julia.Lawall@lip6.fr, p.zabel@pengutronix.de, ricardo.ribalda@gmail.com, labbott@fedoraproject.org, chris.j.arges@canonical.com, pierre-louis.bossart@linux.intel.com, johan@oljud.se, wsa@the-dreams.de, jcragg@gmail.com, clemens@ladisch.de, daniel@zonque.org, gtmkramer@xs4all.nl, misterpib@gmail.com, takamichiho@gmail.com, pmatilai@laiskiainen.org, vladcatoi@gmail.com, damien@zamaudio.com, normalperson@yhbt.net, joe@oampo.co.uk, jussi@sonarnerd.netca
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-media@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Export __media_entity_setup_link() to be used from code paths that hold
the graph_mutex.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/media/media-entity.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/media-entity.c b/drivers/media/media-entity.c
index 797b7b3..49a8755 100644
--- a/drivers/media/media-entity.c
+++ b/drivers/media/media-entity.c
@@ -811,6 +811,7 @@ int __media_entity_setup_link(struct media_link *link, u32 flags)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(__media_entity_setup_link);
 
 int media_entity_setup_link(struct media_link *link, u32 flags)
 {
-- 
2.1.4
