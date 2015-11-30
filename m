From: Pavel Machek <pavel@ucw.cz>
Subject: multi-card support for arizona-core
Date: Mon, 30 Nov 2015 12:37:17 +0100
Message-ID: <20151130113717.GB32172@amd>
References: <20150914115439.GA29646@amd> <20150914115255.GE11200@ck-lbox>
 <20151012090045.GA7448@amd> <20151012113702.GC8805@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B451261560
 for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2015 12:37:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151012113702.GC8805@ck-lbox>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi!

Add support for than one arizona. We introduce codec_num and fill it
based on device tree. If there's better way, let me know. (For v4.2,
but I believe nothing changed there. And yes, I'd need to document the
dt binding. Will do if the rest of patch is ok.)

Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index a72ddb2..4f9dbd8 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -755,7 +755,15 @@ static int arizona_of_get_core_pdata(struct arizona *arizona)
 	int ret, i;
 	int count = 0;
 
+	ret = of_property_read_u32(arizona->dev->of_node,
+				   "wlf,codec-number", &arizona->pdata.codec_num);
+	if (ret < 0) {
+		dev_info(arizona->dev, "No codec-number property in DT => single-codec mode\n");
+		arizona->pdata.codec_num = -1;
+	} else {
+		dev_info(arizona->dev, "codec-number from DT: %d\n", arizona->pdata.codec_num);
+	}
 
 	ret = of_property_read_u32_array(arizona->dev->of_node,
 					 "wlf,gpio-defaults",
 					 arizona->pdata.gpio_defaults,
@@ -925,7 +952,7 @@ int arizona_dev_init(struct arizona *arizona)
 	/* Mark DCVDD as external, LDO1 driver will clear if internal */
 	arizona->external_dcvdd = true;
 
-	ret = mfd_add_devices(arizona->dev, -1, early_devs,
+	ret = mfd_add_devices(arizona->dev, arizona->pdata.codec_num, early_devs,
 			      ARRAY_SIZE(early_devs), NULL, 0, NULL);
 	if (ret != 0) {
 		dev_err(dev, "Failed to add early children: %d\n", ret);
@@ -1259,9 +1286,12 @@ int arizona_dev_init(struct arizona *arizona)
 	arizona_request_irq(arizona, ARIZONA_IRQ_UNDERCLOCKED, "Underclocked",
 			    arizona_underclocked, arizona);
 
+	// FIXME: multiple codec handling only added for WM5102
 	switch (arizona->type) {
 	case WM5102:
-		ret = mfd_add_devices(arizona->dev, -1, wm5102_devs,
+		printk("arizona: wm5102, working with device %d\n", arizona->pdata.codec_num);
+		
+		ret = mfd_add_devices(arizona->dev, arizona->pdata.codec_num, wm5102_devs,
 				      ARRAY_SIZE(wm5102_devs), NULL, 0, NULL);
 		break;
 	case WM5110:
diff --git a/include/linux/mfd/arizona/pdata.h b/include/linux/mfd/arizona/pdata.h
index 43db4fa..b36a750 100644
--- a/include/linux/mfd/arizona/pdata.h
+++ b/include/linux/mfd/arizona/pdata.h
@@ -75,6 +75,8 @@ struct arizona_micd_range {
 };
 
 struct arizona_pdata {
+	int codec_num;	// -1: n/a (=> single codec only) ; 1 or 2: codec #1 or #2 (=> two codecs)
+
 	int reset;      /** GPIO controlling /RESET, if any */
 	int ldoena;     /** GPIO controlling LODENA, if any */
 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
