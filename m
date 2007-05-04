From: Steve Longerbeam <stevel@embeddedalley.com>
Subject: Re: [PATCH] Add support for gain in softvol plugin
Date: Fri, 04 May 2007 09:27:40 -0700
Message-ID: <463B5EFC.6080801@embeddedalley.com>
References: <463A33D8.3090907@embeddedalley.com>
	<Pine.LNX.4.61.0705032121110.7861@tm8103.perex-int.cz>
	<463A6100.3070708@embeddedalley.com>
	<Pine.LNX.4.61.0705040938540.7594@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040204070504000400050007"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp103.biz.mail.mud.yahoo.com (smtp103.biz.mail.mud.yahoo.com
	[68.142.200.238]) by alsa0.perex.cz (Postfix) with SMTP id 9BFD5244A5
	for <alsa-devel@alsa-project.org>;
	Fri,  4 May 2007 18:27:43 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0705040938540.7594@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040204070504000400050007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jaroslav Kysela wrote:
> On Thu, 3 May 2007, Steve Longerbeam wrote:
>
>   
>> Jaroslav Kysela wrote:
>>     
>>> On Thu, 3 May 2007, Steve Longerbeam wrote:
>>>
>>>   
>>>       
>>>> Hi all,
>>>>
>>>> What do you think of this patch? I tested this using a stac9205 HDA codec with
>>>> all sample formats supported by softvol (s32, s16, s24, big and little
>>>> endian).
>>>>     
>>>>         
>>> I would not add extra defines to alsa.conf:
>>>
>>> +defaults.pcm.dsnoop_softvol.card defaults.pcm.card
>>> +defaults.pcm.dsnoop_softvol.device defaults.pcm.device
>>>
>>> Simply reuse pcm.dsnoop.card / device.
>>>   
>>>       
>> Hi Jaroslav,
>>
>> How do I do this exactly? Should I add:
>>
>> @args.CARD {
>>     type string
>>     default {
>>         @func refer
>>          name defaults.pcm.card
>>     
>
> Replace with: name defaults.pcm.dsnoop.card
>
> Please, resend your patch with this modification. Thanks.
>   

ok, here it is again, with CARD/DEV defaults moved out of alsa.conf and 
into dsnoop_softvol.conf.

Steve



--------------040204070504000400050007
Content-Type: text/x-patch;
 name="softvol-gain.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="softvol-gain.2.patch"

searching for changes
changeset:   2285:2d9964bee8bb
tag:         tip
user:        stevel@embeddedalley.com
date:        Fri May 04 09:22:49 2007 -0700
summary:     Add support for gain in softvol plugin.

This patch allows for gain in the softvol plugin, in addition to attenuation.
The plugin now has a "max_dB" parameter (up to 50 dB) as well as the
original "min_dB" parameter (down to -51 dB). max_dB defaults to 0 dB, so
unless max_dB is specified in a device conf, the behavior of the plugin will
be the same as before (attenuation only).

The patch also creates a new pcm device "dsnoop_softvol". It's a softvol
device with min_dB set to -30 dB and max_dB set to 40 dB. I came up
with those numbers sort of subjectively by experimenting with record
levels using a digital mic on the stac9205 codec. The softvol plugin allows
a range of -51 to +50 dB, so max_dB could be increased to 50. But
eventually samples are going to get clipped. At 40 dB I was beginning
to get clipping when recording a sample sound at a "reasonably soft"
volume. The dsnoop_softvol device uses dsnoop as its slave device, and
it contains a mixer volume control named "Capture Softvol".

HDA-Intel.conf is also modified to use dsnoop_softvol for its default capture.
So now, capture is filtered through softvol (range -30 to +40 dB) before
being passed on to dsnoop as before.

The motivation for this work is that some HDA codecs have no hardware gain
control for some paths. For instance, the stac9205 has support for digital
mics, but there is no gain control widget for this signal before it is placed
on the Azalia link (only a mute). Therefore gain can only be accomplished
via software.

Signed-off-by: Steve Longerbeam <stevel@embeddedalley.com>

diff -r ae8426a8928c -r 2d9964bee8bb src/conf/alsa.conf
--- a/src/conf/alsa.conf	Thu May 03 20:55:54 2007 +0200
+++ b/src/conf/alsa.conf	Fri May 04 09:22:49 2007 -0700
@@ -127,6 +127,7 @@ pcm.spdif iec958
 pcm.spdif iec958
 pcm.dmix cards.pcm.dmix
 pcm.dsnoop cards.pcm.dsnoop
+pcm.dsnoop_softvol cards.pcm.dsnoop_softvol
 pcm.modem cards.pcm.modem
 pcm.phoneline cards.pcm.phoneline
 
diff -r ae8426a8928c -r 2d9964bee8bb src/conf/cards/HDA-Intel.conf
--- a/src/conf/cards/HDA-Intel.conf	Thu May 03 20:55:54 2007 +0200
+++ b/src/conf/cards/HDA-Intel.conf	Fri May 04 09:22:49 2007 -0700
@@ -19,6 +19,8 @@ HDA-Intel.pcm.front.0 {
 		card $CARD
 	}
 }	
+
+<confdir:pcm/dsnoop_softvol.conf>
 
 # default with dmix+softvol & dsnoop
 HDA-Intel.pcm.default {
@@ -45,7 +47,7 @@ HDA-Intel.pcm.default {
 		type plug
 		slave.pcm {
 			@func concat
-			strings [ "dsnoop:" $CARD ]
+			strings [ "dsnoop_softvol:" $CARD ]
 		}
 	}
 }
diff -r ae8426a8928c -r 2d9964bee8bb src/conf/pcm/Makefile.am
--- a/src/conf/pcm/Makefile.am	Thu May 03 20:55:54 2007 +0200
+++ b/src/conf/pcm/Makefile.am	Fri May 04 09:22:49 2007 -0700
@@ -2,7 +2,7 @@ cfg_files = default.conf front.conf rear
 	    surround40.conf surround41.conf \
 	    surround50.conf surround51.conf \
 	    surround71.conf iec958.conf modem.conf \
-	    dmix.conf dsnoop.conf \
+	    dmix.conf dsnoop.conf dsnoop_softvol.conf \
 	    dpl.conf
 
 EXTRA_DIST = $(cfg_files)
diff -r ae8426a8928c -r 2d9964bee8bb src/conf/pcm/dsnoop_softvol.conf
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/src/conf/pcm/dsnoop_softvol.conf	Fri May 04 09:22:49 2007 -0700
@@ -0,0 +1,28 @@
+pcm.!dsnoop_softvol {
+	@args [ CARD DEV ]
+	@args.CARD {
+		type string
+		default {
+			@func refer
+			name defaults.pcm.dsnoop.card
+		}
+	}
+	@args.DEV {
+		type integer
+		default {
+			@func refer
+			name defaults.pcm.dsnoop.device
+		}
+	}
+	type softvol
+	slave.pcm {
+		@func concat
+		strings [ "dsnoop:" $CARD ]
+	}
+	control {
+		name "Capture SoftVol"
+		card $CARD
+	}
+	min_dB -30.0
+	max_dB 40.0
+}
diff -r ae8426a8928c -r 2d9964bee8bb src/pcm/pcm_softvol.c
--- a/src/pcm/pcm_softvol.c	Thu May 03 20:55:54 2007 +0200
+++ b/src/pcm/pcm_softvol.c	Fri May 04 09:22:49 2007 -0700
@@ -25,7 +25,7 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
  */
-  
+
 #include <byteswap.h>
 #include <math.h>
 #include "pcm_local.h"
@@ -46,17 +46,22 @@ typedef struct {
 	snd_ctl_t *ctl;
 	snd_ctl_elem_value_t elem;
 	unsigned int cur_vol[2];
-	unsigned int max_val;
+	unsigned int max_val;     /* max index */
+	unsigned int zero_dB_val; /* index at 0 dB */
 	double min_dB;
-	unsigned short *dB_value;
+	double max_dB;
+	unsigned int *dB_value;
 } snd_pcm_softvol_t;
 
 #define VOL_SCALE_SHIFT		16
+#define VOL_SCALE_MASK          ((1 << VOL_SCALE_SHIFT) - 1)
 
 #define PRESET_RESOLUTION	256
 #define PRESET_MIN_DB		-51.0
-
-static unsigned short preset_dB_value[PRESET_RESOLUTION] = {
+#define ZERO_DB                  0.0
+#define MAX_DB_UPPER_LIMIT      50
+
+static unsigned int preset_dB_value[PRESET_RESOLUTION] = {
 	0x00b8, 0x00bd, 0x00c1, 0x00c5, 0x00ca, 0x00cf, 0x00d4, 0x00d9,
 	0x00de, 0x00e3, 0x00e8, 0x00ed, 0x00f3, 0x00f9, 0x00fe, 0x0104,
 	0x010a, 0x0111, 0x0117, 0x011e, 0x0124, 0x012b, 0x0132, 0x0139,
@@ -96,10 +101,10 @@ typedef union {
 	int i;
 	short s[2];
 } val_t;
-static inline int MULTI_DIV_int(int a, unsigned short b, int swap)
+static inline int MULTI_DIV_32x16(int a, unsigned short b, int swap)
 {
 	val_t v, x, y;
-	v.i = swap ? (int)bswap_32(a) : a;
+	v.i = a;
 	y.i = 0;
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 	x.i = (unsigned int)v.s[0] * b;
@@ -110,14 +115,40 @@ static inline int MULTI_DIV_int(int a, u
 	y.s[1] = x.s[0];
 	y.i += (int)v.s[0] * b;
 #endif
-	return swap ? (int)bswap_32(y.i) : y.i;
-}
-
-/* (16bit x 16bit) >> 16 */
-#define MULTI_DIV_short(src, scale, swap)				  \
-(swap									  \
- ? bswap_16(((short) bswap_16(src) * (scale)) >> VOL_SCALE_SHIFT)   \
- : (((int) (src) * (scale)) >> VOL_SCALE_SHIFT))
+	return y.i;
+}
+
+static inline int MULTI_DIV_int(int a, unsigned int b, int swap)
+{
+	unsigned int gain = (b >> VOL_SCALE_SHIFT);
+	int fraction;
+	a = swap ? (int)bswap_32(a) : a;
+	fraction = MULTI_DIV_32x16(a, b & VOL_SCALE_MASK, swap);
+	if (gain) {
+		long long amp = (long long)a * gain + fraction;
+		if (amp > (int)0x7fffffff)
+			amp = (int)0x7fffffff;
+		else if (amp < (int)0x80000000)
+			amp = (int)0x80000000;
+		return swap ? (int)bswap_32((int)amp) : (int)amp;
+	}
+	return swap ? (int)bswap_32(fraction) : fraction;
+}
+
+static inline short MULTI_DIV_short(short a, unsigned int b, int swap)
+{
+	unsigned int gain = b >> VOL_SCALE_SHIFT;
+	int fraction;
+	a = swap ? (short)bswap_16(a) : a;
+	fraction = (int)(a * (b & VOL_SCALE_MASK)) >> VOL_SCALE_SHIFT;
+	if (gain) {
+		int amp = a * gain + fraction;
+		if (abs(amp) > 0x7fff)
+			amp = (a<0) ? (short)0x8000 : (short)0x7fff;
+		return swap ? (short)bswap_16((short)amp) : (short)amp;
+	}
+	return swap ? (short)bswap_16((short)fraction) : (short)fraction;
+}
 
 #endif /* DOC_HIDDEN */
 
@@ -237,8 +268,8 @@ static void softvol_convert_stereo_vol(s
 		snd_pcm_areas_silence(dst_areas, dst_offset, channels, frames,
 				      svol->sformat);
 		return;
-	} else if (svol->cur_vol[0] == svol->max_val &&
-		   svol->cur_vol[1] == svol->max_val) {
+	} else if (svol->zero_dB_val && svol->cur_vol[0] == svol->zero_dB_val &&
+		   svol->cur_vol[1] == svol->zero_dB_val) {
 		snd_pcm_areas_copy(dst_areas, dst_offset, src_areas, src_offset,
 				   channels, frames, svol->sformat);
 		return;
@@ -288,7 +319,7 @@ static void softvol_convert_mono_vol(snd
 		snd_pcm_areas_silence(dst_areas, dst_offset, channels, frames,
 				      svol->sformat);
 		return;
-	} else if (svol->cur_vol[0] == svol->max_val) {
+	} else if (svol->zero_dB_val && svol->cur_vol[0] == svol->zero_dB_val) {
 		snd_pcm_areas_copy(dst_areas, dst_offset, src_areas, src_offset,
 				   channels, frames, svol->sformat);
 		return;
@@ -539,6 +570,7 @@ static void snd_pcm_softvol_dump(snd_pcm
 	snd_output_printf(out, "Soft volume PCM\n");
 	snd_output_printf(out, "Control: %s\n", svol->elem.id.name);
 	snd_output_printf(out, "min_dB: %g\n", svol->min_dB);
+	snd_output_printf(out, "max_dB: %g\n", svol->max_dB);
 	snd_output_printf(out, "resolution: %d\n", svol->max_val + 1);
 	if (pcm->setup) {
 		snd_output_printf(out, "Its setup is:\n");
@@ -554,7 +586,7 @@ static int add_tlv_info(snd_pcm_softvol_
 	tlv[0] = SND_CTL_TLVT_DB_SCALE;
 	tlv[1] = 2 * sizeof(int);
 	tlv[2] = svol->min_dB * 100;
-	tlv[3] = -svol->min_dB * 100 / svol->max_val;
+	tlv[3] = (svol->max_dB - svol->min_dB) * 100 / svol->max_val;
 	return snd_ctl_elem_tlv_write(svol->ctl, &cinfo->id, tlv);
 }
 
@@ -567,9 +599,9 @@ static int add_user_ctl(snd_pcm_softvol_
 	if (err < 0)
 		return err;
 	add_tlv_info(svol, cinfo);
-	/* set max value as default */
+	/* set zero dB value as default */
 	for (i = 0; i < count; i++)
-		svol->elem.value.integer.value[i] = svol->max_val;
+		svol->elem.value.integer.value[i] = svol->zero_dB_val;
 	return snd_ctl_elem_write(svol->ctl, &svol->elem);
 }
 
@@ -581,7 +613,8 @@ static int add_user_ctl(snd_pcm_softvol_
  */
 static int softvol_load_control(snd_pcm_t *pcm, snd_pcm_softvol_t *svol,
 				int ctl_card, snd_ctl_elem_id_t *ctl_id,
-				int cchannels, double min_dB, int resolution)
+				int cchannels, double min_dB, double max_dB,
+				int resolution)
 {
 	char tmp_name[32];
 	snd_pcm_info_t *info;
@@ -610,7 +643,14 @@ static int softvol_load_control(snd_pcm_
 	svol->elem.id = *ctl_id;
 	svol->max_val = resolution - 1;
 	svol->min_dB = min_dB;
-
+	svol->max_dB = max_dB;
+	if (svol->max_dB == ZERO_DB)
+		svol->zero_dB_val = svol->max_val;
+	else if (svol->max_dB < 0)
+		svol->zero_dB_val = 0; /* there is no 0 dB setting */
+	else
+		svol->zero_dB_val = (min_dB / (min_dB - max_dB)) * svol->max_val;
+		
 	snd_ctl_elem_info_alloca(&cinfo);
 	snd_ctl_elem_info_set_id(cinfo, ctl_id);
 	if ((err = snd_ctl_elem_info(svol->ctl, cinfo)) < 0) {
@@ -650,24 +690,25 @@ static int softvol_load_control(snd_pcm_
 		}
 	}
 
-	if (min_dB == PRESET_MIN_DB && resolution == PRESET_RESOLUTION)
+	if (min_dB == PRESET_MIN_DB && max_dB == ZERO_DB && resolution == PRESET_RESOLUTION)
 		svol->dB_value = preset_dB_value;
 	else {
 #ifndef HAVE_SOFT_FLOAT
-		svol->dB_value = calloc(resolution, sizeof(unsigned short));
+		svol->dB_value = calloc(resolution, sizeof(unsigned int));
 		if (! svol->dB_value) {
 			SNDERR("cannot allocate dB table");
 			return -ENOMEM;
 		}
 		svol->min_dB = min_dB;
-		for (i = 1; i < svol->max_val; i++) {
-			double db = svol->min_dB - ((i - 1) * svol->min_dB) / (svol->max_val - 1);
+		svol->max_dB = max_dB;
+		for (i = 0; i <= svol->max_val; i++) {
+			double db = svol->min_dB + (i * (svol->max_dB - svol->min_dB)) / svol->max_val;
 			double v = (pow(10.0, db / 20.0) * (double)(1 << VOL_SCALE_SHIFT));
-			svol->dB_value[i] = (unsigned short)v;
-		}
-		svol->dB_value[svol->max_val] = 65535;
+			svol->dB_value[i] = (unsigned int)v;
+		}
+		svol->dB_value[svol->zero_dB_val] = 65535;
 #else
-		SNDERR("Cannot handle the given min_dB and resolution");
+		SNDERR("Cannot handle the given dB range and resolution");
 		return -EINVAL;
 #endif
 	}
@@ -698,6 +739,7 @@ static snd_pcm_ops_t snd_pcm_softvol_ops
  * \param ctl_id The control element
  * \param cchannels PCM channels
  * \param min_dB minimal dB value
+ * \param max_dB maximal dB value
  * \param resolution resolution of control
  * \param slave Slave PCM handle
  * \param close_slave When set, the slave PCM handle is closed with copy PCM
@@ -710,7 +752,7 @@ int snd_pcm_softvol_open(snd_pcm_t **pcm
 			 snd_pcm_format_t sformat,
 			 int ctl_card, snd_ctl_elem_id_t *ctl_id,
 			 int cchannels,
-			 double min_dB, int resolution,
+			 double min_dB, double max_dB, int resolution,
 			 snd_pcm_t *slave, int close_slave)
 {
 	snd_pcm_t *pcm;
@@ -728,7 +770,7 @@ int snd_pcm_softvol_open(snd_pcm_t **pcm
 	if (! svol)
 		return -ENOMEM;
 	err = softvol_load_control(slave, svol, ctl_card, ctl_id, cchannels,
-				   min_dB, resolution);
+				   min_dB, max_dB, resolution);
 	if (err < 0) {
 		softvol_free(svol);
 		return err;
@@ -812,6 +854,7 @@ pcm.name {
 		[count INT]     # control channels 1 or 2 (default: 2)
 	}
 	[min_dB REAL]           # minimal dB value (default: -51.0)
+	[max_dB REAL]           # maximal dB value (default:   0.0)
 	[resolution INT]        # resolution (default: 256)
 }
 \endcode
@@ -851,6 +894,7 @@ int _snd_pcm_softvol_open(snd_pcm_t **pc
 	snd_ctl_elem_id_t *ctl_id;
 	int resolution = PRESET_RESOLUTION;
 	double min_dB = PRESET_MIN_DB;
+	double max_dB = ZERO_DB;
 	int card = -1, cchannels = 2;
 
 	snd_config_for_each(i, next, conf) {
@@ -886,6 +930,14 @@ int _snd_pcm_softvol_open(snd_pcm_t **pc
 			}
 			continue;
 		}
+		if (strcmp(id, "max_dB") == 0) {
+			err = snd_config_get_real(n, &max_dB);
+			if (err < 0) {
+				SNDERR("Invalid max_dB value");
+				return err;
+			}
+			continue;
+		}
 		SNDERR("Unknown field %s", id);
 		return -EINVAL;
 	}
@@ -899,6 +951,11 @@ int _snd_pcm_softvol_open(snd_pcm_t **pc
 	}
 	if (min_dB >= 0) {
 		SNDERR("min_dB must be a negative value");
+		return -EINVAL;
+	}
+	if (max_dB <= min_dB || max_dB > MAX_DB_UPPER_LIMIT) {
+		SNDERR("max_dB must be larger than min_dB and less than %d dB",
+		       MAX_DB_UPPER_LIMIT);
 		return -EINVAL;
 	}
 	if (resolution < 0 || resolution > 1024) {
@@ -930,7 +987,7 @@ int _snd_pcm_softvol_open(snd_pcm_t **pc
 		return err;
 	}
 	err = snd_pcm_softvol_open(pcmp, name, sformat, card, ctl_id, cchannels,
-				   min_dB, resolution, spcm, 1);
+				   min_dB, max_dB, resolution, spcm, 1);
 	if (err < 0)
 		snd_pcm_close(spcm);
 	return err;


--------------040204070504000400050007
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040204070504000400050007--
