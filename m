From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: question about sampling rate
Date: Thu, 31 Aug 2006 10:49:07 +0200
Message-ID: <1157014147.13855.269835275@webmail.messagingengine.com>
References: <54799.217.150.108.178.1152694606.squirrel@newgolddream.dyndns.info>
	<20060718071150.GA11917@turing.informatik.uni-halle.de>
	<7034e7b50607180021u5605f818v9c5e55edb1023903@mail.gmail.com>
	<20060718143423.GB15467@turing.informatik.uni-halle.de>
	<7034e7b50607181827u6ddc9cb5s8585978e80a7af9b@mail.gmail.com>
	<20060719122905.GB24800@turing.informatik.uni-halle.de>
	<7034e7b50608091945r39ddaeeevda675f05251be9cb@mail.gmail.com>
	<1155315961.10237.268179763@webmail.messagingengine.com>
	<7034e7b50608302232w2b7279b3qf66acaeca54f1e2b@mail.gmail.com>
	<1157012237.11592.269833216@webmail.messagingengine.com>
	<7034e7b50608310122na613dcesf642709d586fbde5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1828CED
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Aug 2006 10:49:09 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <7034e7b50608310122na613dcesf642709d586fbde5@mail.gmail.com>
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
> What do you mean when you said Windows had converted it to 48000 Hz, you
> mean the audio data itself is converted or just the sampling rate factor
> in the computation.

Windows likes to convert the data to the highest sample rate supported
by the device so that the audio quality doesn't suffer when a stream
with a higher sample rater must be mixed in later.

> When I took a CATC trace using ALSA version, it is also using a fixed 176
> bytes / packet, I am missing something here?

For a 44.1 kHz stream, snd-usb-audio uses packets with both 176 and 180
bytes.


Regards,
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
