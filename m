From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH] Staging: line6: convert to snd_card_create()
Date: Sun, 29 Mar 2009 19:59:13 +0400
Message-ID: <20090329155913.GK11056@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 5838C1037F0
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Mar 2009 17:59:20 +0200 (CEST)
Received: by fxm18 with SMTP id 18so1700226fxm.32
	for <alsa-devel@alsa-project.org>; Sun, 29 Mar 2009 08:59:19 -0700 (PDT)
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
To: gregkh@suse.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 drivers/staging/line6/audio.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/line6/audio.c b/drivers/staging/line6/audio.c
index 3aa9468..e2ac8d6 100644
--- a/drivers/staging/line6/audio.c
+++ b/drivers/staging/line6/audio.c
@@ -27,11 +27,12 @@ int line6_init_audio(struct usb_line6 *line6)
 {
 	static int dev;
 	struct snd_card *card;
+	int err;
 
-	card = snd_card_new(line6_index[dev], line6_id[dev], THIS_MODULE, 0);
-
-	if (card == NULL)
-		return -ENOMEM;
+	err = snd_card_create(line6_index[dev], line6_id[dev], THIS_MODULE, 0,
+			      &card);
+	if (err < 0)
+		return err;
 
 	line6->card = card;
