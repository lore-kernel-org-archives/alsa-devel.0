From: "Steve Spano" <steve@fl-eng.com>
Subject: ### Question on HW Pointer
Date: Tue, 5 Oct 2010 20:35:15 -0400
Message-ID: <001201cb64ee$5beec5c0$13cc5140$@fl-eng.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homiemail-a46.g.dreamhost.com (caibbdcaaaaf.dreamhost.com
	[208.113.200.5])
	by alsa0.perex.cz (Postfix) with ESMTP id CFA0110382C
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Oct 2010 02:35:36 +0200 (CEST)
Received: from homiemail-a46.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a46.g.dreamhost.com (Postfix) with ESMTP id 056F63E406A
	for <alsa-devel@alsa-project.org>; Tue,  5 Oct 2010 17:35:36 -0700 (PDT)
Received: from FLEXENON (rrcs-24-39-243-78.nys.biz.rr.com [24.39.243.78])
	(Authenticated sender: steve@fl-eng.com)
	by homiemail-a46.g.dreamhost.com (Postfix) with ESMTPA id 8C4A63E4065
	for <alsa-devel@alsa-project.org>; Tue,  5 Oct 2010 17:35:35 -0700 (PDT)
Content-Language: en-us
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

Hello Folks,

 

I am wondering if someone can help clarify how the hw pointer is used by the
ALSA layer.

I have a 24 channel soundcard that we have developed, using a Xilinx fpga.

The system is working, in that I can receive inbound samples on all 24
inputs and transmit samples on all 24 outputs.

 

But something isn't completely right.

 

We can xrun's and reports of very high cpu utilization.even though I know we
are in and out of our interrupts within 100uS for a 2.7mS interrupt period.

Interesting that our xruns cite a "0mS delay" or sometimes a 4mS delay (1.5
periods?)

 

I think the issue has to do with how we are presenting the response to the
hw-pointer request OR how/when we are calling the pcm_snd_elapsed.

 

I think the flow should be as follows (lets consider the dac part)

 

Step #1 ) interrupt occurs

Step #2) dma/transfer begins as kicked off in interrupt routine

Step #3) we advance the buffer pointer for the alsa buffer

Step #4) we exit the interrupt

. then the hardware should start advancing its pointer as it is reading the
new samples

.. then sometime later, the alsa layer calls the "hw_pointer" function

And then we return the current value of the hardware pointer from the board?
So alsa knows how many samples the board has processed from the interrupt?

 

We should be pretty close, because it is working for the most part..but I
think this pointer is not right. 

 

Can someone explain how this pointer/etc is supposed to flow and what alsa
may be using it for? Maybe some latency calculation in a an upper layer?

 

Thanks again

 

Steve Spano
