From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: alsa or jack?
Date: Tue, 06 Aug 2002 00:02:06 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D4E936E.9010201@boosthardware.com>
References: <8724.1028549182@www15.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www7.networkshosting.com ([66.96.128.106])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id QAA28853
	for <alsa-devel@alsa-project.org>; Mon, 5 Aug 2002 16:57:52 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: sion@gmx.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

sion@gmx.de wrote:
> Hi,
> 
> I'm going to write a program whitch should get the audio-data from 8-10 mono
> audio channels, and for example save it to a file. Latency is absolutely no
> problem, but xruns wouldn't be very nice.
> My questions: 
> 1. Should I use ALSA directly or via Jack? I remember some people saying
> Jack would be easyier. Can Jack handle 10 channels?
> 2. Is it always (i.e. with all soundcards) possible to open the channels in
> non-interleaved-mode?
> 
> Thanks,
>  Florian Bartels
> 

JACK can allow you to access multiple channels (pcm devices). The main 
reasons for using JACK as the default interface are that people who use 
your app will be able to interact with other apps that support JACK and 
it will also allow you to get low latency audio performance which is 
pretty much neccessary for more than two channels.

It has also been reported many times that designing around JACK is 
easier than using ALSA directly because you don't have to worry about 
hardware level problems anymore as JACK takes care of that for you. 
People also say that the code is very well set out and easy to read once 
you grasp the basic concepts.

Also, If you write your app to access ALSA directly and in the future 
you decide you would like JACK support, unless you have designed your 
app around the callback principal you will find it a diffcult task to 
rewrite your code to work with JACK. If you start with JACK now then 
your app will use ALSA anyway.



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
