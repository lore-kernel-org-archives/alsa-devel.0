From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: ASoC: About amp driver
Date: Mon, 15 Jun 2009 16:54:49 +0900
Message-ID: <4A35FE49.4090805@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 107D024400
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 09:55:02 +0200 (CEST)
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KL900IRTSNDR4@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 15 Jun 2009 16:54:50 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KL900DASSND53@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 15 Jun 2009 16:54:49 +0900 (KST)
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
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hi.

I have one question. Currently, the amp driver of ASoC is included in machine
driver. (ex. neo1973_wm8753 machine driver)
I want to use the same amp driver in more than one machine driver, but then the
same amp driver code exists double in each machine driver.

So, how about spliting between the amp driver and the machine driver? and Is it
possible?
