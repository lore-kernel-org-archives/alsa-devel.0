From: "Feng Ye" <fye@broadcom.com>
Subject: How to support mutiple audio interface in alsa
Date: Wed, 9 Sep 2009 11:50:34 -0700
Message-ID: <9383297B60843144AC17878B479520F110AEC19499@SJEXCHCCR01.corp.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from MMS3.broadcom.com (mms3.broadcom.com [216.31.210.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 1621B244F7
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Sep 2009 20:50:51 +0200 (CEST)
Content-Language: en-US
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
List-Id: alsa-devel@alsa-project.org

Hello there,

This question is for ALSA, not ALSA SOC.
I am doing an ALSA driver for our chip (soc chip with cpu inside), inside it has I2S and DAC. The I2S can be feed to DAC, or come out of the chip to an external CODEC chip.
I wonder how should I model this in the driver, are they multiple ALSA cards, or devices, or subdevices?
Since the I2S is shared, I think the most appropriate is 'subdevice', but I do not see how this is used in linux/sound, this is only used in pci, and seems to tied together with substream number.
If the answer is 'device', is there some existing driver that are doing this?


Thanks,
Feng
