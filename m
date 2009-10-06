From: "Demian Martin" <demianm_1@yahoo.com>
Subject: Re: [PATCH 18/31] HDA patch_via.c: Add 48K sample rate
	limit for S/PDIF streams.
Date: Mon, 5 Oct 2009 22:15:33 -0700
Message-ID: <002DCEC0FD024441A08A6AEFF6FFC6BB@DemianM1330>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp102.prem.mail.sp1.yahoo.com
	(smtp102.prem.mail.sp1.yahoo.com [98.136.44.57])
	by alsa0.perex.cz (Postfix) with SMTP id 08D8810380B
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 07:16:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: liboat@gmail.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, HaraldWelte@viatech.com, LoganLi@viatech.com.cn, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

Li Bo:
I'm not sure how changing the sample rate for SPDIF would have an effect of
the SNR if you are only passing digital signals. I have had excellent
measured results with the Via chipsets at all sample rates up to 192 KHz at
24 bits on the digital output. Perhaps you can explain how you measured the
performance and that may explain your results. Normally if all of the data
of the original file is present then any limit on SNR is a function of the
DAC. If the data is not the same as the original file then there are more
serious issues to be resolved, and it probably would not be useable with
Dolby Digital or DTS.

Higher sample rates for digital content and digital interfaces are becoming
more common and I think it would be a serious mistake to limit the
performance of the platform.


>Hi, Takashi

>According to our HW test, S/PDIF at 48K sample rate has best SNR, so this
limit can make >S/PDIF work better.

 
Demian Martin
Product Design Service
784 Cary Drive
San Leandro, CA 94577
209 613 6990
