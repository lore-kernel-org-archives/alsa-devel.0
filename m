From: "Saxena, Anshuman" <anshuman@ti.com>
Subject: Query for running OSS application on ALSA
Date: Wed, 26 Nov 2008 18:22:40 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B02D0FFD216@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 09C1D245BA
	for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2008 13:53:12 +0100 (CET)
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAQCr4Gs008943
	for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2008 06:53:10 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id mAQCr2LE010397
	for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2008 18:23:03 +0530 (IST)
Content-Language: en-US
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
I have been using OSS drivers and applications. Now I have moved to ALSA SoC framework supported in the kernel. I have got the same OSS application running on this ALSA SoC framework but I have the following observation:

When I run the OSS application to playback some audio through ALSA SoC framework, and I send CTRL+C signal to terminate the application, I see a delay of around 3-4 sec before the application really close. I traced and found out that it takes lot of time in snd_pcm_drain in pcm_native.c .
But if I run some ALSA application, I do not see this delay in terminating the application.

Is there some known issue with OSS emulation of ALSA SoC framework? I feel that some buffers are being drained out to the audio codec and hence this time is consumed. Is their some configuration for the buffer size? Can I directly stop the data transfer to codec and discard the remaining data?

Your help is highly appreciated.

Thanks and Regards,
Anshuman
