From: Julian Scheel <julian@jusst.de>
Subject: Re: USB asynchronous mode feedback format
Date: Fri, 15 Oct 2010 16:24:46 +0200
Message-ID: <201010151624.46800.julian@jusst.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010151504.56742.julian@jusst.de>
	<1287149510.2344.8.camel@desktop-alex>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.work.de (smtp.work.de [212.12.45.188])
	by alsa0.perex.cz (Postfix) with ESMTP id BFD8010389D
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 16:24:48 +0200 (CEST)
In-Reply-To: <1287149510.2344.8.camel@desktop-alex>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Alex Lee <lee188@singnet.com.sg>, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

Am Freitag, 15. Oktober 2010, 15:31:50 schrieb Alex Lee:
> On Fri, 2010-10-15 at 15:04 +0200, Julian Scheel wrote:
> > Ah right, thanks.
> > Well now I swapped data[1] and data[2]. When monitoring the amount of
> > data I get per read, it is constant at 192bytes, which would be expected
> > for feedback ratio of 48, right? But if I have 0x06 to 0x07 for example
> > I do still get exactly 192bytes per read, shouldn't I get less data in
> > that case? (I always try to read up to MAXPACKETSIZE which is 512, btw)
> 
> Suggest:
> 
> (1) The feedback rate has to fall withing +/- 10% of the nominal rate.
> Otherwise it is ignored.

Ok. I tried it with 0x5e, which should be 47. Still same amount of data being 
fed in.

> (2) You need to find out exactly how many samples the host sends you.
> Look at my sdr-widget code, for example.  Then you read what the host
> sends you.

Actually I checked your code and it seems quite similiar to mine. I use the 
at91lib for USB stuff, so the capsulation is a bit different. I call a 
function USBD_Read, which does read up to the given amount of bytes (in my 
case max 512) or the receivement of a short packet.
Each packet I receive by reading with USBD_Read is exactly 192bytes long. As I 
won't be able to get more than 1 packet per USB frame, I should be receiving 
1000 * 192bytes per second. No matter what I write to the feedback pipe. which 
is kinda odd.

> (3) Do a > dmesg | tail
>     after unplugging and plugging your USB device in.  Then you can see
> whether there are any errors in your syncpipe

Don't see any syncpipe related errors. Only thing I see is:
usb 1-1.3: new full speed USB device using ehci_hcd and address 11
11:1:1: endpoint lacks sample rate attribute bit, cannot set.
11:1:1: endpoint lacks sample rate attribute bit, cannot set.

Does not seem to be feedback related... Although it would be nice to know, 
what's wrong there?

> btw, what is your Linux kernel version?

2.6.35.7-1 (archlinux, 32bit)

Is there any way to get some more verbosity out of alsa drivers? To check if 
it really receives the feedback information at all.

Regards,
Julian
