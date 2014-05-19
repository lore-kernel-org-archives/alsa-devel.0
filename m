From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 8/13] sound: mpu401.c: make return of 0 explicit
Date: Mon, 19 May 2014 06:31:10 +0200
Message-ID: <1400473875-22228-9-git-send-email-Julia.Lawall@lip6.fr>
References: <1400473875-22228-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by alsa0.perex.cz (Postfix) with ESMTP id AA7DB2650CE
 for <alsa-devel@alsa-project.org>; Mon, 19 May 2014 06:32:47 +0200 (CEST)
In-Reply-To: <1400473875-22228-1-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Delete unnecessary local variable whose value is always 0 and that hides
the fact that the result is always 0.

A simplified version of the semantic patch that fixes this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@r exists@
local idexpression ret;
expression e;
position p;
@@

-ret = 0;
... when != ret = e
return 
- ret
+ 0
  ;
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/oss/mpu401.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/oss/mpu401.c b/sound/oss/mpu401.c
index 25e4609..3bbc3ec 100644
--- a/sound/oss/mpu401.c
+++ b/sound/oss/mpu401.c
@@ -567,7 +567,6 @@ static int mpu401_out(int dev, unsigned char midi_byte)
 static int mpu401_command(int dev, mpu_command_rec * cmd)
 {
 	int i, timeout, ok;
-	int ret = 0;
 	unsigned long   flags;
 	struct mpu_config *devc;
 
@@ -644,7 +643,6 @@ retry:
 			}
 		}
 	}
-	ret = 0;
 	cmd->data[0] = 0;
 
 	if (cmd->nr_returns)
@@ -666,7 +664,7 @@ retry:
 		}
 	}
 	spin_unlock_irqrestore(&devc->lock,flags);
-	return ret;
+	return 0;
 }
 
 static int mpu_cmd(int dev, int cmd, int data)
