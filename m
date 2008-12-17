From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: SND_SOC_DAIFMT_NB_NF meaning
Date: Tue, 16 Dec 2008 19:27:30 -0700
Message-ID: <49486392.4080001@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth03.csee.onr.siteprotect.com
	(smtpauth03.csee.onr.siteprotect.com [64.26.60.137])
	by alsa0.perex.cz (Postfix) with ESMTP id C0A622435F
	for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2008 03:27:36 +0100 (CET)
Received: from [192.168.0.251] (unknown [67.42.45.38])
	(Authenticated sender: troy.kisky@boundarydevices.com)
	by smtpauth03.csee.onr.siteprotect.com (Postfix) with ESMTP id
	743F61038007
	for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2008 20:27:34 -0600 (CST)
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



A quick question here. Does SND_SOC_DAIFMT_NB_NF have a standard meaning
or does it depend on what mode your in (I2S, DSP_A, right just). From
looking at the sources, SND_SOC_DAIFMT_NB_NF usually means that data is
valid on the rising BCLK and start of frame is rising edge if DSP mode.
The reason I ask, is that I'd like to pass the same flags to the codec and
the cpu_dai and have them agree with the interpretation.


Thanks
Troy
