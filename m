From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: A question about the soc jack status
Date: Wed, 28 Oct 2009 16:16:49 +0900
Message-ID: <4AE7EFE1.9000407@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 32AC11037E3
	for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2009 08:16:52 +0100 (CET)
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KS70093IQW124@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 28 Oct 2009 16:16:49 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KS70060ZQW1Q6@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 28 Oct 2009 16:16:49 +0900 (KST)
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
Cc: knhoon.baik@samsung.com, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

Hi, all.

I have a question about soc jack. I know the soc jack reports the jack 
status when the jack status is change only. For example when the jack 
is inserted or released, the soc jack reports the jack status to user 
via input subsystem.

But i want to know the jack status always regardless of the event to 
insert or release a jack. For example we can check the jack status 
always if the jack status is reported via sysfs file.

So, is there how to know the jack status always the currently?
