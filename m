From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: es1968: precedence bug in
	snd_es1968_tea575x_get_pins()
Date: Tue, 13 Nov 2012 10:44:54 +0300
Message-ID: <20121113074454.GB13198@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id D6FD326031A
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 08:45:11 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Ondrej Zary <linux@rainbow-software.org>, Mauro Carvalho Chehab <mchehab@redhat.com>, Takashi Iwai <tiwai@suse.de>, Rusty Russell <rusty@rustcorp.com.au>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: alsa-devel@alsa-project.org

I don't think this works as intended.  '|' higher precedence than ?: so
the bitwize OR "0 | (val & STR_MOST)" is a no-op.

I have re-written it to be more clear.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I don't have a way to test this.

diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index 50169bc..7266020 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -2581,9 +2581,14 @@ static u8 snd_es1968_tea575x_get_pins(struct snd_tea575x *tea)
 	struct es1968 *chip = tea->private_data;
 	unsigned long io = chip->io_port + GPIO_DATA;
 	u16 val = inw(io);
-
-	return  (val & STR_DATA) ? TEA575X_DATA : 0 |
-		(val & STR_MOST) ? TEA575X_MOST : 0;
+	u8 ret;
+
+	ret = 0;
+	if (val & STR_DATA)
+		ret |= TEA575X_DATA;
+	if (val & STR_MOST)
+		ret |= TEA575X_MOST;
+	return ret;
 }
 
 static void snd_es1968_tea575x_set_direction(struct snd_tea575x *tea, bool output)
