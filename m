From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: question about sampling rate
Date: Tue, 18 Jul 2006 09:11:50 +0200
Message-ID: <20060718071150.GA11917@turing.informatik.uni-halle.de>
References: <7034e7b50607120105s67644513ned098c960d9ac22b@mail.gmail.com>
	<54799.217.150.108.178.1152694606.squirrel@newgolddream.dyndns.info>
	<7034e7b50607120217g2eaace56k5f31054c93839d9f@mail.gmail.com>
	<20060712093749.GA22449@turing.informatik.uni-halle.de>
	<7034e7b50607120300k7cb93e2ak5cf635375d91942c@mail.gmail.com>
	<20060714173102.GA13816@turing.informatik.uni-halle.de>
	<7034e7b50607172213mbde1845occ78b95b17914563@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailgate2.urz.uni-halle.de (mailgate2.urz.uni-halle.de
	[141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0F61417C
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 09:13:15 +0200 (MEST)
In-reply-to: <7034e7b50607172213mbde1845occ78b95b17914563@mail.gmail.com>
Content-disposition: inline
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
> I am using Philips Speaker with MaxPackSize = 56, channel = 2,
> sampling bits =16, so I decided to change my framesize:
> 
> 11025 /1000 * 2 * 16/8 / ms -> 44,

44.1

> this time, I cant understand the music out.

How did you set the sample format?  Are there endpoint-specific
controls?

> The endpoint should still be able to handle it since data rate is
> lesser than maxpacksize.

How do you handle the fractional part of the frame size?

Is this an adaptive endpoint, or what synchronization type does it have?


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
