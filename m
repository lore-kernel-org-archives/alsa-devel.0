From: Eliot Blennerhassett <linux@audioscience.com>
Subject: [PATCH 5/5] asihpi: add hwdep (experimental)
Date: Thu, 06 Mar 2008 14:51:18 +1300
Message-ID: <200803061451.18758.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 24021103895
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 02:48:06 +0100 (CET)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JXA00CSUCYZQB00@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 06 Mar 2008 14:48:04 +1300 (NZDT)
Content-disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add hpi ioctl via hwdep (experimental, disabled by default).
Adjust sampleclock control to use new hpi apis. 

Signed-off-by: Eliot Blennerhassett <linux@audioscience.com
---
diff -r 6def4892d3f5 pci/Kconfig
--- a/pci/Kconfig	Mon Mar 03 11:05:48 2008 +0100
+++ b/pci/Kconfig	Sat Feb 23 20:24:59 2008 +1300
@@ -17,6 +17,7 @@ config SND_ASIHPI
 	depends on SND && X86
 	select FW_LOADER
 	select SND_PCM
+	select SND_HWDEP
 	help
 	  Say 'Y' or 'M' to include support for AudioScience ASIxxxx soundcards.
 
diff -r 6def4892d3f5 pci/asihpi/asihpi.c
--- a/pci/asihpi/asihpi.c	Mon Mar 03 11:05:48 2008 +0100
+++ b/pci/asihpi/asihpi.c	Wed Mar 05 21:59:31 2008 +1300
@@ -23,6 +23,9 @@
  */
 /* >0: print Hw params, timer vars. >1: print stream write/copy sizes  */
 #define REALLY_VERBOSE_LOGGING 0
+
+/* Experimental HPI hwdep interface */
+#define EXPERIMENTAL_HWDEP 0
 
 #if REALLY_VERBOSE_LOGGING
 #define VPRINTK1 printk
@@ -66,19 +69,28 @@
 #include <sound/info.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
+#include <sound/hwdep.h>
 
 #include "hpi.h"
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
-
-module_param_array(index, int, NULL, 0444);
+static int enable_hpi_hwdep;
+
+module_param_array(index, int, NULL, S_IRUGO);
 MODULE_PARM_DESC(index, "ALSA Index value for AudioScience soundcard.");
