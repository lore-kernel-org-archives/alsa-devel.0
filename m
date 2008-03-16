From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: PATCH - some fixes and cleanup for ICE1724 cards
Date: Sun, 16 Mar 2008 13:22:17 +0100
Message-ID: <47DD10F9.5080907@insite.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090703050905020601050103"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 21412246A8
	for <alsa-devel@alsa-project.org>; Sun, 16 Mar 2008 13:22:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090703050905020601050103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi,

here is a small patch with minor fixes and cleanup.


* removing the hack with NON_AKM ak4xxx type
* support for card-specific flags in ak4114_stats
* definition of the flags for corresponding cards

Signed-by: Pavel Hofman <dustin@seznam.cz>


Thanks,

Pavel

--------------090703050905020601050103
Content-Type: text/x-patch;
 name="patch-fixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-fixes.diff"

diff -r 52ca5f7c772e i2c/other/ak4114.c
--- a/i2c/other/ak4114.c	Fri Mar 14 17:17:09 2008 +0100
+++ b/i2c/other/ak4114.c	Sun Mar 16 13:01:29 2008 +0100
@@ -612,7 +612,7 @@ static void ak4114_stats(struct work_str
 	struct ak4114 *chip = container_of(work, struct ak4114, work.work);
 
 	if (!chip->init)
-		snd_ak4114_check_rate_and_errors(chip, 0);
+		snd_ak4114_check_rate_and_errors(chip, chip->check_flags);
 
 	schedule_delayed_work(&chip->work, HZ / 10);
 }
diff -r 52ca5f7c772e i2c/other/ak4xxx-adda.c
--- a/i2c/other/ak4xxx-adda.c	Fri Mar 14 17:17:09 2008 +0100
+++ b/i2c/other/ak4xxx-adda.c	Sun Mar 16 13:01:29 2008 +0100
@@ -70,7 +70,8 @@ static void ak4524_reset(struct snd_akm4
 }
 
 /* reset procedure for AK4355 and AK4358 */
