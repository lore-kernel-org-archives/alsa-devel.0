From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: question about sampling rate
Date: Wed, 12 Jul 2006 11:37:49 +0200
Message-ID: <20060712093749.GA22449@turing.informatik.uni-halle.de>
References: <7034e7b50607120105s67644513ned098c960d9ac22b@mail.gmail.com>
	<54799.217.150.108.178.1152694606.squirrel@newgolddream.dyndns.info>
	<7034e7b50607120217g2eaace56k5f31054c93839d9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailgate2.urz.uni-halle.de (mailgate2.urz.uni-halle.de
	[141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 74755226
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Jul 2006 11:38:00 +0200 (MEST)
In-reply-to: <7034e7b50607120217g2eaace56k5f31054c93839d9f@mail.gmail.com>
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
> /*
> * convert a sampling rate into our full speed format (fs/1000 in Q16.16)
> * this will overflow at approx 524 kHz
> */
> inline static unsigned get_usb_full_speed_rate(unsigned int rate)
> {
> return ((rate << 13) + 62) / 125;
> }
> 
> I have no clue as to why rate was shifted by 13 then added by 62 then
> divided by 125.

The parameter is in Hz.  To convert to the number of samples per USB
frame, we have to divide by 1000.  To convert to a 16.16-fixed-point
number, we have to multiply by 2^16.  This would result in "rate *
0x10000 / 1000".  Factoring out 8 yields "rate * 0x2000 / 125".  The
multiplication by a power of two can be replaced by a bitwise left
shift.  The "+62" prevents the division from rounding down.


HTH
Clemens


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
