From: ANISH KUMAR <anish.singh@samsung.com>
Subject: No shutdown code in soc-core.c
Date: Fri, 16 Apr 2010 02:29:21 +0000 (GMT)
Message-ID: <17295568.74341271384961009.JavaMail.weblogic@epml11>
Reply-To: anish.singh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 512E2103803
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Apr 2010 04:29:26 +0200 (CEST)
Received: from ep_ms13_bk (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0L0Y00CEH6WXH2@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 16 Apr 2010 11:29:21 +0900 (KST)
Received: from ep_spt04 (ms13.samsung.com [203.254.225.109])
	by ms13.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTP id <0L0Y00J1N6WXIR@ms13.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 16 Apr 2010 11:29:21 +0900 (KST)
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
Cc: "liam.girdwood@wolfsonmicro.com" <liam.girdwood@wolfsonmicro.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

I have a doubt regarding this soc_driver struct which is defined 
in soc-core.c file.Why not soc_shutdown code is added in this 
struct??
