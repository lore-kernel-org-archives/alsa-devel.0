From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Wrong channel order with multichannel HDMI on MCP7A
Date: Sun, 25 Jul 2010 19:51:39 +0300
Message-ID: <201007251951.39362.anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sypressi.dnainternet.net (sypressi.dnainternet.net
	[83.102.40.135]) by alsa0.perex.cz (Postfix) with ESMTP id 2BF5724B9D
	for <alsa-devel@alsa-project.org>;
	Sun, 25 Jul 2010 18:51:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sypressi.dnainternet.net (Postfix) with ESMTP id 95B9EC6667
	for <alsa-devel@alsa-project.org>;
	Sun, 25 Jul 2010 19:51:41 +0300 (EEST)
Received: from sypressi.dnainternet.net ([83.102.40.135])
	by localhost (sypressi.dnainternet.net [127.0.0.1]) (amavisd-new,
	port 10041)
	with ESMTP id IYTqC+VlsLDi for <alsa-devel@alsa-project.org>;
	Sun, 25 Jul 2010 19:51:41 +0300 (EEST)
Received: from omenapuu.dnainternet.net (omenapuu.dnainternet.net
	[83.102.40.212])
	by sypressi.dnainternet.net (Postfix) with ESMTP id 75E50C663E
	for <alsa-devel@alsa-project.org>;
	Sun, 25 Jul 2010 19:51:41 +0300 (EEST)
Received: from mail.onse.fi (unknown [109.204.162.131])
	by omenapuu.dnainternet.net (Postfix) with ESMTP id 6BF812BAE3
	for <alsa-devel@alsa-project.org>;
	Sun, 25 Jul 2010 19:51:40 +0300 (EEST)
Received: from sigma.onse.fi (sigma [10.0.0.8])
	by mail.onse.fi (Postfix) with ESMTP id EA9A810DE08F
	for <alsa-devel@alsa-project.org>;
	Sun, 25 Jul 2010 19:51:39 +0300 (EEST)
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

Hi all!

I have a motherboard with NVIDIA MCP7A HDMI audio.
However, multichannel audio is not mapped properly into the HDMI order.

On 5.1, I get RL in FC, RR in LFE, FC in RL, LFE in RR.

Interestingly, this is not consistent with the ALSA channel order (FL FR RL RR 
FC LFE) being passed directly to HDMI (FL FR LFE FC RL RR). Instead it looks 
like there has been a waveformatex (FL FR FC LFE RL RR; windows?) => HDMI 
conversion instead of ALSA => HDMI.

Same happens for 7.1.

Is it possible to set the hardware to do an ALSA => HDMI conversion instead?
If not, we should manually compensate for this somewhere, right?

Somewhat relatedly, trying to output 4 channels results in silence only. 
Trying to output 3 or 5 channels triggers a timeout with I/O error, with the 
following in the kernel log: "ALSA pcm_lib.c:1757: playback write error (DMA 
or IRQ trouble?)"

I used a git alsa-kmirror from few days ago on 2.6.35-rc4 for testing. 
Speaker-test and alsa-lib were 1.0.23.

-- 
Anssi Hannula
