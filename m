From: "Clemens Fruhwirth" <clemens@endorphin.org>
Subject: [PATCH] Typo kills AD1882 mixers
Date: Tue, 6 Jan 2009 18:34:09 +0100
Message-ID: <2f83750a0901060934n18b68fcdtfeb55f4748374907@mail.gmail.com>
References: <8763kvawxw.wl%clemens@endorphin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 46699103810
	for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2009 18:34:10 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 16so2960374fgg.44
	for <alsa-devel@alsa-project.org>; Tue, 06 Jan 2009 09:34:09 -0800 (PST)
In-Reply-To: <8763kvawxw.wl%clemens@endorphin.org>
Content-Disposition: inline
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

Typo bug.
--- linux-2.6.28-gentoo/sound/pci/hda/patch_analog.c    2009-01-04
10:58:53.000000000 +0100
+++ linux-2.6.28-gentoo.new/sound/pci/hda/patch_analog.c
2009-01-03 21:31:14.000000000 +0100
@@ -4264,13 +4264,13 @@
       spec->num_adc_nids = ARRAY_SIZE(ad1882_adc_nids);
       spec->adc_nids = ad1882_adc_nids;
       spec->capsrc_nids = ad1882_capsrc_nids;
-       if (codec->vendor_id == 0x11d1882)
+       if (codec->vendor_id == 0x11d41882)
               spec->input_mux = &ad1882_capture_source;
       else
               spec->input_mux = &ad1882a_capture_source;
       spec->num_mixers = 2;
       spec->mixers[0] = ad1882_base_mixers;
-       if (codec->vendor_id == 0x11d1882)
+       if (codec->vendor_id == 0x11d41882)
               spec->mixers[1] = ad1882_loopback_mixers;
       else
               spec->mixers[1] = ad1882a_loopback_mixers;



-- 
Fruhwirth Clemens http://clemens.endorphin.org
