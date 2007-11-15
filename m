From: Timur Tabi <timur@freescale.com>
Subject: Re: Is there a function I can call from my ISR to tell
 ALSA to abort playback?
Date: Thu, 15 Nov 2007 09:00:54 -0600
Message-ID: <473C5F26.2050807@freescale.com>
References: <473B5D83.2020408@freescale.com>
	<Pine.LNX.4.61.0711150932310.19062@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id CC6BE243B1
	for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2007 16:01:00 +0100 (CET)
In-Reply-To: <Pine.LNX.4.61.0711150932310.19062@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:

> Yes, call snd_pcm_stop() function. The call must be protected with 
> snd_pcm_stream_lock... See to i2c/other/ak4117.c for an example.

That code calls snd_pcm_stop() from a timer, not an ISR.  Do I need the call to 
wake_up() as well?

-- 
Timur Tabi
Linux kernel developer at Freescale
