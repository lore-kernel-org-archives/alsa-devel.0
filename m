From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Accuracy of substream->ops->pointer?
Date: Wed, 11 Mar 2009 09:20:20 +0100
Message-ID: <49B77444.6070104@ladisch.de>
References: <49B6C7F7.2090800@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 9A3C410383E
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 09:20:19 +0100 (CET)
In-Reply-To: <49B6C7F7.2090800@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> During capture, my hardware can take up to two milliseconds for the DMA
> to start transferring data to the buffer.  This is because the internal
> FIFO needs to fill up before DMA starts.
> 
> Today, my .trigger function (during a START request) just waits until
> the FIFO is full before returning control back to ALSA.  This seems to
> work, except that I wait by using a busy-loop.  As you can imagine, a
> 2ms busy loop is not a good idea.

Especially as the trigger callback is called inside a spinlock with
interrupts disabled.

> An alternative idea is to have my .pointer function return 0 if DMA has
> not yet started.  This appears to work, but I want to make sure it's a
> good idea.
> 
> My concern is that I might confuse ALSA because it is expecting some
> data in the buffer after capture has started.  Is my approach correct?

0 is the only value that you can return in this situation, because any
other value would imply that the buffer actually contains some valid
data.

The USB driver has bigger delays when starting, and it works.


HTH
Clemens
