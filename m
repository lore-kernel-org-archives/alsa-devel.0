From: Andre Guedes <andre.guedes@intel.com>
Subject: [PATCH - Multiple plugins 4/4] usb_stream: Fix leaks
	when us_set_hw_constraint() fails
Date: Fri, 28 Sep 2018 14:27:27 -0700
Message-ID: <20180928212727.15151-5-andre.guedes@intel.com>
References: <20180928212727.15151-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A7862678C5
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2018 23:27:59 +0200 (CEST)
In-Reply-To: <20180928212727.15151-1-andre.guedes@intel.com>
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
List-Id: alsa-devel@alsa-project.org

If us_set_hw_constraint() returns error, we leak the 'us' object and all
the resources referenced by it. This patch fixes the issue by calling
us_free() before returning.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 usb_stream/pcm_usb_stream.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/usb_stream/pcm_usb_stream.c b/usb_stream/pcm_usb_stream.c
index 94c83a7..eb4ca98 100644
--- a/usb_stream/pcm_usb_stream.c
+++ b/usb_stream/pcm_usb_stream.c
@@ -455,6 +455,7 @@ static int snd_pcm_us_open(snd_pcm_t **pcmp, const char *name,
 	err = us_set_hw_constraint(us);
 	if (err < 0) {
 		snd_pcm_ioplug_delete(&us->io);
+		us_free(us);
 		return err;
 	}
 
-- 
2.14.4
