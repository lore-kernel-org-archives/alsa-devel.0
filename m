From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: ASoC for TI OMAP - alsa-devel submission?
Date: Wed, 2 Apr 2008 13:45:30 +0300
Message-ID: <20080402134530.3460b0bf.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id C68AF243F3
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Apr 2008 12:45:25 +0200 (CEST)
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m32AlFhs026882
	for <alsa-devel@alsa-project.org>; Wed, 2 Apr 2008 05:47:33 -0500
Received: from kikka3 (esdhcp04048.research.nokia.com [172.21.40.48])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with SMTP id
	m32Aiw6L020049
	for <alsa-devel@alsa-project.org>; Wed, 2 Apr 2008 13:44:59 +0300
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

I've been doing generic ASoC drivers for Texas Instruments OMAP
processors and I recently released the first version on linux-omap
mailing list:

http://marc.info/?l=linux-omap&m=120643770810683&w=2
http://marc.info/?l=linux-omap&m=120643766610623&w=2

Currently patch tries to cover OMAPs from 1x10 to 2420 and is tested
on Nokia N810 having OMAP2420 and TLV320AIC33 codec.

I'm going to release it here also but there are few issues I would like
to discuss before it:

- McBSP used in OMAP2430 and OMAP3430 are bit different than other
1510-2420 OMAPs and that support we have currently missing in
linux-omap either. However, changes to my drivers should be quite
minimal in order to support them. E.g. base address definitions and
different DMA data type.
- Solving the channel synchronization problem might require API change
to linux-omap McBSP driver.
- ASoC v2 considerations? Like multiformat DAI.
- Multiformat McBSP DAI link driver (I'll send an another mail on that).

So what I mean that should I post the patch like as it now, rebased to
dev branch of linux-2.6-asoc tree and with some minor changes, or wait a
bit when all linux-omap and ASoC v2 evolve? What you think?

-- 
Jarkko
