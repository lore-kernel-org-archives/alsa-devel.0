From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: question about sampling rate
Date: Fri, 11 Aug 2006 19:06:01 +0200
Message-ID: <1155315961.10237.268179763@webmail.messagingengine.com>
References: <54799.217.150.108.178.1152694606.squirrel@newgolddream.dyndns.info>
	<20060712093749.GA22449@turing.informatik.uni-halle.de>
	<7034e7b50607120300k7cb93e2ak5cf635375d91942c@mail.gmail.com>
	<20060714173102.GA13816@turing.informatik.uni-halle.de>
	<7034e7b50607172213mbde1845occ78b95b17914563@mail.gmail.com>
	<20060718071150.GA11917@turing.informatik.uni-halle.de>
	<7034e7b50607180021u5605f818v9c5e55edb1023903@mail.gmail.com>
	<20060718143423.GB15467@turing.informatik.uni-halle.de>
	<7034e7b50607181827u6ddc9cb5s8585978e80a7af9b@mail.gmail.com>
	<20060719122905.GB24800@turing.informatik.uni-halle.de>
	<7034e7b50608091945r39ddaeeevda675f05251be9cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 21D41171
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Aug 2006 19:06:04 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <7034e7b50608091945r39ddaeeevda675f05251be9cb@mail.gmail.com>
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
> I am half way my development. I can stream music using dynamic settings (any
> speaker plugged in to my host be heard of some music when my application is
> streaming some audio data). However, there are still background noise I am
> hearing. Here is how I computed my streaming size:
> 
> sampling rate = 44100
> channel = 2
> bit resolution = 16
> period length = 20 ms
> period size = 3528

bytes

> This period size is used as my buffer size, and this is sliced as it is
> streamed to my device.
> I have not considered any sychronization yet. Here is the speaker
> configuration:
> Synchronization type = adaptive sync
> 
> My understanding is no sync pipe is defined  by the device, therefore I dont
> need to schedule any sync data, am I correct?

Yes.  An adaptive endpoint should be able to work with any sample rate,
as long as it's near 44100.

How do you slice your buffer?


Regards,
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
