From: Ashish Chavan <ashish.chavan@gmail.com>
Subject: Query about regmap SPI
Date: Tue, 6 Mar 2012 12:53:51 +0500
Message-ID: <CAH4H7mPZtJqwYN=ZMp1N9MP0GM0hZhnW+5z1V2-ZwqYba9jAWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A6BB8104071
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 08:53:52 +0100 (CET)
Received: by qcha6 with SMTP id a6so2189751qch.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Mar 2012 23:53:51 -0800 (PST)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@ti.com
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

TIA!
