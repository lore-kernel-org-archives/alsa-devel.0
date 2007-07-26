From: Carlo Florendo <subscribermail@gmail.com>
Subject: Re: [LAD] How to get correct midi timings from ALSA
 using the library only
Date: Thu, 26 Jul 2007 12:51:25 +0800
Message-ID: <46A8284D.9020404@gmail.com>
References: <46A5BFDF.4040906@gmail.com>
	<200707241206.09991.mista.tapas@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.hq.astra.ph (unknown [202.78.101.198])
	by alsa0.perex.cz (Postfix) with ESMTP id 752322436E
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Jul 2007 06:51:06 +0200 (CEST)
In-Reply-To: <200707241206.09991.mista.tapas@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: alsa-devel@alsa-project.org, linux-audio-dev@lists.linuxaudio.org
List-Id: alsa-devel@alsa-project.org

Florian Schmidt wrote:
> Another approach, that works very well in my experience, is to not sleep the 
> total required time until the next event, but rather regularly sleep for very 
> short amounts of time (< 1ms), wakeup, measure the current time and if any 
> event time now lies in the past, simply play it back immediately. This way 
> the sleep time doesn't need to be accurate at all. All that's needed is that 
> it's small enough to get some decent timing.

I've now finished implementing this approach, sleeping around 10000 
microseconds instead of  less than 1ms, and it works very well!  Thanks!

I'm getting very decent timing even with complicated MIDI files that have 
numerous pitch bends at very short times.

I'm about to try your other suggestions later on.

Thank you very much.

> 
> Regards,
> Flo
> 

Best Regards,

Carlo


-- 
Carlo Florendo
Softare Engineer/Network Co-Administrator
Astra Philippines Inc.
UP-Ayala Technopark, Diliman 1101, Quezon City
Philippines
http://www.astra.ph

--
The Astra Group of Companies
5-3-11 Sekido, Tama City
Tokyo 206-0011, Japan
http://www.astra.co.jp
