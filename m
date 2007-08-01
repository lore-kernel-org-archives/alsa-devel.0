From: lokowich <lokowich@acdstar.com>
Subject: MPC5200 I2S driver for ASoC
Date: Wed, 01 Aug 2007 12:33:34 -0500
Message-ID: <46B0C3EE.5020401@acdstar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sentry.acdstar.com (mail.acdstar.com [209.98.244.9])
	by alsa0.perex.cz (Postfix) with ESMTP id 59E1C10384D
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Aug 2007 19:46:09 +0200 (CEST)
Received: from MailerDaemon by sentry.acdstar.com with local-bsmtp (Exim 4.63)
	(envelope-from <lokowich@acdstar.com>) id 1IGIGm-0001Bz-FT
	for alsa-devel@alsa-project.org; Wed, 01 Aug 2007 12:46:00 -0500
Received: from [192.168.2.3] (port=48007 helo=mail.acdstar.com)
	by sentry.acdstar.com with esmtp (Exim 4.63)
	(envelope-from <lokowich@acdstar.com>) id 1IGIGk-0001Bu-Bs
	for alsa-devel@alsa-project.org; Wed, 01 Aug 2007 12:45:58 -0500
Received: from [192.168.2.105] (rnd-03.int.acdstar.com [192.168.2.105])
	by mail.acdstar.com (8.13.6/8.13.6) with ESMTP id l71HjoGF009893
	for <alsa-devel@alsa-project.org>; Wed, 1 Aug 2007 12:45:50 -0500
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'm integrating a ALSA driver for an MPC5200 into the ASoC layer, 
similar to my successful effort for a PXA255 board.  I'm modeling the 
DMA and ALSA interfaces per ac97mgt driver found in the Lite5200B BSP, 
rather than the BestComm API example in the 2.4 kernel.  The 
speaker-test with 400Hz sine wave is working, but has a slight audible 
jitter.  A wav file output using aplay produces white noise.  Debugging 
shows I get two requests for buffer pointer per service of my transmit 
ISR (after the single call to snd_pcm_period_elapsed).  I expect only 
one pointer request per interrupt.  Could this be the noise problem?

This email was Anti Virus checked by Astaro Security Gateway. http://www.astaro.com
