From: Philip Chu <Philip.Chu@logicpd.com>
Subject: PCM DMA only can fire ISR when it receives 4 samples
 more than the period, from McBSP port?
Date: Wed, 22 Jun 2011 00:04:43 -0500
Message-ID: <0520A3FE5EDCF24F88B3F1451CFC64AE042818D531@EDPREX01.logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.logicpd.com (unknown [174.46.170.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E37724370
	for <Alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 07:04:49 +0200 (CEST)
Received: from EDPREX01.logicpd.com (edprex01.logicpd.com [10.1.18.134]) by
	barracuda.logicpd.com with ESMTP id zPFHHbCe9uBod6Nw
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=NO) for
	<Alsa-devel@alsa-project.org>; Wed, 22 Jun 2011 00:04:46 -0500 (CDT)
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
To: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

HI,

I got a problem with my audio capture using McBSP 3 port on OMAP 3530. Linux kernel 2.6.32.
For the very first audio data capture, when I expect to receive only one exact period of data through McBSP, PCM DMA ISR never comes. When I check the DMA pointer by using snd_pcm_update_hw_ptr_pos(), I found it was just trash value. If I ask the data sender to send 4 samples more than the period defined, DMA ISR gets fired, the it points to the exact period position, and I assume the extra 4 bytes just get lost?

My McBSP is configured as a slave which needs the sender to provide Frame Sync, clocks etc, and those signals are designed to just kick in at the same time. Do the clock signal need to be present earlier than the Frame Sync?

Anybody knows what the issue could be?

Thanks in advance.

Philip Chu
