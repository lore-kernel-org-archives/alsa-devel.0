From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ALSA: firewire: fix error return code in scs_probe()
Date: Tue, 18 Jun 2013 21:09:42 +0800
Message-ID: <CAPgLHd-HMw40igirFvFHtN3HNy2utXHVAVERxKQ-vwF9ecUaSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: clemens@ladisch.de, perex@perex.cz, tiwai@suse.de
Cc: yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return -ENOMEM in the kmalloc() error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/firewire/scs1x.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/scs1x.c b/sound/firewire/scs1x.c
index 844a555..b252c21 100644
--- a/sound/firewire/scs1x.c
+++ b/sound/firewire/scs1x.c
@@ -405,8 +405,10 @@ static int scs_probe(struct device *unit_dev)
 	scs->output_idle = true;
 
 	scs->buffer = kmalloc(HSS1394_MAX_PACKET_SIZE, GFP_KERNEL);
-	if (!scs->buffer)
+	if (!scs->buffer) {
+		err = -ENOMEM;
 		goto err_card;
+	}
 
 	scs->hss_handler.length = HSS1394_MAX_PACKET_SIZE;
 	scs->hss_handler.address_callback = handle_hss;
