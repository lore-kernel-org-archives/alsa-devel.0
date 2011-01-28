From: <subashchandra.bose@wipro.com>
Subject: configure sampling rate using alsa-utils
Date: Fri, 28 Jan 2011 13:45:06 +0530
Message-ID: <BB839B33747DCE498F4863BA28262B08DDD508@BLR-SJP-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wipro-blr-out02.wipro.com (wipro-blr-out01.wipro.com
	[203.91.198.74]) by alsa0.perex.cz (Postfix) with ESMTP id E550824450
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 09:15:30 +0100 (CET)
Content-class: urn:content-classes:message
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

Hi All,

we are planning to write a driver for GenADC device in ALSA framework. The hardware device is
capable of working in different sampling rate for voice channel, High Speed Channel and low Speed Channel.

I went into ALSA home page, using alsa-utils aplay can be used to configure the sampling rate(eg: aplay -r SNDRV_PCM_RATE_8000)

Can anybody config if this can be used to configure the GenADC device for voice/HighSpeed/Low Speed channels?

Thanks & Regards,
-Subash


Please do not print this email unless it is absolutely necessary. 

The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy all copies of this message and any attachments. 

WARNING: Computer viruses can be transmitted via email. The recipient should check this email and any attachments for the presence of viruses. The company accepts no liability for any damage caused by any virus transmitted by this email. 

www.wipro.com
