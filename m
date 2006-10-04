From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: question about sampling rate
Date: Wed, 04 Oct 2006 14:01:36 +0200
Message-ID: <1159963296.17268.272518382@webmail.messagingengine.com>
References: <54799.217.150.108.178.1152694606.squirrel@newgolddream.dyndns.info>
	<1155315961.10237.268179763@webmail.messagingengine.com>   
	<7034e7b50608302232w2b7279b3qf66acaeca54f1e2b@mail.gmail.com>   
	<1157012237.11592.269833216@webmail.messagingengine.com>   
	<7034e7b50608310122na613dcesf642709d586fbde5@mail.gmail.com>   
	<1157014147.13855.269835275@webmail.messagingengine.com>   
	<7034e7b50608310210h59217352tb99c8189b228a4e3@mail.gmail.com>   
	<7034e7b50608310250w77fe2d21va4b0593b66f5d9d8@mail.gmail.com>   
	<1157021412.24248.269842218@webmail.messagingengine.com>   
	<7034e7b50609190236o5852e98aqa544299cf8f9feb4@mail.gmail.com>   
	<7034e7b50610012053r30cfedb3p3760bb5b4783b388@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 98B94198
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Oct 2006 14:01:36 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <7034e7b50610012053r30cfedb3p3760bb5b4783b388@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Grace Baldonasa <gbaldona@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Grace Baldonasa wrote:
> Can I directly stream the recorded data as playback without going for any
> conversion or anything to the captured data?

Only if both streams use exactly the same sample format/rate.

> I am hearing pure  noise if I am streaming back directly the recorded sound
> that I captured. Is this an expected behaviour?

That may be a different sample format, or possibly just wrong data.

How does the recorded data look like?  Do you have a file or a hexdump?


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
