From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Need help diagnosing "hw_ptr skipping" message
Date: Tue, 16 Jul 2013 15:45:38 +0200
Message-ID: <51E54E82.5030402@topic.nl>
References: <51824609.30405@canonical.com> <1367498241.8766.3.camel@localhost>
 <5182746C.1070603@topic.nl> <5187AEA5.1020108@ladisch.de>
 <51A49907.70105@topic.nl> <20130529194211.GB5180@sirena.org.uk>
 <51A84AC2.5070702@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atl4mhob05.myregisteredsite.com
 (atl4mhob05.myregisteredsite.com [209.17.115.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AB43264F8F
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 15:45:41 +0200 (CEST)
Received: from mailpod.hostingplatform.com ([10.30.71.210])
 by atl4mhob05.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id
 r6GDjdEJ013789
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 09:45:39 -0400
In-Reply-To: <51A84AC2.5070702@topic.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The sort form of my question:

If I enable the "jiffies check", what is my driver doing wrong if I get 
this complaint on the kernel log while capturing:

PCM: hw_ptr skipping! (pos=13677, delta=876, period=6400, jdelta=0/17/0, 
hw_ptr=1241601/1241601)


The context:

I notice that this message originates at pcm_lib.c. I've been looking at 
that code for a while, but cannot figure out what its purpose is.

if (((hdelta * HZ) / runtime->rate) > jdelta + HZ/100) ...

If that evaluates to "true", the logging as shown above is being shown.

But I can't grasp the meaning here. What's wrong then? I'd suspect it 
checks on the number of samples reported and the time elapsed, but I 
cannot figure out what the criteria is.

Not I did a bit of adding my own logging, so that I could also see 
whether things were at the IRQ or at "user" side of things, using a 
"[Q]" to indicate interrupt routine handling.

A normal overrun looks like this:

hwptr log: pcmC6D0c:0 [ ]: j=4294875206, pos=997/6400/25600, 
hwptr=8166401/8166400
hwptr log: pcmC6D0c:0 [Q]: j=4294875311, pos=6401/6400/25600, 
hwptr=8167397/8166400
hwptr log: pcmC6D0c:0 [ ]: j=4294875331, pos=7414/6400/25600, 
hwptr=8172801/8166400
hwptr log: pcmC6D0c:0 [Q]: j=4294875436, pos=12801/6400/25600, 
hwptr=8173814/8166400
hwptr log: pcmC6D0c:0 [ ]: j=4294875550, pos=18633/6400/25600, 
hwptr=8179201/8166400
hwptr log: pcmC6D0c:0 [Q]: j=4294875561, pos=19200/6400/25600, 
hwptr=8185033/8166400
hwptr log: pcmC6D0c:0 [Q]: j=4294875686, pos=2/6400/25600, 
hwptr=8185600/8166400
hwptr log: pcmC6D0c:0 [Q]: j=4294875811, pos=6401/6400/25600, 
hwptr=8192002/8192000
hwptr log: pcmC6D0c:0 [Q]: j=4294875936, pos=12802/6400/25600, 
hwptr=8198401/8192000
hwptr log: pcmC6D0c:0 [Q]: j=4294876061, pos=19208/6400/25600, 
hwptr=8204802/8192000
XRUN: pcmC6D0c:0

In this case, there were 4 periods of 6400 samples in the buffer, and 5 
period-completion interrups were issued between userspace reads, so this 
is a normal case of the user not emptying the buffer quick enough.

The events I'm worried about are these:

hwptr log: pcmC6D0c:0 [ ]: j=4294960399, pos=7646/6400/25600, 
hwptr=953600/947200
hwptr log: pcmC6D0c:0 [Q]: j=4294960500, pos=12800/6400/25600, 
hwptr=954846/947200
hwptr log: pcmC6D0c:0 [ ]: j=4294960553, pos=15511/6400/25600, 
hwptr=960000/947200
hwptr log: pcmC6D0c:0 [Q]: j=4294960625, pos=19200/6400/25600, 
hwptr=962711/947200
hwptr log: pcmC6D0c:0 [ ]: j=4294960648, pos=20377/6400/25600, 
hwptr=966400/947200
hwptr log: pcmC6D0c:0 [Q]: j=4294960750, pos=0/6400/25600, 
hwptr=967577/947200
hwptr log: pcmC6D0c:0 [Q]: j=4294960875, pos=6400/6400/25600, 
hwptr=972800/972800
hwptr log: pcmC6D0c:0 [Q]: j=4294961000, pos=12800/6400/25600, 
hwptr=979200/972800
hwptr log: pcmC6D0c:0 [Q]: j=4294961125, pos=19201/6400/25600, 
hwptr=985600/972800
hwptr log: pcmC6D0c:0 [Q]: j=4294961250, pos=0/6400/25600, 
hwptr=992001/972800
XRUN: pcmC6D0c:0
hwptr log: pcmC6D0c:0 [Q]: j=9186, pos=6401/6400/25600, hwptr=718334/716800
hwptr log: pcmC6D0c:0 [ ]: j=9206, pos=7382/6400/25600, hwptr=723201/716800
hwptr log: pcmC6D0c:0 [Q]: j=9311, pos=12802/6400/25600, hwptr=724182/716800
hwptr log: pcmC6D0c:0 [ ]: j=9345, pos=14498/6400/25600, hwptr=729602/716800
hwptr log: pcmC6D0c:0 [Q]: j=9436, pos=19200/6400/25600, hwptr=731298/716800
hwptr log: pcmC6D0c:0 [ ]: j=9471, pos=20989/6400/25600, hwptr=736000/716800
hwptr log: pcmC6D0c:0 [Q]: j=9561, pos=0/6400/25600, hwptr=737789/716800
hwptr log: pcmC6D0c:0 [ ]: j=9588, pos=1368/6400/25600, hwptr=742400/742400
hwptr log: pcmC6D0c:0 [Q]: j=9686, pos=6401/6400/25600, hwptr=743768/742400
hwptr log: pcmC6D0c:0 [ ]: j=9686, pos=7271/6400/25600, hwptr=748801/742400
PCM: hw_ptr skipping! (pos=7271, delta=870, period=6400, jdelta=0/16/0, 
hw_ptr=748801/748801)
hwptr log: pcmC6D0c:0 [Q]: j=18810, pos=12801/6400/25600, 
hwptr=1211784/1203200
hwptr log: pcmC6D0c:0 [ ]: j=18840, pos=14327/6400/25600, 
hwptr=1216001/1203200
hwptr log: pcmC6D0c:0 [Q]: j=18935, pos=19201/6400/25600, 
hwptr=1217527/1203200
hwptr log: pcmC6D0c:0 [ ]: j=18967, pos=20807/6400/25600, 
hwptr=1222401/1203200
hwptr log: pcmC6D0c:0 [Q]: j=19060, pos=0/6400/25600, hwptr=1224007/1203200
hwptr log: pcmC6D0c:0 [ ]: j=19088, pos=1402/6400/25600, 
hwptr=1228800/1228800
hwptr log: pcmC6D0c:0 [Q]: j=19185, pos=6400/6400/25600, 
hwptr=1230202/1228800
hwptr log: pcmC6D0c:0 [ ]: j=19213, pos=7801/6400/25600, 
hwptr=1235200/1228800
hwptr log: pcmC6D0c:0 [Q]: j=19310, pos=12801/6400/25600, 
hwptr=1236601/1228800
hwptr log: pcmC6D0c:0 [ ]: j=19310, pos=13677/6400/25600, 
hwptr=1241601/1228800
PCM: hw_ptr skipping! (pos=13677, delta=876, period=6400, jdelta=0/17/0, 
hw_ptr=1241601/1241601)


Anyone can make heads or tails of this?

Kind regards,
Mike.