-module_param_array(id, charp, NULL, 0444);
+
+module_param_array(id, charp, NULL, S_IRUGO);
 MODULE_PARM_DESC(id, "ALSA ID string for AudioScience soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+
+module_param_array(enable, bool, NULL, S_IRUGO);
 MODULE_PARM_DESC(enable, "ALSA Enable AudioScience soundcard.");
+
+module_param(enable_hpi_hwdep, bool, S_IRUGO|S_IWUSR);
+MODULE_PARM_DESC(enable_hpi_hwdep,
+		"ALSA Enable HPI hwdep for AudioScience soundcard "
+		"(experimental)");
 
 /* used by hpimod.c, stop sparse from complaining */
 int snd_asihpi_bind(struct hpi_adapter *hpi_card);
@@ -114,6 +126,7 @@ struct clk_source {
 
 struct clk_cache {
 	int count;
+	int has_local;
 	struct clk_source s[MAX_CLOCKSOURCES];
 };
 
@@ -1602,7 +1615,6 @@ static int __devinit snd_asihpi_aesebu_t
 	snd_control->info = snd_asihpi_aesebu_format_info;
 	snd_control->get = snd_asihpi_aesebu_tx_format_get;
 	snd_control->put = snd_asihpi_aesebu_tx_format_put;
-	snd_control->index = asihpi_control->wDstNodeIndex + ixb;
 
 	asihpi_ctl_name(snd_control, asihpi_control, "Format");
 
@@ -1909,9 +1921,9 @@ static int log2lin[] = {
 	  6790940,
 	  2147484, /* -60dB */
 	   679094,
-	   214748,
+	   214748, /* -80 */
 	    67909,
-	    21475,
+	    21475, /* -100 */
 	     6791,
 	     2147,
 	      679,
@@ -2153,8 +2165,9 @@ static void __devinit snd_asihpi_cmode_n
  ------------------------------------------------------------*/
 
 static char *sampleclock_sources[MAX_CLOCKSOURCES] =
-    { "N/A", "Adapter", "AES/EBU Sync", "Word External", "Word Header",
-	  "SMPTE", "AES/EBU In1", "Auto", "Cobranet",
+    { "N/A", "Local PLL", "AES/EBU Sync", "Word External", "Word Header",
+	  "SMPTE", "AES/EBU In1", "Auto", "Network", "Invalid",
+	  "Prev Module",
 	  "AES/EBU In2", "AES/EBU In3", "AES/EBU In4", "AES/EBU In5",
 	  "AES/EBU In6", "AES/EBU In7", "AES/EBU In8"};
 
@@ -2239,7 +2252,9 @@ static void __devinit snd_asihpi_clksrc_
 	snd_control->info = snd_asihpi_clksrc_info;
 	snd_control->get = snd_asihpi_clksrc_get;
 	snd_control->put = snd_asihpi_clksrc_put;
-	asihpi_ctl_name(snd_control, asihpi_control, "ClockSource");
+	asihpi_ctl_name(snd_control, asihpi_control, "Source");
+
+	clkcache->has_local = 0;
 
 	for (i = 0; i <= HPI_SAMPLECLOCK_SOURCE_LAST; i++) {
 		if  (HPI_ControlQuery(phSubSys, hSC,
@@ -2250,6 +2265,8 @@ static void __devinit snd_asihpi_clksrc_
 		clkcache->s[i].name = sampleclock_sources[wSource];
 		if (wSource == HPI_SAMPLECLOCK_SOURCE_AESEBU_INPUT)
 			hasAesIn = 1;
+		if (wSource == HPI_SAMPLECLOCK_SOURCE_LOCAL)
+			clkcache->has_local = 1;
 	}
 	if (hasAesIn)
 		/* already will have picked up index 0 above */
@@ -2271,7 +2288,7 @@ static void __devinit snd_asihpi_clksrc_
 /*------------------------------------------------------------
    Clkrate controls
  ------------------------------------------------------------*/
-static int snd_asihpi_clkrate_info(struct snd_kcontrol *kcontrol,
+static int snd_asihpi_clklocal_info(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
@@ -2283,18 +2300,18 @@ static int snd_asihpi_clkrate_info(struc
 	return 0;
 }
 
-static int snd_asihpi_clkrate_get(struct snd_kcontrol *kcontrol,
+static int snd_asihpi_clklocal_get(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
 	u32 hControl = kcontrol->private_value;
 	u32 dwRate;
 
-	HPI_SampleClock_GetSampleRate(phSubSys, hControl, &dwRate);
+	HPI_SampleClock_GetLocalRate(phSubSys, hControl, &dwRate);
 	ucontrol->value.integer.value[0] = dwRate;
 	return 0;
 }
 
-static int snd_asihpi_clkrate_put(struct snd_kcontrol *kcontrol,
+static int snd_asihpi_clklocal_put(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
 	int change;
@@ -2304,21 +2321,55 @@ static int snd_asihpi_clkrate_put(struct
 	   asihpi->mixer_clkrate[addr][1] != right;
 	 */
 	change = 1;
-	HPI_SampleClock_SetSampleRate(phSubSys, hControl,
+	HPI_SampleClock_SetLocalRate(phSubSys, hControl,
 				      ucontrol->value.integer.value[0]);
 	return change;
 }
 
+static void __devinit snd_asihpi_clklocal_new(
+					struct hpi_control *asihpi_control,
+					struct snd_kcontrol_new *snd_control)
+{
+	snd_control->info = snd_asihpi_clklocal_info;
+	snd_control->get = snd_asihpi_clklocal_get;
+	snd_control->put = snd_asihpi_clklocal_put;
+
+	asihpi_ctl_name(snd_control, asihpi_control, "LocalRate");
+}
+
+static int snd_asihpi_clkrate_info(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 8000;
+	uinfo->value.integer.max = 192000;
+	uinfo->value.integer.step = 100;
+
+	return 0;
+}
+
+static int snd_asihpi_clkrate_get(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	u32 hControl = kcontrol->private_value;
+	u32 dwRate;
+
+	HPI_SampleClock_GetSampleRate(phSubSys, hControl, &dwRate);
+	ucontrol->value.integer.value[0] = dwRate;
+	return 0;
+}
+
 static void __devinit snd_asihpi_clkrate_new(struct hpi_control 
*asihpi_control,
 					  struct snd_kcontrol_new *snd_control)
 {
 	snd_control->info = snd_asihpi_clkrate_info;
 	snd_control->get = snd_asihpi_clkrate_get;
-	snd_control->put = snd_asihpi_clkrate_put;
+	snd_control->access =
+	    SNDRV_CTL_ELEM_ACCESS_VOLATILE | SNDRV_CTL_ELEM_ACCESS_READ;
 
 	asihpi_ctl_name(snd_control, asihpi_control, "Rate");
 }
-
 /*------------------------------------------------------------
    Mixer
  ------------------------------------------------------------*/
@@ -2404,6 +2455,14 @@ static int __devinit snd_card_asihpi_mix
 				return err;
 			snd_asihpi_clkrate_new(&asihpi_control,
 					       &snd_control);
+			err = snd_ctl_add(card,
+					snd_ctl_new1(&snd_control, asihpi));
+			if (err < 0)
+				return err;
+			if (asihpi->cc.has_local)
+				snd_asihpi_clklocal_new(&asihpi_control,
+					       &snd_control);
+
 			break;
 		case HPI_CONTROL_CONNECTION:	/* ignore these */
 			continue;
@@ -2510,6 +2569,55 @@ static void __devinit snd_asihpi_proc_in
 }
 
 /*------------------------------------------------------------
+   HWDEP
+ ------------------------------------------------------------*/
+
+static int snd_asihpi_hpi_open(struct snd_hwdep * hw, struct file *file)
+{
+	return 0;
+}
+
+static int snd_asihpi_hpi_release(struct snd_hwdep * hw, struct file *file)
+{
+	return 0;
+}
+
+long asihpi_hpi_ioctl(struct file *file,
+	  unsigned int cmd, unsigned long arg);
+
+static int snd_asihpi_hpi_ioctl(struct snd_hwdep * hw, struct file *file,
+				unsigned int cmd, unsigned long arg)
+{
+	return asihpi_hpi_ioctl(file, cmd, arg);
+}
+
+
+/* results in /dev/snd/hwC#D0 file for each card with index #
+   also /proc/asound/hwdep will contain '#-00: asihpi (HPI) for each card'
+*/
+int __devinit snd_asihpi_hpi_new(struct snd_card_asihpi *asihpi, int device,
+				struct snd_hwdep ** rhwdep)
+{
+	struct snd_hwdep *hw;
+	int err;
+
+	if (rhwdep)
+		*rhwdep = NULL;
+	err = snd_hwdep_new(asihpi->card, "HPI", device, &hw);
+	if (err < 0)
+		return err;
+	strcpy(hw->name, "asihpi (HPI)");
+	hw->iface = SNDRV_HWDEP_IFACE_LAST;
+	hw->ops.open = snd_asihpi_hpi_open;
+	hw->ops.ioctl = snd_asihpi_hpi_ioctl;
+	hw->ops.release = snd_asihpi_hpi_release;
+	hw->private_data = asihpi;
+	if (rhwdep)
+		*rhwdep = hw;
+	return 0;
+}
+
+/*------------------------------------------------------------
    CARD
  ------------------------------------------------------------*/
 int __devinit snd_asihpi_bind(struct hpi_adapter *hpi_card)
@@ -2602,10 +2710,13 @@ int __devinit snd_asihpi_bind(struct hpi
 				  HPI_CONTROL_SAMPLECLOCK, &hControl);
 
 	if (!err)
-		err = HPI_SampleClock_SetSampleRate(phSubSys,
+		err = HPI_SampleClock_SetLocalRate(phSubSys,
 				hControl, adapter_fs);
 
 	snd_asihpi_proc_init(asihpi);
+
+	if (enable_hpi_hwdep)
+		snd_asihpi_hpi_new(asihpi, 0, NULL);
 
 	if (asihpi->support_mmap)
 		strcpy(card->driver, "ASIHPI-MMAP");
diff -r 6def4892d3f5 pci/asihpi/hpimod.c
--- a/pci/asihpi/hpimod.c	Mon Mar 03 11:05:48 2008 +0100
+++ b/pci/asihpi/hpimod.c	Wed Mar 05 21:59:31 2008 +1300
@@ -24,14 +24,10 @@ Linux HPI driver module
 #include "hpi.h"
 #include "hpidebug.h"
 #include "hpimsgx.h"
+
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/moduleparam.h>
-#include <linux/pci.h>
-#include <linux/device.h>
-#include <linux/interrupt.h>
-#include <linux/mutex.h>
-#include <linux/version.h>
 #include <asm/uaccess.h>
 #include <linux/stringify.h>
 
@@ -167,13 +163,13 @@ static int hpi_release(
 }
 
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2, 6, 11)
-static long hpi_ioctl(
+long asihpi_hpi_ioctl(
 	struct file *file,
 	unsigned int cmd,
 	unsigned long arg
 )
 #else
-static int hpi_ioctl(
+static int asihpi_hpi_ioctl(
 	struct inode *inode,
 	struct file *file,
 	unsigned int cmd,
@@ -225,8 +221,18 @@ static int hpi_ioctl(
 
 		/* -1=no data 0=read from user mem, 1=write to user mem */
 		int wrflag = -1;
-		int nAdapter = hm.wAdapterIndex;
+		u32 nAdapter = hm.wAdapterIndex;
 		switch (hm.wFunction) {
+		case HPI_SUBSYS_CREATE_ADAPTER:
+		case HPI_SUBSYS_DELETE_ADAPTER:
+			/* Application must not use these functions! */
+			hr.wSize = sizeof(struct hpi_response_header);
+			hr.wError = HPI_ERROR_INVALID_OPERATION;
+			hr.wFunction = hm.wFunction;
+			uncopied_bytes = copy_to_user(phr, &hr, hr.wSize);
+			if (uncopied_bytes)
+				return -EFAULT;
+			return 0;
 		case HPI_OSTREAM_WRITE:
 		case HPI_ISTREAM_READ:
 			/* Yes, sparse, this is correct. */
@@ -252,60 +258,49 @@ static int hpi_ioctl(
 			break;
 		}
 
-		if ((nAdapter >= HPI_MAX_ADAPTERS || nAdapter < 0) &&
-			(hm.wObject != HPI_OBJ_SUBSYSTEM))
-			hr.wError = HPI_ERROR_INVALID_OBJ_INDEX;
-		else {
-			if (mutex_lock_interruptible(&adapters[nAdapter].
-					mutex))
-				return -EINTR;
-
-			if (wrflag == 0) {
-				if (size > bufsize) {
-					mutex_unlock(&adapters[nAdapter].
-						mutex);
-					HPI_DEBUG_LOG(ERROR,
-						"Requested transfer of %d "
-						"bytes, max buffer size "
-						"is %d bytes.\n", size,
-						bufsize);
-					return -EINVAL;
-				}
-
-				uncopied_bytes =
-					copy_from_user(pa->pBuffer, ptr,
-					size);
-				if (uncopied_bytes)
-					HPI_DEBUG_LOG(WARNING,
-						"Missed %d of %d "
-						"bytes from user\n",
-						uncopied_bytes, size);
+		if (mutex_lock_interruptible(&adapters[nAdapter].mutex))
+			return -EINTR;
+
+		if (wrflag == 0) {
+			if (size > bufsize) {
+				mutex_unlock(&adapters[nAdapter].mutex);
+				HPI_DEBUG_LOG(ERROR,
+					"Requested transfer of %d "
+					"bytes, max buffer size "
+					"is %d bytes.\n", size, bufsize);
+				return -EINVAL;
 			}
 
-			HPI_MessageF(&hm, &hr, file);
-
-			if (wrflag == 1) {
-				if (size > bufsize) {
-					mutex_unlock(&adapters[nAdapter].
-						mutex);
-					HPI_DEBUG_LOG(ERROR,
-						"Requested transfer of %d "
-						"bytes, max buffer size is "
-						"%d bytes.\n", size, bufsize);
-					return -EINVAL;
-				}
-
-				uncopied_bytes =
-					copy_to_user(ptr, pa->pBuffer, size);
-				if (uncopied_bytes)
-					HPI_DEBUG_LOG(WARNING,
-						"Missed %d of %d "
-						"bytes to user\n",
-						uncopied_bytes, size);
+			uncopied_bytes =
+				copy_from_user(pa->pBuffer, ptr, size);
+			if (uncopied_bytes)
+				HPI_DEBUG_LOG(WARNING,
+					"Missed %d of %d "
+					"bytes from user\n",
+					uncopied_bytes, size);
+		}
+
+		HPI_MessageF(&hm, &hr, file);
+
+		if (wrflag == 1) {
+			if (size > bufsize) {
+				mutex_unlock(&adapters[nAdapter].mutex);
+				HPI_DEBUG_LOG(ERROR,
+					"Requested transfer of %d "
+					"bytes, max buffer size is "
+					"%d bytes.\n", size, bufsize);
+				return -EINVAL;
 			}
 
-			mutex_unlock(&adapters[nAdapter].mutex);
+			uncopied_bytes = copy_to_user(ptr, pa->pBuffer, size);
+			if (uncopied_bytes)
+				HPI_DEBUG_LOG(WARNING,
+					"Missed %d of %d "
+					"bytes to user\n",
+					uncopied_bytes, size);
 		}
+
+		mutex_unlock(&adapters[nAdapter].mutex);
 	}
 
 	/* on return response size must be set */
@@ -322,9 +317,9 @@ static struct file_operations hpi_fops =
 static struct file_operations hpi_fops = {
 	.owner = THIS_MODULE,
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2, 6, 11)
-	.unlocked_ioctl = hpi_ioctl,
+	.unlocked_ioctl = asihpi_hpi_ioctl,
 #else
-	.ioctl = hpi_ioctl,
+	.ioctl = asihpi_hpi_ioctl,
 #endif
 	.open = hpi_open,
 	.release = hpi_release
@@ -399,6 +394,9 @@ static int __devinit adapter_probe(
 
 	/* call CreateAdapterObject on the relevant hpi module */
 	HPI_MessageEx(&hm, &hr, HOWNER_KERNEL);
+	if (hr.wError)
+		goto err;
+
 	adapter.pBuffer = vmalloc(bufsize);
 	if (adapter.pBuffer == NULL) {
 		HPI_DEBUG_LOG(ERROR,
@@ -407,39 +405,37 @@ static int __devinit adapter_probe(
 		goto err;
 	}
 
-	if (hr.wError == 0) {
-		adapter.index = hr.u.s.wAdapterIndex;
-		adapter.type = hr.u.s.awAdapterList[adapter.index];
+	adapter.index = hr.u.s.wAdapterIndex;
+	adapter.type = hr.u.s.awAdapterList[adapter.index];
+	hm.wAdapterIndex = adapter.index;
+
+	err = HPI_AdapterOpen(NULL, adapter.index);
+	if (err)
+		goto err;
+
+	adapter.snd_card_asihpi = NULL;
+	/* WARNING can't init sem in 'adapter'
+	 * and then copy it to adapters[] ?!?!
+	 */
+	adapters[hr.u.s.wAdapterIndex] = adapter;
+	mutex_init(&adapters[adapter.index].mutex);
+#ifdef ALSA_BUILD
+	if (snd_asihpi_bind(&adapters[adapter.index])) {
+		HPI_InitMessage(&hm, HPI_OBJ_SUBSYSTEM,
+			HPI_SUBSYS_DELETE_ADAPTER);
 		hm.wAdapterIndex = adapter.index;
-
-		err = HPI_AdapterOpen(NULL, adapter.index);
-		if (err)
-			goto err;
-
-		adapter.snd_card_asihpi = NULL;
-		/* WARNING can't init sem in 'adapter'
-		 * and then copy it to adapters[] ?!?!
-		 */
-		adapters[hr.u.s.wAdapterIndex] = adapter;
-		mutex_init(&adapters[adapter.index].mutex);
-#ifdef ALSA_BUILD
-		if (snd_asihpi_bind(&adapters[adapter.index])) {
-			HPI_InitMessage(&hm, HPI_OBJ_SUBSYSTEM,
-				HPI_SUBSYS_DELETE_ADAPTER);
-			hm.wAdapterIndex = adapter.index;
-			HPI_MessageEx(&hm, &hr, HOWNER_KERNEL);
-			goto err;
-		}
-#endif
-
-		pci_set_drvdata(pci_dev, &adapters[adapter.index]);
-		adapter_count++;
-
-		printk(KERN_INFO
-			"Probe found adapter ASI%04X HPI index #%d.\n",
-			adapter.type, adapter.index);
-		return 0;
-	}
+		HPI_MessageEx(&hm, &hr, HOWNER_KERNEL);
+		goto err;
+	}
+#endif
+
+	pci_set_drvdata(pci_dev, &adapters[adapter.index]);
+	adapter_count++;
+
+	printk(KERN_INFO
+		"Probe found adapter ASI%04X HPI index #%d.\n",
+		adapter.type, adapter.index);
+	return 0;
 
 err:
 	for (idx = 0; idx < HPI_MAX_ADAPTER_MEM_SPACES; idx++) {
