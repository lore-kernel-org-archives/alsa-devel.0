From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: fm801: precedence bug in
	snd_fm801_tea575x_get_pins()
Date: Wed, 14 Nov 2012 11:23:54 +0300
Message-ID: <20121114082354.GB31792@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 94AB9260799
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 09:24:09 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Mauro Carvalho Chehab <mchehab@redhat.com>, Takashi Iwai <tiwai@suse.de>, Rusty Russell <rusty@rustcorp.com.au>, kernel-janitors@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Hans Verkuil <hans.verkuil@cisco.com>
List-Id: alsa-devel@alsa-project.org

There is a precedence bug because | has higher precedence than ?:.  This
code was cut and pasted and I fixed a similar bug a few days ago.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index cc2e91d..c5806f8 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -767,9 +767,14 @@ static u8 snd_fm801_tea575x_get_pins(struct snd_tea575x *tea)
 	struct fm801 *chip = tea->private_data;
 	unsigned short reg = inw(FM801_REG(chip, GPIO_CTRL));
 	struct snd_fm801_tea575x_gpio gpio = *get_tea575x_gpio(chip);
-
-	return  (reg & FM801_GPIO_GP(gpio.data)) ? TEA575X_DATA : 0 |
-		(reg & FM801_GPIO_GP(gpio.most)) ? TEA575X_MOST : 0;
+	u8 ret;
+
+	ret = 0;
+	if (reg & FM801_GPIO_GP(gpio.data))
+		ret |= TEA575X_DATA;
+	if (reg & FM801_GPIO_GP(gpio.most))
+		ret |= TEA575X_MOST;
+	return ret;
 }
 
 static void snd_fm801_tea575x_set_direction(struct snd_tea575x *tea, bool output)