-static void ak4355_reset(struct snd_akm4xxx *ak, int state)
+static void ak435X_reset(struct snd_akm4xxx *ak, int state,
+		unsigned char total_regs)
 {
 	unsigned char reg;
 
@@ -78,7 +79,7 @@ static void ak4355_reset(struct snd_akm4
 		snd_akm4xxx_write(ak, 0, 0x01, 0x02); /* reset and soft-mute */
 		return;
 	}
-	for (reg = 0x00; reg < 0x0b; reg++)
+	for (reg = 0x00; reg < total_regs; reg++)
 		if (reg != 0x01)
 			snd_akm4xxx_write(ak, 0, reg,
 					  snd_akm4xxx_get(ak, 0, reg));
@@ -118,8 +119,10 @@ void snd_akm4xxx_reset(struct snd_akm4xx
 		/* FIXME: needed for ak4529? */
 		break;
 	case SND_AK4355:
+		ak435X_reset(ak, state, 0x0b);
+		break;
 	case SND_AK4358:
-		ak4355_reset(ak, state);
+		ak435X_reset(ak, state, 0x10);
 		break;
 	case SND_AK4381:
 		ak4381_reset(ak, state);
@@ -292,11 +295,6 @@ void snd_akm4xxx_init(struct snd_akm4xxx
 	case SND_AK5365:
 		/* FIXME: any init sequence? */
 		return;
-	case NON_AKM:
-		/* fake value for non-akm codecs using akm infrastructure
-		 * (e.g. of ice1724) - certainly FIXME
-		 */
-		return;
 	default:
 		snd_BUG();
 		return;
@@ -374,6 +372,8 @@ static int put_ak_reg(struct snd_kcontro
 		nval = mask - nval;
 	if (AK_GET_NEEDSMSB(kcontrol->private_value))
 		nval |= 0x80;
+	/* printk(KERN_DEBUG "DEBUG - AK writing reg: chip %x addr %x,
+	   nval %x\n", chip, addr, nval); */
 	snd_akm4xxx_write(ak, chip, addr, nval);
 	return 1;
 }
diff -r 52ca5f7c772e include/ak4114.h
--- a/include/ak4114.h	Fri Mar 14 17:17:09 2008 +0100
+++ b/include/ak4114.h	Sun Mar 16 13:01:29 2008 +0100
@@ -182,6 +182,7 @@ struct ak4114 {
 	unsigned char rcs0;
 	unsigned char rcs1;
 	struct delayed_work work;
+	unsigned int check_flags;
 	void *change_callback_private;
 	void (*change_callback)(struct ak4114 *ak4114, unsigned char c0, unsigned char c1);
 };
diff -r 52ca5f7c772e include/ak4xxx-adda.h
--- a/include/ak4xxx-adda.h	Fri Mar 14 17:17:09 2008 +0100
+++ b/include/ak4xxx-adda.h	Sun Mar 16 13:01:29 2008 +0100
@@ -68,7 +68,7 @@ struct snd_akm4xxx {
 	enum {
 		SND_AK4524, SND_AK4528, SND_AK4529,
 		SND_AK4355, SND_AK4358, SND_AK4381,
-		SND_AK5365, NON_AKM
+		SND_AK5365
 	} type;
 
 	/* (array) information of combined codecs */
diff -r 52ca5f7c772e pci/ice1712/prodigy192.c
--- a/pci/ice1712/prodigy192.c	Fri Mar 14 17:17:09 2008 +0100
+++ b/pci/ice1712/prodigy192.c	Sun Mar 16 13:01:29 2008 +0100
@@ -319,12 +319,11 @@ static int stac9460_mic_sw_put(struct sn
 /*
  * Handler for setting correct codec rate - called when rate change is detected
  */
-static void stac9460_set_rate_val(struct snd_akm4xxx *ak, unsigned int rate)
+static void stac9460_set_rate_val(struct snd_ice1712 *ice, unsigned int rate)
 {
 	unsigned char old, new;
 	int idx;
 	unsigned char changed[7];
-	struct snd_ice1712 *ice = ak->private_data[0];
 	struct prodigy192_spec *spec = ice->spec;
 
 	if (rate == 0)  /* no hint - S/PDIF input is master, simply return */
@@ -357,16 +356,6 @@ static void stac9460_set_rate_val(struct
 	mutex_unlock(&spec->mute_mutex);
 }
 
-/* using akm infrastructure for setting rate of the codec */
-static struct snd_akm4xxx akmlike_stac9460 __devinitdata = {
-	.type = NON_AKM,	/* special value */
-	.num_adcs = 6,		/* not used in any way, just for completeness */
-	.num_dacs = 2,
-	.ops = {
-		.set_rate_val = stac9460_set_rate_val
-	}
-};
-
 
 static const DECLARE_TLV_DB_SCALE(db_scale_dac, -19125, 75, 0);
 static const DECLARE_TLV_DB_SCALE(db_scale_adc, 0, 150, 0);
@@ -642,12 +631,19 @@ static int prodigy192_ak4114_init(struct
 		0x41, 0x02, 0x2c, 0x00, 0x00
 	};
 	struct prodigy192_spec *spec = ice->spec;
-
-	return snd_ak4114_create(ice->card,
+	int err;
+
+	err = snd_ak4114_create(ice->card,
 				 prodigy192_ak4114_read,
 				 prodigy192_ak4114_write,
 				 ak4114_init_vals, ak4114_init_txcsb,
 				 ice, &spec->ak4114);
+	if (err < 0)
+		return err;
+	/* AK4114 in Prodigy192 cannot detect external rate correctly.
+	 * No reason to stop capture stream due to incorrect checks */
+	spec->ak4114->check_flags = AK4114_CHECK_NO_RATE;
+	return 0;
 }
 
 static void stac9460_proc_regs_read(struct snd_info_entry *entry,
@@ -743,7 +739,6 @@ static int __devinit prodigy192_init(str
 	};
 	const unsigned short *p;
 	int err = 0;
-	struct snd_akm4xxx *ak;
 	struct prodigy192_spec *spec;
 
 	/* prodigy 192 */
@@ -761,15 +756,7 @@ static int __devinit prodigy192_init(str
 	p = stac_inits_prodigy;
 	for (; *p != (unsigned short)-1; p += 2)
 		stac9460_put(ice, p[0], p[1]);
-	/* reusing the akm codecs infrastructure,
-	 * for setting rate on stac9460 */
-	ak = ice->akm = kmalloc(sizeof(struct snd_akm4xxx), GFP_KERNEL);
-	if (!ak)
-		return -ENOMEM;
-	ice->akm_codecs = 1;
-	err = snd_ice1712_akm4xxx_init(ak, &akmlike_stac9460, NULL, ice);
-	if (err < 0)
-		return err;
+	ice->gpio.set_pro_rate = stac9460_set_rate_val;
 
 	/* MI/ODI/O add on card with AK4114 */
 	if (prodigy192_miodio_exists(ice)) {
diff -r 52ca5f7c772e pci/ice1712/revo.c
--- a/pci/ice1712/revo.c	Fri Mar 14 17:17:09 2008 +0100
+++ b/pci/ice1712/revo.c	Sun Mar 16 13:01:29 2008 +0100
@@ -488,6 +488,10 @@ static int __devinit ap192_ak4114_init(s
 				 ap192_ak4114_write,
 				 ak4114_init_vals, ak4114_init_txcsb,
 				 ice, &ak);
+	/* AK4114 in Revo cannot detect external rate correctly.
+	 * No reason to stop capture stream due to incorrect checks */
+	ak->check_flags = AK4114_CHECK_NO_RATE;
+
 	return 0; /* error ignored; it's no fatal error */
 }
 

--------------090703050905020601050103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------090703050905020601050103--
