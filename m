From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: ASoC: Dummy codec driver?
Date: Wed, 19 May 2010 21:22:05 +0900
Message-ID: <4BF3D7ED.8090805@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout5.samsung.com (mailout5.samsung.com [203.254.224.35])
	by alsa0.perex.cz (Postfix) with ESMTP id C6BE31038E8
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 14:22:14 +0200 (CEST)
Received: from epmmp2 (mailout5.samsung.com [203.254.224.35])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0L2O007DT2CTRJ@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 19 May 2010 21:22:06 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0L2O00G232CTHO@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 19 May 2010 21:22:05 +0900 (KST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hi,

I have a target(The cpu is S5PC110) which doesn't have audio codec, but 
it needs the audio device node to play audio at the TV via HDMI. The
S5PC110 HDMI transmits itself to TV the audio data from I2S buffer, so i 
have made dummy codec driver to create audio device node and to transmit
audio data to I2S buffer.

How do you think about the dummy codec driver?
