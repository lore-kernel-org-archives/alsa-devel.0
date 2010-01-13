From: ANISH KUMAR <anish.singh@samsung.com>
Subject: ALSA DMIX support without MMAP ?
Date: Wed, 13 Jan 2010 09:46:36 +0000 (GMT)
Message-ID: <22118431.247131263375996658.JavaMail.weblogic@epml17>
Reply-To: anish.singh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id B6114103804
	for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2010 10:46:40 +0100 (CET)
Received: from ep_ms13_bk (mailout4.samsung.com [203.254.224.34])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KW600HI3J5OFS@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 13 Jan 2010 18:46:36 +0900 (KST)
Received: from ep_spt02 (ms13.samsung.com [203.254.225.109])
	by ms13.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTP id <0KW6003YOJ5OPB@ms13.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 13 Jan 2010 18:46:36 +0900 (KST)
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
List-Id: alsa-devel@alsa-project.org

Hi,

I am working on android and and in our device we use ALSA.

 I  have enabled dmix support for andoid as by default android doesn't have this plugin enabled and soon will post it in android forum however i have run into some problems.Hoping takashi can help me out on this.

Problem is when i am trying to use dmix plugin i am not getting any sound (logs shown below).Is it because i don't have mmap mode support on my device???

If yes then can't dmix work without mmap mode???   Logs shown below:

Entered s3c24xx_pcm_hw_params,
Entered s3c24xx_pcm_hw_params, line 330
Entered s3c24xx_pcm_mmap
Entered s3c24xx_pcm_prepare
Entered s3c24xx_pcm_enqueue
Entered s3c24xx_pcm_trigger
Entered s3c24xx_pcm_pointer
Entered s3c24xx_pcm_pointer res_value[0]
snd_pcm_update_hw_ptr_pos xun: [0]occured XRUN!

Normal playback and recording is fine if i dont use dmix plugin.During my normal playback and recording i don't use mmap as i preallocate DMA memory  and use them.

Regards,
anish
