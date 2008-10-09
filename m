From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [topic/asoc][DON'T PUSH][PATCH 0/3] ASoC: OMAP: McBSP
	DAI driver updates
Date: Thu,  9 Oct 2008 15:57:19 +0300
Message-ID: <1223557042-17279-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id E555B24481
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Oct 2008 14:58:13 +0200 (CEST)
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m99Cvp9G020866
	for <alsa-devel@alsa-project.org>; Thu, 9 Oct 2008 07:57:54 -0500
Received: from localhost.localdomain (esdhcp041113.research.nokia.com
	[172.21.41.113])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id
	m99CviN6007063
	for <alsa-devel@alsa-project.org>; Thu, 9 Oct 2008 15:57:45 +0300
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

Here are updates to OMAP McBSP DAI driver adding support to OMAP2430 &
OMAP34xx and adding support for multiple simultaneous DAI links.

Please note that the first patch is not randconfig safe until necessary OMAP
McBSP updates come into mainline so I rather don't push these yet until
those changes are here.

See

http://marc.info/?l=linux-omap&m=122345107722469&w=2


-- 
Jarkko
