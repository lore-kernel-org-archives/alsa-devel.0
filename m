From: pavel.hofman@ivitera.com
Subject: [PATCH 4/6] Adding GPIO routines for mask and direction
Date: Tue, 15 Sep 2009 00:45:01 +0200
Message-ID: <1252968303-29334-4-git-send-email-pavel.hofman@ivitera.com>
References: <1252968303-29334-1-git-send-email-pavel.hofman@ivitera.com>
	<1252968303-29334-2-git-send-email-pavel.hofman@ivitera.com>
	<1252968303-29334-3-git-send-email-pavel.hofman@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1252968303-29334-3-git-send-email-pavel.hofman@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Pavel Hofman <pavel.hofman@ivitera.com>


Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>

diff --git a/pci/ice1712/ice1712.c b/pci/ice1712/ice1712.c
index cecf1ff..56d8d67 100644
--- a/pci/ice1712/ice1712.c
+++ b/pci/ice1712/ice1712.c
@@ -298,6 +298,16 @@ static void snd_ice1712_set_gpio_dir(struct snd_ice1712 *ice, unsigned int data)
 	inb(ICEREG(ice, DATA)); /* dummy read for pci-posting */
 }
 
+static unsigned int snd_ice1712_get_gpio_dir(struct snd_ice1712 *ice)
+{
+	return snd_ice1712_read(ice, ICE1712_IREG_GPIO_DIRECTION);
+}
+
+static unsigned int snd_ice1712_get_gpio_mask(struct snd_ice1712 *ice)
+{
+	return snd_ice1712_read(ice, ICE1712_IREG_GPIO_WRITE_MASK);
+}
+
 static void snd_ice1712_set_gpio_mask(struct snd_ice1712 *ice, unsigned int data)
 {
 	snd_ice1712_write(ice, ICE1712_IREG_GPIO_WRITE_MASK, data);
@@ -2557,7 +2567,9 @@ static int __devinit snd_ice1712_create(struct snd_card *card,
 	mutex_init(&ice->i2c_mutex);
 	mutex_init(&ice->open_mutex);
 	ice->gpio.set_mask = snd_ice1712_set_gpio_mask;
+	ice->gpio.get_mask = snd_ice1712_get_gpio_mask;
 	ice->gpio.set_dir = snd_ice1712_set_gpio_dir;
+	ice->gpio.get_dir = snd_ice1712_get_gpio_dir;
 	ice->gpio.set_data = snd_ice1712_set_gpio_data;
 	ice->gpio.get_data = snd_ice1712_get_gpio_data;
 
diff --git a/pci/ice1712/ice1712.h b/pci/ice1712/ice1712.h
index 9da2dae..2105055 100644
--- a/pci/ice1712/ice1712.h
+++ b/pci/ice1712/ice1712.h
@@ -28,6 +28,7 @@
 #include <sound/i2c.h>
 #include <sound/ak4xxx-adda.h>
 #include <sound/ak4114.h>
+#include <sound/ak4113.h>
 #include <sound/pt2258.h>
 #include <sound/pcm.h>
 #include <sound/mpu401.h>
@@ -359,7 +360,9 @@ struct snd_ice1712 {
 		unsigned int saved[2];		/* for ewx_i2c */
 		/* operators */
 		void (*set_mask)(struct snd_ice1712 *ice, unsigned int data);
+		unsigned int (*get_mask)(struct snd_ice1712 *ice);
 		void (*set_dir)(struct snd_ice1712 *ice, unsigned int data);
+		unsigned int (*get_dir)(struct snd_ice1712 *ice);
 		void (*set_data)(struct snd_ice1712 *ice, unsigned int data);
 		unsigned int (*get_data)(struct snd_ice1712 *ice);
 		/* misc operators - move to another place? */
@@ -399,6 +402,11 @@ static inline void snd_ice1712_gpio_set_dir(struct snd_ice1712 *ice, unsigned in
 	ice->gpio.set_dir(ice, bits);
 }
 
+static inline unsigned int snd_ice1712_gpio_get_dir(struct snd_ice1712 *ice)
+{
+	return ice->gpio.get_dir(ice);
+}
+
 static inline void snd_ice1712_gpio_set_mask(struct snd_ice1712 *ice, unsigned int bits)
 {
 	ice->gpio.set_mask(ice, bits);
diff --git a/pci/ice1712/ice1724.c b/pci/ice1712/ice1724.c
index af6e001..673edd5 100644
--- a/pci/ice1712/ice1724.c
+++ b/pci/ice1712/ice1724.c
@@ -196,6 +196,12 @@ static void snd_vt1724_set_gpio_dir(struct snd_ice1712 *ice, unsigned int data)
 	inw(ICEREG1724(ice, GPIO_DIRECTION)); /* dummy read for pci-posting */
 }
 
+/* get gpio direction 0 = read, 1 = write */
+static unsigned int snd_vt1724_get_gpio_dir(struct snd_ice1712 *ice)
+{
+	return inl(ICEREG1724(ice, GPIO_DIRECTION));
+}
+
 /* set the gpio mask (0 = writable) */
 static void snd_vt1724_set_gpio_mask(struct snd_ice1712 *ice, unsigned int data)
 {
@@ -2435,6 +2441,7 @@ static int __devinit snd_vt1724_create(struct snd_card *card,
 	mutex_init(&ice->i2c_mutex);
 	ice->gpio.set_mask = snd_vt1724_set_gpio_mask;
 	ice->gpio.set_dir = snd_vt1724_set_gpio_dir;
+	ice->gpio.get_dir = snd_vt1724_get_gpio_dir;
 	ice->gpio.set_data = snd_vt1724_set_gpio_data;
 	ice->gpio.get_data = snd_vt1724_get_gpio_data;
 	ice->card = card;
-- 
1.5.6.3
