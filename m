From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: I2C fix for ice1724
Date: Sat, 01 Dec 2007 13:05:25 +0100
Message-ID: <47514E05.1060305@insite.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id E4B7024572
	for <alsa-devel@alsa-project.org>; Sat,  1 Dec 2007 13:05:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

Below is a patch for ice1724 I2C read code.


Thanks,

Pavel.


Signed-off-by: Pavel Hofman <dustin@seznam.cz>

* adding i2c busy wait before sending device address to prevent reading 
bogus data

diff -r 7f4b25ff79d6 pci/ice1712/ice1724.c
--- a/pci/ice1712/ice1724.c Fri Nov 30 17:59:25 2007 +0100
+++ b/pci/ice1712/ice1724.c Fri Nov 30 21:17:36 2007 +0100
@@ -1958,6 +1958,7 @@ unsigned char snd_vt1724_read_i2c(struct
         unsigned char val;

         mutex_lock(&ice->i2c_mutex);
+ wait_i2c_busy(ice);
         outb(addr, ICEREG1724(ice, I2C_BYTE_ADDR));
         outb(dev & ~VT1724_I2C_WRITE, ICEREG1724(ice, I2C_DEV_ADDR));
         wait_i2c_busy(ice);
