From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: question about sampling rate
Date: Tue, 18 Jul 2006 16:34:23 +0200
Message-ID: <20060718143423.GB15467@turing.informatik.uni-halle.de>
References: <7034e7b50607120105s67644513ned098c960d9ac22b@mail.gmail.com>
	<54799.217.150.108.178.1152694606.squirrel@newgolddream.dyndns.info>
	<7034e7b50607120217g2eaace56k5f31054c93839d9f@mail.gmail.com>
	<20060712093749.GA22449@turing.informatik.uni-halle.de>
	<7034e7b50607120300k7cb93e2ak5cf635375d91942c@mail.gmail.com>
	<20060714173102.GA13816@turing.informatik.uni-halle.de>
	<7034e7b50607172213mbde1845occ78b95b17914563@mail.gmail.com>
	<20060718071150.GA11917@turing.informatik.uni-halle.de>
	<7034e7b50607180021u5605f818v9c5e55edb1023903@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailgate2.urz.uni-halle.de (mailgate2.urz.uni-halle.de
	[141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1893D19A
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 16:34:56 +0200 (MEST)
In-reply-to: <7034e7b50607180021u5605f818v9c5e55edb1023903@mail.gmail.com>
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
> I am not yet handling the fractional part of frame size, would it be cause
> of the distorted sound?

There shouldn't be too much noise in this case.

> The endpoint says, adaptive synchrnonization,

Then it should be able to handle a frequency that is 0.25% off.

> >How did you set the sample format?  Are there endpoint-specific
> >controls?
> 
> no endpoint specific control is set. sample format is based on the max
> sampling frequency from the format descriptor.

Did you set the altsetting, or how does the device know about the
current sample format?


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
