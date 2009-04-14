From: Florian Faber <faber@faberman.de>
Subject: [PATCH 1/2] hdspm: metering ioctl fixed
Date: Tue, 14 Apr 2009 17:47:20 +0200
Message-ID: <1239724040.18545.6.camel@x200.watzmann.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de (india820.server4you.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 775C5243C6
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 17:47:23 +0200 (CEST)
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

Metering didn't work before. I know of no application that used this
ioctl before, so I assume it is safe to modify the structure.

diff a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c

10a11,13
>  *      Modified 2009-04-13 for proper metering by Florian Faber 
>  *                                               <faber@faberman.de>
>  *
82c85,86
<        "Remy Bruno <remy.bruno@trinnov.com>");
---
>        "Remy Bruno <remy.bruno@trinnov.com>, "
>        "Florian Faber <faber@faberman.de>");
136c140,151
< #define HDSPM_MADI_peakrmsbase 	4096	/* 4096-8191 2x64x32Bit Meters */
---
> 
> #define HDSPM_MADI_INPUT_PEAK		4096
> #define HDSPM_MADI_PLAYBACK_PEAK	4352
> #define HDSPM_MADI_OUTPUT_PEAK		4608
> 
> #define HDSPM_MADI_INPUT_RMS_L		6144
> #define HDSPM_MADI_PLAYBACK_RMS_L	6400
> #define HDSPM_MADI_OUTPUT_RMS_L		6656
> 
> #define HDSPM_MADI_INPUT_RMS_H		7168
> #define HDSPM_MADI_PLAYBACK_RMS_H	7424
> #define HDSPM_MADI_OUTPUT_RMS_H		7680
707c722
< 		/* maby a madi input (which is taken if sel sync is madi) */
---
> 		/* mayby a madi input (which is taken if sel sync is madi) */
4108a4124,4128
> static inline int copy_u32_le(void __user *dest, void __iomem *src)
> {
> 	u32 val = readl(src);
> 	return copy_to_user(dest, &val, 4);
> }
4111c4131
< 				 unsigned int cmd, unsigned long arg)
---
> 				 unsigned int cmd, unsigned long __user arg)
4113,4136c4133,4172
< 	struct hdspm *hdspm = hw->private_data;
< 	struct hdspm_mixer_ioctl mixer;
< 	struct hdspm_config_info info;
< 	struct hdspm_version hdspm_version;
< 	struct hdspm_peak_rms_ioctl rms;
< 
< 	switch (cmd) {
< 
< 	case SNDRV_HDSPM_IOCTL_GET_PEAK_RMS:
< 		if (copy_from_user(&rms, (void __user *)arg, sizeof(rms)))
< 			return -EFAULT;
< 		/* maybe there is a chance to memorymap in future
< 		 * so dont touch just copy
< 		 */
< 		if(copy_to_user_fromio((void __user *)rms.peak,
< 				       hdspm->iobase+HDSPM_MADI_peakrmsbase,
< 				       sizeof(struct hdspm_peak_rms)) != 0 )
< 			return -EFAULT;
< 
< 		break;
< 		
< 
< 	case SNDRV_HDSPM_IOCTL_GET_CONFIG_INFO:
< 
---
>   void __user *argp = (void __user *)arg;
>   struct hdspm *hdspm = hw->private_data;
>   struct hdspm_mixer_ioctl mixer;
>   struct hdspm_config_info info;
>   struct hdspm_version hdspm_version;
>   struct hdspm_peak_rms levels;
>   long unsigned int s;
>   int i=0;
>   
>   switch (cmd) {
>     
>   case SNDRV_HDSPM_IOCTL_GET_PEAK_RMS:
>     for (i=0; i<64; i++) {
>       levels.input_peaks[i] = readl(hdspm->iobase
+HDSPM_MADI_INPUT_PEAK+i*4);
>       levels.playback_peaks[i] = readl(hdspm->iobase
+HDSPM_MADI_PLAYBACK_PEAK+i*4);
>       levels.output_peaks[i] = readl(hdspm->iobase
+HDSPM_MADI_OUTPUT_PEAK+i*4);
>       levels.input_rms[i] = (readl(hdspm->iobase
+HDSPM_MADI_INPUT_RMS_H+i*4) << 32) | readl(hdspm->iobase
+HDSPM_MADI_INPUT_RMS_L+i*4);
>       levels.playback_rms[i] = (readl(hdspm->iobase
+HDSPM_MADI_PLAYBACK_RMS_H+i*4) << 32) | readl(hdspm->iobase
+HDSPM_MADI_PLAYBACK_RMS_L+i*4);
>       levels.output_rms[i] = (readl(hdspm->iobase
+HDSPM_MADI_OUTPUT_RMS_H+i*4) << 32) | readl(hdspm->iobase
+HDSPM_MADI_OUTPUT_RMS_L+i*4);
>     }
> 
>     if (hdspm->system_sample_rate>96000) {
>       levels.speed = qs;
>     } else if (hdspm->system_sample_rate>48000) {
>       levels.speed = ds;
>     } else {
>       levels.speed = ss;
>     }
>     levels.status2 = hdspm_read(hdspm, HDSPM_statusRegister2);
> 
>     s = copy_to_user(argp, &levels, sizeof(struct hdspm_peak_rms));
>     if (0 != s) {
>       snd_printk(KERN_ERR "copy_to_user(.., .., %lu): %lu\n",
sizeof(struct hdspm_peak_rms), s);
>       return -EFAULT;
>     }
>     break;
>     
>     
>   case SNDRV_HDSPM_IOCTL_GET_CONFIG_INFO:
>     

Flo
-- 
Machines can do the work, so people have time to think.
public key 6C002249          x-hkp://wwwkeys.eu.pgp.net
