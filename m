From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH v3 07/22] media: Media Controller export non locking __media_entity_setup_link()
Date: Thu, 11 Feb 2016 16:41:23 -0700
Message-ID: <07bb3165b50ea9607b6dbf682a0557d37438b4bf.1455233153.git.shuahkh@osg.samsung.com>
References: <cover.1455233150.git.shuahkh@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1455233150.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1455233150.git.shuahkh@osg.samsung.com>
References: <cover.1455233150.git.shuahkh@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mchehab@osg.samsung.com, tiwai@suse.com, clemens@ladisch.de, hans.verkuil@cisco.com, laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com, javier@osg.samsung.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, perex@perex.cz, arnd@arndb.de, dan.carpenter@oracle.com, tvboxspy@gmail.com, crope@iki.fi, ruchandani.tina@gmail.com, corbet@lwn.net, chehabrafael@gmail.com, k.kozlowski@samsung.com, stefanr@s5r6.in-berlin.de, inki.dae@samsung.com, jh1009.sung@samsung.com, elfring@users.sourceforge.net, prabhakar.csengg@gmail.com, sw0312.kim@samsung.com, p.zabel@pengutronix.de, ricardo.ribalda@gmail.com, labbott@fedoraproject.org, pierre-louis.bossart@linux.intel.com, ricard.wanderlof@axis.com, julian@jusst.de, takamichiho@gmail.com, dominic.sacre@gmx.de, misterpib@gmail.com, daniel@zonque.org, gtmkramer@xs4all.nl, normalperson@yhbt.net, joe@oampo.co.uk, linuxbugs@vittgam.net, johan@oljud.se, klock.android@gmail.com, nenggun.kim@samsung.com, j.anaszewski@samsung.com, geliangtang
List-Id: alsa-devel@alsa-project.org

Export __media_entity_setup_link() to be used from code paths
that hold the graph_mutex.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/media/media-entity.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/media-entity.c b/drivers/media/media-entity.c
index 6179543..9b4d712 100644
--- a/drivers/media/media-entity.c
+++ b/drivers/media/media-entity.c
@@ -805,6 +805,7 @@ int __media_entity_setup_link(struct media_link *link, u32 flags)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(__media_entity_setup_link);
 
 int media_entity_setup_link(struct media_link *link, u32 flags)
 {
-- 
2.5.0
