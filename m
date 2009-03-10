From: Timur Tabi <timur@freescale.com>
Subject: Accuracy of substream->ops->pointer?
Date: Tue, 10 Mar 2009 15:05:11 -0500
Message-ID: <49B6C7F7.2090800@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id A5576103861
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2009 21:05:14 +0100 (CET)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n2AK5C1V021826
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2009 13:05:12 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n2AK5BxK029681
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2009 15:05:11 -0500 (CDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

During capture, my hardware can take up to two milliseconds for the DMA
to start transferring data to the buffer.  This is because the internal
FIFO needs to fill up before DMA starts.

Today, my .trigger function (during a START request) just waits until
the FIFO is full before returning control back to ALSA.  This seems to
work, except that I wait by using a busy-loop.  As you can imagine, a
2ms busy loop is not a good idea.

An alternative idea is to have my .pointer function return 0 if DMA has
not yet started.  This appears to work, but I want to make sure it's a
good idea.

My concern is that I might confuse ALSA because it is expecting some
data in the buffer after capture has started.  Is my approach correct?

-- 
Timur Tabi
Linux kernel developer at Freescale
