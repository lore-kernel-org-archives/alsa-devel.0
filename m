From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [Alsa-user] ALSA Newbie - Getting Ensoniq
	SoundscapeVivo to work?
Date: Sun, 29 Apr 2007 00:32:23 +0200
Message-ID: <4633CB77.3050001@gmail.com>
References: <d382e1990704272206y9712a84x1e07d07eda58fb18@mail.gmail.com>	
	<463319CA.4040309@gmail.com>
	<d382e1990704280856j533b89d4wc8ee45d949704aa6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070108030907010504030800"
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <d382e1990704280856j533b89d4wc8ee45d949704aa6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Cody Jung <funkycat32@gmail.com>
Cc: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070108030907010504030800
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 04/28/2007 05:56 PM, Cody Jung wrote:

> There was a Vendor Id (ENS4081) and two Logical device Ids (ENS1011 and
> ENS2020).

Okay, that's a VIVO90. snd-sscape does not work for this card, and not just 
as a matter of a missing PnP ID. I suppose PnP Soundscapes exist for which 
the driver is correct but at least for the VIVO90 it fails the detect, tries 
to talk to the codec at a completely wrong address, and generally seems to 
not be applicable.

Attached is a minimal driver for the VIVO90. It only drives the AD1845 codec 
but chances are fairly good that's actually all you care about. Hardware 
(firmware rather) midi is what makes the Soundscape better/nicer than most 
but it's also the hard (undocumented) part and I haven't concerned myself 
with it for now.

The msleep(500) in there is not nice, but the card needs a delay after 
activation  until the codec is available and while I did look, I haven't 
found what to poll yet (it's not interrupting). The 500 ms hasn't failed to 
load for me yet, but it's not hugely roomy; 400 ms hasn't _succeeded_ for me 
yet so if it won't load for you please increase the 500 to 1000 as a first try.

This is not being submitted. It's only a very minimal thing and since Hannu 
said that the VIVO and the VIVO90 are in fact different models (mine does 
advertise itself as a "ENSONIQ SoundscapeVIVO" without the 90 in its PNP 
string) I'm not even sure if this is VIVO90 specific. The PNP ID probably 
is. It's only being posted in the hope that it'll work for your needs.

It'll probably grow into a real driver some day, but not soon; given that 
it's all very undocumented, getting more to work might be fairly painful. 
The old/other driver will help to some degree but I'm not sure to which.

The patch was generated against 2.6.21 and should apply without trouble to 
most recent kernels. Loading works just as "modprobe snd-vivo", no params.

Rene.


--------------070108030907010504030800
Content-Type: text/plain;
 name="vivo.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vivo.diff"

commit d67e8af62cf79955fd0c4cb2e54d80be9c19629f
Author: Rene Herman <rene.herman@gmail.com>
Date:   Sat Apr 28 23:49:43 2007 +0200

    [ALSA] snd-vivo

diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index 4e3a972..7338c37 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -388,6 +388,18 @@ config SND_SSCAPE
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-sscape.
 
+config SND_VIVO
+	tristate "Ensoniq Soundscape VIVO(90) Driver"
+	depends on SND
+	select SND_MPU401_UART
+	select SND_CS4231_LIB
+	help
+	  Say Y here to include support for Ensoniq Soundscape VIVO(90)
+	  soundcards.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-vivo.
+
 config SND_WAVEFRONT
 	tristate "Turtle Beach Maui,Tropez,Tropez+ (Wavefront)"
 	depends on SND
diff --git a/sound/isa/Makefile b/sound/isa/Makefile
index bb317cc..8f246af 100644
--- a/sound/isa/Makefile
+++ b/sound/isa/Makefile
@@ -12,6 +12,7 @@ snd-es18xx-objs := es18xx.o
 snd-opl3sa2-objs := opl3sa2.o
 snd-sgalaxy-objs := sgalaxy.o
 snd-sscape-objs := sscape.o
+snd-vivo-objs := vivo.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_ADLIB) += snd-adlib.o
@@ -23,6 +24,7 @@ obj-$(CONFIG_SND_ES18XX) += snd-es18xx.o
 obj-$(CONFIG_SND_OPL3SA2) += snd-opl3sa2.o
 obj-$(CONFIG_SND_SGALAXY) += snd-sgalaxy.o
 obj-$(CONFIG_SND_SSCAPE) += snd-sscape.o
+obj-$(CONFIG_SND_VIVO) += snd-vivo.o
 
 obj-$(CONFIG_SND) += ad1816a/ ad1848/ cs423x/ es1688/ gus/ opti9xx/ \
 		     sb/ wavefront/
