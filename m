From: Alex Lee <lee188@singnet.com.sg>
Subject: Re: USB asynchronous mode feedback format
Date: Fri, 15 Oct 2010 21:31:50 +0800
Message-ID: <1287149510.2344.8.camel@desktop-alex>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010151408.30428.julian@jusst.de>
	<1287147135.3429.1.camel@laptop-alex>
	<201010151504.56742.julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp42.singnet.com.sg (smtp42.singnet.com.sg [165.21.103.146])
	by alsa0.perex.cz (Postfix) with ESMTP id 734A1103811
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 15:31:54 +0200 (CEST)
In-Reply-To: <201010151504.56742.julian@jusst.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julian Scheel <julian@jusst.de>
Cc: alsa-devel@alsa-project.org, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-10-15 at 15:04 +0200, Julian Scheel wrote:

> Ah right, thanks.
> Well now I swapped data[1] and data[2]. When monitoring the amount of data I 
> get per read, it is constant at 192bytes, which would be expected for feedback 
> ratio of 48, right? But if I have 0x06 to 0x07 for example I do still get 
> exactly 192bytes per read, shouldn't I get less data in that case? (I always 
> try to read up to MAXPACKETSIZE which is 512, btw)

Suggest:

(1) The feedback rate has to fall withing +/- 10% of the nominal rate.
Otherwise it is ignored.

(2) You need to find out exactly how many samples the host sends you.
Look at my sdr-widget code, for example.  Then you read what the host
sends you.

(3) Do a > dmesg | tail 
    after unplugging and plugging your USB device in.  Then you can see
whether there are any errors in your syncpipe

btw, what is your Linux kernel version?

Alex
