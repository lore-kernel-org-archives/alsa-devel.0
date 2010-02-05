From: ANISH KUMAR <anish.singh@samsung.com>
Subject: DMA interrupt not getting triggered
Date: Fri, 05 Feb 2010 08:22:13 +0000 (GMT)
Message-ID: <23597305.717561265358133640.JavaMail.weblogic@epml09>
Reply-To: anish.singh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 11C6624157
	for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2010 09:22:16 +0100 (CET)
Received: from ep_ms13_bk (mailout2.samsung.com [203.254.224.25])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KXD00LEJ0L1UL@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 05 Feb 2010 17:22:13 +0900 (KST)
Received: from ep_spt03 (ms13.samsung.com [203.254.225.109])
	by ms13.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTP id <0KXD0024G0L150@ms13.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 05 Feb 2010 17:22:13 +0900 (KST)
Content-return: prohibited
MIME-version: 1.0
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "JaroslavKyselaperex@perex.cz" <JaroslavKyselaperex@perex.cz>
List-Id: alsa-devel@alsa-project.org


These are the logs in normal case:
Entered s3c24xx_pcm_hw_free
Entered s3c24xx_pcm_hw_free
Entered s3c24xx_pcm_open               
Entered s3c24xx_pcm_hw_params, line 330
Entered s3c24xx_pcm_prepare   
Entered s3c24xx_pcm_enqueue   
Entered s3c24xx_pcm_trigger   
Entered s3c24xx_pcm_pointer   
Entered s3c24xx_pcm_pointer   
Entered s3c24xx_pcm_pointer   
Entered s3c6410_audio_buffdone
Entered s3c24xx_pcm_pointer   
Entered s3c24xx_pcm_enqueue   
Entered s3c24xx_pcm_pointer   
Entered s3c24xx_pcm_pointer   
Entered s3c24xx_pcm_terpoin   
Entered s3c6410_audio_buffdone
 
In abnormal case:
Entered s3c24xx_pcm_hw_free 
Entered s3c24xx_pcm_hw_free 
Entered s3c24xx_pcm_close, 
Entered s3c24xx_pcm_open    
Entered s3c24xx_pcm_hw_param                  
Entered s3c24xx_pcm_prepare 
Entered s3c24xx_pcm_enqueue 
Entered s3c24xx_pcm_trigger 
Entered s3c24xx_pcm_trigger 
Entered s3c24xx_pcm_trigger 
Entered s3c24xx_pcm_pointer 
Entered s3c24xx_pcm_pointer 
Entered s3c24xx_pcm_pointer 
Entered s3c24xx_pcm_pointer 
Entered s3c24xx_pcm_pointer 
Entered s3c24xx_pcm_pointer 
Entered s3c24xx_pcm_pointer 
Entered s3c24xx_pcm_pointer 
Entered s3c24xx_pcm_pointer 
Entered s3c24xx_pcm_pointer 
Entered s3c24xx_pcm_pointer 
Entered s3c24xx_pcm_pointer 
Entered s3c24xx_pcm_pointer 
Entered s3c24xx_pcm_pointer 
Entered s3c24xx_pcm_pointer 
