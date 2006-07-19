From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: question about sampling rate
Date: Wed, 19 Jul 2006 14:29:05 +0200
Message-ID: <20060719122905.GB24800@turing.informatik.uni-halle.de>
References: <54799.217.150.108.178.1152694606.squirrel@newgolddream.dyndns.info>
	<7034e7b50607120217g2eaace56k5f31054c93839d9f@mail.gmail.com>
	<20060712093749.GA22449@turing.informatik.uni-halle.de>
	<7034e7b50607120300k7cb93e2ak5cf635375d91942c@mail.gmail.com>
	<20060714173102.GA13816@turing.informatik.uni-halle.de>
	<7034e7b50607172213mbde1845occ78b95b17914563@mail.gmail.com>
	<20060718071150.GA11917@turing.informatik.uni-halle.de>
	<7034e7b50607180021u5605f818v9c5e55edb1023903@mail.gmail.com>
	<20060718143423.GB15467@turing.informatik.uni-halle.de>
	<7034e7b50607181827u6ddc9cb5s8585978e80a7af9b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailgate2.urz.uni-halle.de (mailgate2.urz.uni-halle.de
	[141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3EEBA226
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Jul 2006 14:35:44 +0200 (MEST)
In-reply-to: <7034e7b50607181827u6ddc9cb5s8585978e80a7af9b@mail.gmail.com>
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
> yes, i did set the alternate setting. The currrent endpoint should be able
> to handle the stream data since the maxpacketsize is 56, the max sampling
> rate it support is 55kHz, but as I mentioned in my previous email, it's only
> noise that I can hear from the speaker.

What is the output of "lsusb -v" for this device?

> I used a converted raw data in hex format, I am not really sure what is the
> sampling bit, sampling rate or number of channels used when conversion was
> made to the raw data, I am in doubt the sampling bit / channels does  not
> fit with my experimentations.
> 
> Can you recommend some application that will allow me to convert small wav
> to hex as array of characters that I could use to stream.

Some Python script like this:

f = open("something.wav", "rb")
while 1:
	c = f.read(1)
	if not c:
		break
	print "0x%02x," % ord(c)
f.close()


HTH
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
