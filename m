From: Laurent Pinchart <laurent.pinchart@skynet.be>
Subject: Avoiding buffer underruns in the hardware interrupt
	handler
Date: Wed, 13 May 2009 23:24:25 +0200
Message-ID: <200905132324.26334.laurent.pinchart@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perceval.irobotique.be (perceval.irobotique.be [92.243.18.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 314FD24858
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 23:21:01 +0200 (CEST)
Received: from ravenclaw.localnet (153.132-240-81.adsl-dyn.isp.belgacom.be
	[81.240.132.153])
	by perceval.irobotique.be (Postfix) with ESMTPSA id 4856D35B22
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 21:20:56 +0000 (UTC)
Content-Disposition: inline
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

Hi everybody.

Disclaimer: I'm new with ALSA development and I'm trying to digest the large 
amount of information I'm overflowed with, so please bear with possibly stupid 
help requests.

I'm writing an ALSA driver for a playback device. Unlike most sound cards, 
this device uses private memory for its audio buffer. I thus need to manually 
copy data from the ALSA buffer to the device buffer in the driver.

The device audio buffer is quite small, and for this reason I'd rather not use 
the copy/silence callbacks, but copy data from the ALSA buffer to the device 
in interrupt.

The device might generate interrupts a bit faster than what would be expected 
from sampling rate, so I need to check in the interrupt handler how much data 
the ALSA buffer holds. To do so I need to maintain a "hardware pointer" in the 
driver and to access the "user pointer" on the other side of the buffer.

I haven't found a clear API to access that second pointer. What is the 
best/preferred way to find out how much data the ALSA buffer holds ? I suppose 
I will need to perform some locking when accessing the "user pointer", I will 
also appreciate advices regarding which mutex/spinlock I should use for that 
purpose.

Best regards,

Laurent Pinchart
