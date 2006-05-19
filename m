From: jayakumar.alsa@gmail.com
Subject: [PATCH 2.6.17-rc4 1/1] ALSA: Single variables for cs5535audio
Date: Fri, 19 May 2006 12:38:06 +0800
Message-ID: <200605190438.k4J4c6S2003895@localhost.localdomain>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi, Jaroslav, ALSA folk,

As per Takashi's feedback, this is a cleanup to make cs5535audio be
single device per system. The diff is against 2.6.17-rc4 with
Takashi's patch adding the module_params for index, id and enable. 

Please let me know if it looks okay and if you have any feedback 
or suggestions.

Thanks,
Jaya Kumar

Signed-off-by: Jaya Kumar <jayakumar.alsa@gmail.com>

---

 cs5535audio.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

---

diff -X linux-2.6.17-rc4/Documentation/dontdiff -X excludevid_acpi -uprN linux-2.6.17-rc4-vanilla/sound/pci/cs5535audio/cs5535audio.c linux-2.6.17-rc4/sound/pci/cs5535audio/cs5535audio.c
--- linux-2.6.17-rc4-vanilla/sound/pci/cs5535audio/cs5535audio.c	2006-05-19 11:55:47.000000000 +0800
+++ linux-2.6.17-rc4/sound/pci/cs5535audio/cs5535audio.c	2006-05-19 12:16:13.000000000 +0800
@@ -56,16 +56,17 @@ static struct ac97_quirk ac97_quirks[] _
 	{}
 };
 
-static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
-static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
-static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
+static int index = SNDRV_DEFAULT_IDX1;
+static char *id = SNDRV_DEFAULT_STR1;
+/* for backward compatibility */
+static int enable; 
 
-module_param_array(index, int, NULL, 0444);
+module_param(index, int, 0444);
 MODULE_PARM_DESC(index, "Index value for " DRIVER_NAME);
-module_param_array(id, charp, NULL, 0444);
+module_param(id, charp, 0444);
 MODULE_PARM_DESC(id, "ID string for " DRIVER_NAME);
-module_param_array(enable, bool, NULL, 0444);
-MODULE_PARM_DESC(enable, "Enable " DRIVER_NAME);
+module_param(enable, bool, 0444);
+MODULE_PARM_DESC(enable, "Enable for " DRIVER_NAME);
 
 static struct pci_device_id snd_cs5535audio_ids[] __devinitdata = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_AUDIO) },
@@ -357,12 +358,8 @@ static int __devinit snd_cs5535audio_pro
 
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
-	if (!enable[dev]) {
-		dev++;
-		return -ENOENT;
-	}
 
-	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
+	card = snd_card_new(index, id, THIS_MODULE, 0);
 	if (card == NULL)
 		return -ENOMEM;
 


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
