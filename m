From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [topic/asoc][PATCH 0/1] ASoC: Fix incorrect DSP format
	in OMAP McBSP DAI and affected drivers
Date: Mon, 22 Dec 2008 10:21:35 +0200
Message-ID: <1229934096-4715-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 737E91037E3
	for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2008 09:21:55 +0100 (CET)
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	mBM8Lpg3022563
	for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2008 10:21:53 +0200
Received: from localhost.localdomain (esdhcp042162.research.nokia.com
	[172.21.42.162])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id
	mBM8LdMg011560
	for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2008 10:21:40 +0200
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

This fix is generated against topic/asoc and don't apply against mainline.
IMO this can go to next merge window with preceding patches since OSK5912
in mainline should work, just format is defined wrong and all new drivers
where this affects should anyway go to the top of topic/asoc.


--
Jarkko
