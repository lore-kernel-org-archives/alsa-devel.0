From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: Re: USB Audio questions
Date: Tue, 16 Aug 2011 22:41:01 +0200
Message-ID: <131d4536813.-8375004616171444232.4180326891785246293@zoho.com>
References: <1313432124-22591-1-git-send-email-lars@metafoo.de>	<1313432124-22591-2-git-send-email-lars@metafoo.de>	<000001cc5b8a$4a6577c0$df306740$@bossart@linux.intel.com>
	<4E4A100D.9020302@ladisch.de>
	<000601cc5c2a$87a26350$96e729f0$@bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id DAFAA10383B
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Aug 2011 22:41:07 +0200 (CEST)
In-Reply-To: <000601cc5c2a$87a26350$96e729f0$@bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: 'ALSA Development Mailing List' <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Pierre,

I also spent some time learning about USB and audio while developing the sound/usb/6fire driver. I made the following discoveries:

>What I had in mind is a case where the ring buffer is divided in separate 
>periods, which would each correspond to an integer number of URBs/packets. 
>This way there is _never_ a case of wrap-around and no need for memcpys. 
>It's probably less generic than the current driver but a whole lot 
>simpler/efficient. 

I was also not very happy to implement the double buffering with memcpy's. But from the experience with the 6fire device I can say this:

- The device/driver sends per urb a constant number of packets (as you already also discovered). The number of samples per packet differ however (+- 1 sample per packet). I accuse the asynchronousity between the urb interval and the sound card's internal clock for this fact. The device expects the driver to send back an urb with exactly the same structure. The device produced crackling noise if the samples per packet were not equal. I cannot say to what extend this is true (i.e. if you could wait some packets until catching up the difference without producing crackles) but due to this fact it's at least not a simple task to send urbs exactly corresponding to the period limit.

- Another thing came into my mind while reading your post, but I'm not sure if that would apply in praxis: If sending an urb is scheduled with the alsa buffer, it might be possible that the buffer is overwritten before the urb is sent, leading to complete audio-rubbish.

- And: at least the 6fire requires a header for each packet, which couldn't be placed directly in the alsa buffer. But perhaps this doesn't apply to most cards.

Greets,
Torsten
