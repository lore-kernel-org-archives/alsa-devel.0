From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [asoc-dev][RFC/PATCH 0/2] Generic DAPM register
	modifier widget
Date: Wed, 25 Jun 2008 14:42:06 +0300
Message-ID: <1214394128-7062-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E5BC24359
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 13:44:11 +0200 (CEST)
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m5PBhirx003548
	for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2008 06:44:08 -0500
Received: from localhost.localdomain (esdhcp04052.research.nokia.com
	[172.21.40.52])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id
	m5PBfm3U019669
	for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2008 14:41:48 +0300
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

At least tlv320aic3x codec has several use cases where multiple register
bits are needed to change when widget power state changes and where
these are not worth/safe to expose into user space. Like mic bias
voltage.

Currently there is one use case for this multiple bit change in tlv320aic3x:

	SND_SOC_DAPM_MICBIAS("Mic Bias AVDD", MICBIAS_CTRL, 6, 0),
	SND_SOC_DAPM_MICBIAS("Mic Bias AVDD", MICBIAS_CTRL, 7, 0),

There are two problems with that:

1. Two widgets having the same name and thus snd_soc_dapm_add_route will
   add only first one them into audio path
2. Even then bits aren't modified at once and thus some fault bit
   configuration might be present while power state is changing.

So I came with this idea of generic register modifiers widget and event
handler for it.


-- 
Jarkko
