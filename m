From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: question about sampling rate
Date: Fri, 14 Jul 2006 19:31:02 +0200
Message-ID: <20060714173102.GA13816@turing.informatik.uni-halle.de>
References: <7034e7b50607120105s67644513ned098c960d9ac22b@mail.gmail.com>
	<54799.217.150.108.178.1152694606.squirrel@newgolddream.dyndns.info>
	<7034e7b50607120217g2eaace56k5f31054c93839d9f@mail.gmail.com>
	<20060712093749.GA22449@turing.informatik.uni-halle.de>
	<7034e7b50607120300k7cb93e2ak5cf635375d91942c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailgate2.urz.uni-halle.de (mailgate2.urz.uni-halle.de
	[141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 706BB177
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Jul 2006 19:31:35 +0200 (MEST)
In-reply-to: <7034e7b50607120300k7cb93e2ak5cf635375d91942c@mail.gmail.com>
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
> After computing the rate, value could be of decimal format,

In the computer, all values are binary.

> is it rounded off to either equal or greater than the whole number
> itself?

There is no whole number, it is interpreted as a number with 16 binary
fractional digits.

> subs->freqmax = subs->freqn + (subs->freqn >> 2);
> Q: why is subs->freqn shifted by 2

It's just subs->freqn plus 25 percent, and that is just some random
value that should be safe enough for any real sample clock.

> subs->phase = 0;
> /* calculate the max. size of packet */
> maxsize = ((subs->freqmax + 0xffff) * (frame_bits >> 3)) >> 16;
> 
> Q: why subs->freqmax is added with 0xffff, then frame_bits is shifted by 3
> then the whole thing shifted by 16.

It's shifted by 16 to throw away the fractional digits; we calculate
whole bytes.
"frame_bits/8" is the number of bytes per frame.
Adding 0xffff ensures that despite the truncation by the final shift,
the value is rounded up.


HTH
Clemens


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
