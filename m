From: Christoph Haderer <chris_web@gmx.at>
Subject: [PATCH] aureon.c - adc mux, master vol
Date: Sat, 03 Jul 2004 17:46:24 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40E6D4D0.6000206@gmx.at>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050505090305050507090701"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050505090305050507090701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch fixes a problem in adc_mux_put (without these
changes, wrong values a written to the right input mux);
it also reverts the changes of dac_vol_get and dac_vol_put which where
introduced in revision 1.11, because in the current version changing the
Master Volume control affects only DAC1 volume (IMHO WM_DAC_MASTER_ATTEN
is the right location - not WM_DAC_ATTEN).

Regards,
Christoph Haderer


--------------050505090305050507090701
Content-Type: text/plain;
 name="aureon.c-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aureon.c-patch"

--- aureon.c.old	2004-07-03 14:13:05.000000000 +0200
+++ aureon.c	2004-07-03 17:18:40.000000000 +0200
@@ -227,7 +227,10 @@
 	unsigned short vol;
 
 	down(&ice->gpio_mutex);
-	idx  = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id) + WM_DAC_ATTEN;
+	if (kcontrol->private_value)
+		idx = WM_DAC_MASTER_ATTEN;
+	else
+		idx  = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id) + WM_DAC_ATTEN;
 	vol = wm_get(ice, idx) & 0x7f;
 	if (vol <= 0x1a)
 		ucontrol->value.integer.value[0] = 0;
@@ -245,7 +248,10 @@
 	int change;
 
 	snd_ice1712_save_gpio_status(ice);
-	idx  = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id) + WM_DAC_ATTEN;
+	if (kcontrol->private_value)
+		idx = WM_DAC_MASTER_ATTEN;
+	else
+		idx  = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id) + WM_DAC_ATTEN;
 	nvol = ucontrol->value.integer.value[0] + 0x1a;
 	ovol = wm_get(ice, idx) & 0x7f;
 	change = (ovol != nvol);
@@ -374,8 +380,7 @@
 
 	down(&ice->gpio_mutex);
 	val = wm_get(ice, WM_ADC_MUX);
-	ucontrol->value.integer.value[0] = val & 7;
-	ucontrol->value.integer.value[1] = (val >> 4) & 7;
+	ucontrol->value.integer.value = val & 7;
 	up(&ice->gpio_mutex);
 	return 0;
 }
@@ -389,8 +394,8 @@
 	snd_ice1712_save_gpio_status(ice);
 	oval = wm_get(ice, WM_ADC_MUX);
 	nval = oval & ~0x77;
-	nval |= ucontrol->value.integer.value[0] & 7;
-	nval |= (ucontrol->value.integer.value[1] & 7) << 4;
+	nval |= ucontrol->value.integer.value & 7;
+	nval |= (ucontrol->value.integer.value & 7) << 4;
 	change = (oval != nval);
 	if (change)
 		wm_put(ice, WM_ADC_MUX, nval);

--------------050505090305050507090701--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
