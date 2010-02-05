From: ANISH KUMAR <anish.singh@samsung.com>
Subject: DMA interrupt not getting triggered
Date: Fri, 05 Feb 2010 08:17:17 +0000 (GMT)
Message-ID: <25591311.716591265357837890.JavaMail.weblogic@epml09>
Reply-To: anish.singh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout5.samsung.com (mailout5.samsung.com [203.254.224.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E05924141
	for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2010 09:17:22 +0100 (CET)
Received: from ep_ms13_bk (mailout5.samsung.com [203.254.224.35])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KXD00K9E0CUGK@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 05 Feb 2010 17:17:18 +0900 (KST)
Received: from ep_spt02 (ms13.samsung.com [203.254.225.109])
	by ms13.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTP id <0KXD006400CTF2@ms13.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 05 Feb 2010 17:17:18 +0900 (KST)
Content-return: prohibited
MIME-version: 1.0
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "JaroslavKyselaperex@perex.cz" <JaroslavKyselaperex@perex.cz>
List-Id: alsa-devel@alsa-project.org

I am facing problem related to DMA interrupt not getting triggered some times(out of 5 times one time it is happening) causing application to wait for the buffers(hw_ptr = 0) and no sound because of this.
I am using samsung soc with DMA controller PL080.I tried increasing periods_min to 4 but still no result.
I am using 2.6.29 kernel version.
