From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Forcing an absolute timestamp for every midi event.
Date: Sun, 18 Aug 2002 19:08:26 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D5F721A.1000705@boosthardware.com>
References: <20020818055740.2af8e3e7.coding@reduz.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www7.networkshosting.com (www7.networkshosting.com [66.96.128.106])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id MAA30799
	for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2002 12:03:32 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Juan Linietsky <coding@reduz.com.ar>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Juan Linietsky wrote:
> Hi! I wanted to ask, how about forcing
> an absolute timestamp for _every_ midi event?
> I think this would be great for softsynths,
> so they dont need to work with root/schedfifo/lowlatency
> to have a decent timing. Not allways you are willing
> to process midi at the lowest latency possible.
> I say because you dont really need all that if you
> sequence in the computer and control softsynths and maybe
> some external device. 
> This way, the softsynth gets the event with the timestamp,
> gets the current time, substracts the audio delay (latency) to that
> and just mixes internally in smaller blocks processing each 
> event in the right time.
> 

Yesterday Juan gave me an example of the difference between having this 
and not and it is absolutely clear that the sound quality is better. I 
think many users would appreciate the difference even if they wouldn't 
know why.

Currently if users want to get this kind of quality they have to have 
root access so it will be less hassle to have it available from user space.

It will also make ALSA one step more advanced :)


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
