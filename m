From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Query About regmap SPI
Date: Mon, 5 Mar 2012 18:50:58 +0530
Message-ID: <1330953658.20603.27.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 847BE244C9
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 14:09:05 +0100 (CET)
Received: from mail199-ch1 (localhost [127.0.0.1])	by
	mail199-ch1-R.bigfish.com (Postfix) with ESMTP id ABC08220173	for
	<alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 13:09:01 +0000 (UTC)
Received: from CH1EHSMHS005.bigfish.com (snatpool3.int.messaging.microsoft.com
	[10.43.68.229])	by mail199-ch1.bigfish.com (Postfix) with ESMTP id
	D7E05300045	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 13:08:58
	+0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,
  I am planning to add SPI support for da7210 codec driver. SPI for this
codec has slightly different format than others. It has 8 bit register
address and 8 bit data. Out of 8 bits of register address, one bit (i.e.
LSB) is used to indicate read or write. Value of 1 at LSB denotes READ
while value of 0 at LSB denotes write operation.

Thus in order for SPI READ to work correctly, the register address need
to be left shifted by one and then ORed with 0x1. In the same way for
SPI WRITE to work correctly, it need to be left shifted by one.

I have gone though the regmap sources and found that ORing can be
achieved by setting correct read_flag_mask. But I couldn't find anything
by which I can tell regmap core to shift the register address before
ORing it with read_flag_mask. Am I missing anything here?

Is there any other way to achieve this using regmap? The only other way
I can think of is providing a wrapper function to read and write in
codec driver and doing the shifting job inside that wrapper.




This message contains information that may be privileged or confidential and is the property of the KPIT Cummins Infosystems Ltd. It is intended only for the person to whom it is addressed. If you are not the intended recipient, you are not authorized to read, print, retain copy, disseminate, distribute, or use this message or any part thereof. If you receive this message in error, please notify the sender immediately and delete all copies of this message. KPIT Cummins Infosystems Ltd. does not accept any liability for virus infected mails.
