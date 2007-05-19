From: Rene Herman <rene.herman@gmail.com>
Subject: Re: Can someone verify support for "AzTech
 Sound	Galaxy Nova 16 Extra II-3D - using AZT-2316/R Chipset
 -	FCC-ID:I38-MMSN846" ?
Date: Sat, 19 May 2007 04:55:12 +0200
Message-ID: <464E6710.4000909@gmail.com>
References: <20070513101757.8C8191BF23B@ws1-1.us4.outblaze.com>
	<4648DA4E.8050107@gmail.com> <4648E10B.4010403@gmail.com>
	<20070515101259.GS5690@sygehus.dk> <464B955F.3030508@gmail.com>
	<20070517130811.GY5690@sygehus.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 1146E2445B
	for <alsa-devel@alsa-project.org>;
	Sat, 19 May 2007 04:57:55 +0200 (CEST)
In-Reply-To: <20070517130811.GY5690@sygehus.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rask Ingemann Lambertsen <rask@sygehus.dk>
Cc: alsa-devel@alsa-project.org, ramkromberg@mail.com
List-Id: alsa-devel@alsa-project.org

On 05/17/2007 03:08 PM, Rask Ingemann Lambertsen wrote:

> I've found the X24C00 chip, a 12 MHz crystal or oscilator (I'm not sure 
> which) and an Intel S-80C51FANM chip. The uncommented jumpers J1 and J2
> are my best bet, although they are connected to the AZTSSPT0592 chip.

Right, so you also have that one. Also the AZT-NXPMIX0592? If so, then your 
NX Pro is just my NX Pro 16 minus the AD1848 codec it seems.

If J1 and J2 are connected to pin 17 and 18 at the top (the side which is 
"up" when you can read the markings) of the AZTSSPT0592 then those will be 
my J4/J5. Also unmarked, but I have the booklet!

If they're the same, then you should have a "virtual parallel port" at 0x278 
when they're closed for "Disney Sound Source" compatibility.

If I find out this NX Pro 16 is software configurable, I'll send you test 
code for your NX Pro...

Rene.
