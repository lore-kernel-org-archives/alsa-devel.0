From: Kunal Singh <kunal@singhkunal.com>
Subject: Re: bandwidth issue with usb-audio in alsa
Date: Tue, 27 May 2008 18:40:31 +0530
Message-ID: <483C0847.1080405@singhkunal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from outbound-mail-35.bluehost.com (outbound-mail-35.bluehost.com
	[69.89.18.155]) by alsa0.perex.cz (Postfix) with SMTP id 3F991243BC
	for <alsa-devel@alsa-project.org>;
	Tue, 27 May 2008 15:10:39 +0200 (CEST)
Received: from [122.167.44.165] (helo=[127.0.0.1])
	by host100.hostmonster.com with esmtpa (Exim 4.68)
	(envelope-from <kunal@singhkunal.com>) id 1K0ywm-0001Yi-Oi
	for alsa-devel@alsa-project.org; Tue, 27 May 2008 07:10:37 -0600
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

Hi,

	I have some update on the issue which I had reported earlier. In my last e-mail, I had not mentioned that iPod is connected to the target through a USB (HS) Hub. When I connect the
same hub to my Desktop and read its configuration using "usbview" - I see that "interval" for this hub is mentioned
as "256 msec". (I have two hubs and I get all the results same with both the hubs).

	With 36 URBs, the gap between two set of transactions is appx 220 msec (220+36 => 256). So, I am wondering
if the problem which I am seeing is because the external hub. I can not connect iPod directly to my target board,
because this board does not support enough current (as needed by iPod).

	Can some one suggest, where is the problem - is it with the host controller driver? 

Regards,
Kunal Singh

-----------------------------

Kunal Singh wrote:

Hi,

  My Platform
 -------------
  I am trying to stream audio data from a USB-device (an iPod) to my
arm-based embedded device (running kernel 2.6.23). The USB-device confirms
to usb digital audio (subclass - streaming) class. The endpoint buffer size
196 bytes and transfer period is 1 msec. So, I should be reading data every
msec.

  Problem
  -----------
  I am facing some bandwidth issues. The data is not being captured fast
enough.

  I notice that once one set of URBs are captured (one set equal to
MAX_URBS), there is a significant delay in capturing the next set of URBs. 

     I have set MAX_URBS equal to 32.
     When I connect a USB-Analyzer and analyze the timings, I can see that
32 URBs are captured at a interval of 1 msec each. After that there is a
break of around 250 msec. And then again 32 URBs captured in sequence.

      If I change the MAX_URBs to any other value N, N URBs get captured at
interval of 1 msec each, and then there is a break.

      Can some one suggest a way to improve this problem. Is there some
configuration or parameter which I can change, so that URBs get submitted
fast enough? May be as soon as the old one has retired.

Thanks and Regards,
Kunal
www.singhkunal.com
