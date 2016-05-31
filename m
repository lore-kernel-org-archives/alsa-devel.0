From: Pietro <pxpert@gmail.com>
Subject: Re: Applied "ASoC: Intel: add bytct-rt5651 machine
	driver" to the asoc tree
Date: Tue, 31 May 2016 10:43:01 +0200
Message-ID: <1851514.XmzcdsvJt0@wks-pdc-gentoo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id BECB82654C3
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 10:43:03 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id e3so30196642wme.2
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 01:43:03 -0700 (PDT)
Received: from wks-pdc-gentoo.localnet ([2a00:6d40:0:ffff:36e6:d7ff:fe70:250d])
 by smtp.gmail.com with ESMTPSA id h2sm16029276wjv.15.2016.05.31.01.43.02
 for <alsa-devel@alsa-project.org> (version=TLSv1/SSLv3 cipher=OTHER);
 Tue, 31 May 2016 01:43:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
 
I'm an owner of a 2 in 1 Netbook with an Atom X5 Z8300 SoC with rt5651 codec (Cube iWork 11).
 
To get audio working I Added these lines of code to the ./soc/intel/atom/sst/sst_acpi.c file:
 
--- ./soc/intel/atom/sst/sst_acpi.c.old 2016-05-31 09:05:40.045682194 +0200
+++ ./soc/intel/atom/sst/sst_acpi.c     2016-05-31 09:07:26.829324148 +0200
@@ -342,9 +342,12 @@
                                                &chv_platform_data },
        {"193C9890", "cht-bsw-max98090", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
                                                &chv_platform_data },
+       {"10EC5651", "bytcr_rt5651", "intel/fw_sst_0f28.bin", "bytcr_rt5651", NULL,
+                                               &byt_rvp_platform_data },
        {},
 };
 
+
 static const struct acpi_device_id sst_acpi_ids[] = {
        { "80860F28", (unsigned long)&sst_acpi_bytcr},
        { "808622A8", (unsigned long) &sst_acpi_chv},
 
 
 
 
Then i added the UCM files linked in these archive:
https://github.com/plbossart/UCM/tree/master/bytcr-rt5651 
 
 
 
With this configuration, audio seems to work, but is 'slow': Playback speed is at slow motion, and seconds move slowly (Tried with aplay and audacious with many sound files, using directly Alsa and Pulseaudio with no differencies).
 
This seems to be a DSP Clock problem. Have you got any suggestions to solve this problem?
 
Thanks,
Pietro
