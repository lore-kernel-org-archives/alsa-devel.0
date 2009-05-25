From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Question about snd_dma_buffer  bytes field
Date: Sun, 24 May 2009 19:26:42 -0700
Message-ID: <4A1A01E2.608@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth03.csee.onr.siteprotect.com
	(smtpauth03.csee.onr.siteprotect.com [64.26.60.137])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E6FA24583
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 04:26:50 +0200 (CEST)
Received: from [192.168.0.251] (unknown [67.42.45.38])
	(Authenticated sender: troy.kisky@boundarydevices.com)
	by smtpauth03.csee.onr.siteprotect.com (Postfix) with ESMTP id
	1F4BF10380A3
	for <alsa-devel@alsa-project.org>; Sun, 24 May 2009 21:26:45 -0500 (CDT)
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

Does

(substream->dma_buffer.bytes) need to equal (snd_pcm_lib_period_bytes(substream) * runtime->periods) ?

When this is not true, it seems like the buffer is not being filled correctly.


for testing, this works
	.buffer_bytes_max = 16 * 7 * 512,
	.period_bytes_min = 32,
	.period_bytes_max = 7 * 512,	/* This is size of ping + pong buffer*/

and this doesn't.
	.buffer_bytes_max = 16 * 7 * 512 + 512,
	.period_bytes_min = 32,
	.period_bytes_max = 7 * 512,	/* This is size of ping + pong buffer*/


When playing back a sine wave, I can hear breaks.


Thanks
Troy
