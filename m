From: "Timofei V. Bondarenko" <tim@ipi.ac.ru>
Subject: Re: [PATCH] cmipci - allow capture of raw spdif
	subframes
Date: Wed, 07 Nov 2007 15:13:52 +0300
Message-ID: <4731AC00.7040103@ipi.ac.ru>
References: <4731ABBE.8030805@ipi.ac.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050900060803010807030506"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipi.ac.ru (blackpeer.ipi.ac.ru [83.149.227.82])
	by alsa0.perex.cz (Postfix) with ESMTP id 736E624399
	for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2007 13:13:53 +0100 (CET)
Received: from black.ipi.ac.ru (black.ipi.ac.ru [192.168.1.44])
	by ipi.ac.ru (8.14.1/8.14.1) with ESMTP id lA7CDqF1013685
	for <alsa-devel@alsa-project.org>; Wed, 7 Nov 2007 15:13:53 +0300
In-Reply-To: <4731ABBE.8030805@ipi.ac.ru>
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

This is a multi-part message in MIME format.
--------------050900060803010807030506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Timofei V. Bondarenko wrote:
> Hi.
> 
> Enable capturing of raw 32bit IEC958_SUBFRAME.
> 
> The 24-bits PCM data can be obtained using iec958 plugin.
> 
> Known problem: captured stream may begin with either left or right 
> subframe. Since the iec958 plugin doesn't decode preamble it may swap 
> the channels sometime.

Sorry, i've forgot to attach the patch...

--------------050900060803010807030506
Content-Type: text/x-patch;
 name="cmi-capt-spdif24.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cmi-capt-spdif24.patch"

Signed-off-by: Timofei Bondarenko <tim@ipi.ac.ru>

--- alsa-driver-hg20071107/alsa-kernel/pci/cmipci.c	2007-11-01 04:00:07.000000000 +0300
+++ alsa-driver/alsa-kernel/pci/cmipci.c	2007-11-07 14:55:05.000000000 +0300
@@ -1400,6 +1407,11 @@ static int snd_cmipci_capture_spdif_prep
 		else
 			snd_cmipci_clear_bit(cm, CM_REG_CHFORMAT, CM_DBLSPDS);
 	}
+	if (snd_pcm_format_width(substream->runtime->format) > 16)
+		snd_cmipci_set_bit(cm, CM_REG_MISC_CTRL, CM_SPD32SEL);
+	else
+		snd_cmipci_clear_bit(cm, CM_REG_MISC_CTRL, CM_SPD32SEL);
+
 	spin_unlock_irq(&cm->reg_lock);
 
 	return snd_cmipci_pcm_prepare(cm, &cm->channel[CM_CH_CAPT], substream);
@@ -1411,6 +1423,7 @@ static int snd_cmipci_capture_spdif_hw_f
 
 	spin_lock_irq(&cm->reg_lock);
 	snd_cmipci_clear_bit(cm, CM_REG_FUNCTRL1, CM_CAPTURE_SPDF);
+	snd_cmipci_clear_bit(cm, CM_REG_MISC_CTRL, CM_SPD32SEL);
 	spin_unlock_irq(&cm->reg_lock);
 
 	return snd_cmipci_hw_free(subs);
@@ -1562,7 +1575,8 @@ static struct snd_pcm_hardware snd_cmipc
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_PAUSE |
 				 SNDRV_PCM_INFO_RESUME | SNDRV_PCM_INFO_MMAP_VALID),
-	.formats =	        SNDRV_PCM_FMTBIT_S16_LE,
+	.formats =	        SNDRV_PCM_FMTBIT_S16_LE |
+				SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
 	.rates =		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
 	.rate_min =		44100,
 	.rate_max =		48000,

--------------050900060803010807030506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050900060803010807030506--
