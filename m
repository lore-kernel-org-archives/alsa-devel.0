From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [2.6.29-rc3][PATCH 0/1] ASoC: OMAP: Initialize XCCR
	and RCCR registers in McBSP DAI driver
Date: Thu, 29 Jan 2009 13:29:45 +0200
Message-ID: <1233228586-8894-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id A97DA10386B
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 12:30:05 +0100 (CET)
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	n0TBTcR2005150
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 05:30:02 -0600
Received: from localhost.localdomain (esdhcp042162.research.nokia.com
	[172.21.42.162])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id
	n0TBTdMw020822
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 13:29:39 +0200
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

Hi

I'm sending this on behalf of Misael Lopez Cruz with commit id for
counterpart patch corrected. This is a fix for 2.6.29.

There are some OMAP3 based boards where bootloader is clearing the McBSP
XCCR and RCCR register thus causing that DMA is not working with OMAP McBSP
DAI driver.

As now there is commit 3127f8f8595a064b3f1a1837fea2177902589ac3 in mainline
writing those registers, we must initialize them here since otherwise
DMA is not working with McBSP DAI driver in any OMAP3 or 2430 based board.


-- 
Jarkko
