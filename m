From: William Light <alsa-dev@wrl.illest.net>
Subject: [PATCH 1/2] ALSA: snd-usb-caiaq: Fix NULL dereference
	in input.c
Date: Mon, 10 Oct 2011 15:54:22 +0000
Message-ID: <1318262063-19247-2-git-send-email-alsa-dev@wrl.illest.net>
References: <1318262063-19247-1-git-send-email-alsa-dev@wrl.illest.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dudestache.don.gs (don.gs [208.79.89.122])
	by alsa0.perex.cz (Postfix) with ESMTP id 55A93103881
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Oct 2011 17:55:05 +0200 (CEST)
In-Reply-To: <1318262063-19247-1-git-send-email-alsa-dev@wrl.illest.net>
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
Cc: William Light <wrl@illest.net>
List-Id: alsa-devel@alsa-project.org

From: William Light <wrl@illest.net>

There was a case where a newly-registered input device could be opened before
a necessary variable in the device structure was set. When code tried to use
the variable in the URB reply callback, it would cause an Oops.

This fix sets the aforementioned variable before calling input_register_device.

Signed-off-by: William Light <wrl@illest.net>
---
 sound/usb/caiaq/input.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/usb/caiaq/input.c b/sound/usb/caiaq/input.c
index a213813..9efb92e 100644
--- a/sound/usb/caiaq/input.c
+++ b/sound/usb/caiaq/input.c
@@ -664,15 +664,17 @@ int snd_usb_caiaq_input_init(struct snd_usb_caiaqdev *dev)
 	for (i = 0; i < input->keycodemax; i++)
 		__set_bit(dev->keycode[i], input->keybit);
 
+	dev->input_dev = input;
+
 	ret = input_register_device(input);
 	if (ret < 0)
 		goto exit_free_idev;
 
-	dev->input_dev = input;
 	return 0;
 
 exit_free_idev:
 	input_free_device(input);
+	dev->input_dev = NULL;
 	return ret;
 }
 
-- 
1.7.6.1
