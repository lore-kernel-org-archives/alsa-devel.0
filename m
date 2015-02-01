From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: riptide: off by one in
	snd_riptide_joystick_probe()
Date: Sun, 1 Feb 2015 23:49:02 +0300
Message-ID: <20150201204902.GA29129@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id CE63C260437
 for <alsa-devel@alsa-project.org>; Sun,  1 Feb 2015 21:49:28 +0100 (CET)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Benoit Taine <benoit.taine@lip6.fr>, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Hans Wennborg <hans@hanshq.net>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: alsa-devel@alsa-project.org

There is an off by one bug in snd_riptide_joystick_probe() because we
do the "dev++" toward the start of the function instead of waiting until
the end.

The impact of this bug is:
1) A static checker warning.
2) If you connect 32 joysticks to your computer they will fail to load
   with a different error message than intended.
3) If you pass a module option to specify a non-default joystick port
   then the parameter array has to be shifted one element.

The first two are not serious.  For the third one, it's probably too
late to change it since the bug was introduced in 2009.  Either no one
noticed and we can leave it alone, or if they did notice, they probably
have implemented work arounds so we can't change it now without
confusing them.

So instead of fixing it the "theoretically correct way", I have decided
to just work around it by making the joystick_port[] one element
larger.  This silences the static checker warning and doesn't affect
user space.

Fixes: db1005ec6ff8 ('ALSA: riptide - Fix joystick resource handling')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index 29f2827..324e34c 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -125,7 +125,11 @@ static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
 static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;
 
 #ifdef SUPPORT_JOYSTICK
-static int joystick_port[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS - 1)] = 0x200 };
+/*
+ * The joystick_port accounting is off by one but I'm afraid to change it for
+ * fear of breaking userspace.
+ */
+static int joystick_port[SNDRV_CARDS + 1] = { [0 ... (SNDRV_CARDS)] = 0x200 };
 #endif
 static int mpu_port[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS - 1)] = 0x330 };
 static int opl3_port[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS - 1)] = 0x388 };
