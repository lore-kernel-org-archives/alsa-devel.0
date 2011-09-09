From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ALSA: keywest: Remove obsolete cleanup for clientdata
Date: Fri, 09 Sep 2011 17:50:52 +0800
Message-ID: <1315561852.2831.1.camel@phoenix>
References: <1315561784.2831.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1315561784.2831.0.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <w.sang@pengutronix.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The i2c core will clear the clientdata pointer automatically.
We don't have to set the `data' field to NULL in remove() or
if probe() failed anymore.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/ppc/keywest.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/ppc/keywest.c b/sound/ppc/keywest.c
index 8f064c7..4080bec 100644
--- a/sound/ppc/keywest.c
+++ b/sound/ppc/keywest.c
@@ -82,7 +82,6 @@ static int keywest_attach_adapter(struct i2c_adapter *adapter)
 
 static int keywest_remove(struct i2c_client *client)
 {
-	i2c_set_clientdata(client, NULL);
 	if (! keywest_ctx)
 		return 0;
 	if (client == keywest_ctx->client)
-- 
1.7.4.1
