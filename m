From: "Timofei V. Bondarenko" <tim@ipi.ac.ru>
Subject: [PATCH] cmipci - utilize ADC48K44K bit
Date: Wed, 07 Nov 2007 15:08:19 +0300
Message-ID: <4731AAB3.5000209@ipi.ac.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070904050109070404060204"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipi.ac.ru (blackpeer.ipi.ac.ru [83.149.227.82])
	by alsa0.perex.cz (Postfix) with ESMTP id 59A5B2437D
	for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2007 13:08:21 +0100 (CET)
Received: from black.ipi.ac.ru (black.ipi.ac.ru [192.168.1.44])
	by ipi.ac.ru (8.14.1/8.14.1) with ESMTP id lA7C8JHY013611
	for <alsa-devel@alsa-project.org>; Wed, 7 Nov 2007 15:08:20 +0300
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
--------------070904050109070404060204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Setting the ADC48K44K greatly improves capture quality at 48k sampling rate.

With this bit clear ADC does ZOH interpolation of every 22th sample at 48k.

At frequencies higher than 48k there ADC performs a little better with 
ADC48K44K bit set.
At 44.1k ADC performs a little better with this bit clear.
At frequencies below 44.1k there is no difference.


Regards,
	Tim.

--------------070904050109070404060204
Content-Type: text/x-patch;
 name="cmi-adc48k.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cmi-adc48k.patch"

Signed-off-by: Timofei Bondarenko <tim@ipi.ac.ru>

--- alsa-driver-hg20071107/alsa-kernel/pci/cmipci.c	2007-11-01 04:00:07.000000000 +0300
+++ alsa-driver/alsa-kernel/pci/cmipci.c	2007-11-07 14:55:05.000000000 +0300
@@ -869,6 +869,13 @@ static int snd_cmipci_pcm_prepare(struct
 	snd_cmipci_write(cm, CM_REG_CHFORMAT, val);
 	//snd_printd("cmipci: chformat = %08x\n", val);
 
+	if (!rec->is_dac && cm->chip_version) {
+		if (runtime->rate > 44100)
+			snd_cmipci_set_bit(cm, CM_REG_EXT_MISC, CM_ADC48K44K);
+		else
+			snd_cmipci_clear_bit(cm, CM_REG_EXT_MISC, CM_ADC48K44K);
+	}
+
 	rec->running = 0;
 	spin_unlock_irq(&cm->reg_lock);
 


--------------070904050109070404060204
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070904050109070404060204--