diff --git a/sound/isa/vivo.c b/sound/isa/vivo.c
new file mode 100644
index 0000000..fd2c774
--- /dev/null
+++ b/sound/isa/vivo.c
@@ -0,0 +1,148 @@
+/*
+ * Ensoniq Soundscape VIVO(90) Driver
+ */
+
+#include <sound/driver.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pnp.h>
+#include <linux/delay.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/mpu401.h>
+#include <sound/cs4231.h>
+
+#define CRD_NAME "Ensoniq Soundscape VIVO(90)"
+#define DRV_NAME "VIVO"
+#define DEV_NAME "vivo"
+
+MODULE_DESCRIPTION(CRD_NAME);
+MODULE_AUTHOR("Rene Herman");
+MODULE_LICENSE("GPL");
+
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
+static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;
+
+module_param_array(index, int, NULL, 0444);
+MODULE_PARM_DESC(index, "Index value for " CRD_NAME " soundcard");
+module_param_array(id, charp, NULL, 0444);
+MODULE_PARM_DESC(id, "ID string for " CRD_NAME " soundcard");
+module_param_array(enable, bool, NULL, 0444);
+MODULE_PARM_DESC(enable, "Enable " CRD_NAME " soundcard");
+
+static struct pnp_card_device_id snd_vivo_pnpids[] = {
+	{ .id = "ENS4081", .devs = { { "ENS1011" } } },
+	{ .id = "" }
+};
+
+MODULE_DEVICE_TABLE(pnp_card, snd_vivo_pnpids);
+
+static int snd_vivo_error __devinitdata = -ENODEV;
+
+static int __devinit snd_vivo_probe(struct pnp_card_link *pcard,
+				    const struct pnp_card_device_id *pid)
+{
+	static int card_num;
+
+	struct pnp_dev	  *pdev;
+	struct snd_card	  *card;
+	struct snd_cs4231 *chip;
+
+	int num, error;
+
+	if (card_num == SNDRV_CARDS)
+		return -ENODEV;
+
+	num = card_num++;
+	if (!enable[num])
+		return -ENODEV;
+
+	pdev = pnp_request_card_device(pcard, pid->devs[0].id, NULL);
+	if (!pdev || pnp_activate_dev(pdev) < 0)
+		return -ENODEV;
+
+	card = snd_card_new(index[num], id[num], THIS_MODULE, 0);
+	if (!card)
+		return -EINVAL;
+
+	snd_card_set_dev(card, &pdev->dev);
+
+	strcpy(card->driver, DRV_NAME);
+	strcpy(card->shortname, DRV_NAME);
+	strcpy(card->longname, CRD_NAME);
+
+	error = snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
+				    pnp_port_start(pdev, 0), 0,
+				    pnp_irq(pdev, 1), 0, NULL);
+	if (error < 0)
+		goto out;
+
+	msleep(500);
+
+	error = snd_cs4231_create(card, pnp_port_start(pdev, 1) + 4, -1,
+				  pnp_irq(pdev, 0), pnp_dma(pdev, 0),
+				  pnp_dma(pdev, 1), CS4231_HW_DETECT,
+				  0, &chip);
+	if (error < 0)
+		goto out;
+
+	error = snd_cs4231_pcm(chip, 0, NULL);
+	if (error < 0)
+		goto out;
+
+	error = snd_cs4231_mixer(chip);
+	if (error < 0)
+		goto out;
+
+	error = snd_cs4231_timer(chip, 0, NULL);
+	if (error < 0)
+		goto out;
+
+	error = snd_card_register(card);
+	if (error < 0)
+		goto out;
+
+	pnp_set_card_drvdata(pcard, card);
+	return (snd_vivo_error = 0);
+
+out:	snd_card_free(card);
+	return error;
+}
+
+static void __devexit snd_vivo_remove(struct pnp_card_link *pcard)
+{
+	snd_card_free(pnp_get_card_drvdata(pcard));
+	pnp_set_card_drvdata(pcard, NULL);
+}
+
+static struct pnp_card_driver snd_vivo_driver = {
+	.flags		= PNP_DRIVER_RES_DISABLE,
+	.name		= DEV_NAME,
+	.id_table	= snd_vivo_pnpids,
+	.probe		= snd_vivo_probe,
+	.remove		= __devexit_p(snd_vivo_remove)
+};
+
+static int __init alsa_card_vivo_init(void)
+{
+	int error;
+
+	error = pnp_register_card_driver(&snd_vivo_driver);
+	if (error < 0)
+		goto out;
+
+	error = snd_vivo_error;
+	if (error < 0)
+		pnp_unregister_card_driver(&snd_vivo_driver);
+
+out:	return error;
+}
+
+static void __exit alsa_card_vivo_exit(void)
+{
+	pnp_unregister_card_driver(&snd_vivo_driver);
+}
+
+module_init(alsa_card_vivo_init);
+module_exit(alsa_card_vivo_exit);

--------------070108030907010504030800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070108030907010504030800--
