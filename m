From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 0/2] Fixes to couple DAPM widget functions
Date: Thu, 28 Feb 2008 11:53:08 +0200
Message-ID: <1204192390-16304-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 38BB52452F
	for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2008 10:52:58 +0100 (CET)
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m1S9qkdO024449
	for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2008 11:52:56 +0200
Received: from localhost.localdomain (esdhcp04140.research.nokia.com
	[172.21.41.40])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id
	m1S9qpnW027824
	for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2008 11:52:52 +0200
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

API change done by the commit 9af6d9562414568ecadf96aaef5b88e7e8b19821,
"[ALSA] soc - Add support for passing kcontrols with events", doesn't change
affected pxa machine and wm9712 drivers.

These two patches are generated from master branch of linux-2.6-asoc tree but
they apply to alsa git and alsa-kernel hg trees as well. I separated wm9712
to own patch since it is ok in asoc-v2-dev branch. There are other drivers
as well with this error in asoc-v2-dev but I don't know are they already in
progress? I can post a another patch to them if needed.

-- 
Jarkko
