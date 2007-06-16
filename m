From: Mike Crash <mike@mikecrash.com>
Subject: Bad digital out of ASUS M2V
Date: Sat, 16 Jun 2007 22:31:04 +0200
Message-ID: <46744888.50601@mikecrash.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2.coprosys.cz (mail2.coprosys.cz [81.92.155.2])
	by alsa0.perex.cz (Postfix) with ESMTP id A96AA103818
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Jun 2007 22:31:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail2.coprosys.cz (Postfix) with ESMTP id 3E4D148BAE
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Jun 2007 22:32:18 +0200 (CEST)
Received: from mail2.coprosys.cz ([127.0.0.1])
	by localhost (mail2 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 26817-03 for <alsa-devel@alsa-project.org>;
	Sat, 16 Jun 2007 22:32:17 +0200 (CEST)
Received: from [192.168.168.137] (cbrod.comtes.cz [81.92.150.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail2.coprosys.cz (Postfix) with ESMTP id CD58E48BA9
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Jun 2007 22:32:17 +0200 (CEST)
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

In ALSA 1.0.14 HDA Intel with ASUS M2V motherboard - detected the chip 
ALC660VD, but digital out is missing. I added workaround - added new 
model name 3stack-660-digout with digital output, diff file follows:
----------------------------------------------
117a118
 >     ALC660VD_3ST_DIG,
9466a9468
 >     [ALC660VD_3ST_DIG]= "3stack-660-digout",
9478c9480
<     SND_PCI_QUIRK(0x1043, 0x81e7, "ASUS", ALC660VD_3ST),
---
 >     SND_PCI_QUIRK(0x1043, 0x81e7, "ASUS", ALC660VD_3ST_DIG),
9501a9504,9516
 >     [ALC660VD_3ST_DIG] = {
 >         .mixers = { alc861vd_3st_mixer },
 >         .init_verbs = { alc861vd_volume_init_verbs,
 >                  alc861vd_3stack_init_verbs },
 >         .num_dacs = ARRAY_SIZE(alc660vd_dac_nids),
 >         .dac_nids = alc660vd_dac_nids,
 >         .dig_out_nid = ALC861VD_DIGOUT_NID,
 >         .num_adc_nids = ARRAY_SIZE(alc861vd_adc_nids),
 >         .adc_nids = alc861vd_adc_nids,
 >         .num_channel_mode = ARRAY_SIZE(alc861vd_3stack_2ch_modes),
 >         .channel_mode = alc861vd_3stack_2ch_modes,
 >         .input_mux = &alc861vd_capture_source,
 >     },
