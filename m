From: Sava Tatic <tictactatic@gmail.com>
Subject: Re: Mackie XD-2 Spike USB Drivers for Linux
Date: Fri, 11 May 2007 13:21:58 +0200
Message-ID: <200705111321.59816.tictactatic@gmail.com>
References: <200705101549.02071.tictactatic@gmail.com>
	<20070510105518.6b1ca72c@jutz-fc6.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.181])
	by alsa0.perex.cz (Postfix) with ESMTP id A25B92448F
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2007 13:22:08 +0200 (CEST)
Received: by ik-out-1112.google.com with SMTP id c28so649723ika
	for <alsa-devel@alsa-project.org>; Fri, 11 May 2007 04:22:08 -0700 (PDT)
In-Reply-To: <20070510105518.6b1ca72c@jutz-fc6.na.corp.dmxmusic.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "John L. Utz III" <john.utz@dmx.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello John,

Thanks so much for your reply. Will fiddle with it as soon as I get back to 
the machine. Sounds very encouraging!

Sava

On Thursday 10 May 2007 19:55:18 you wrote:
> Hello Sava
>
> On Thu, 10 May 2007 15:49:01 +0200
>
> "Sava Tatic" <tictactatic@gmail.com> wrote:
> > Hello,
> >
> > I have been trying to get the Mackie XD-2 Spike
> > (http://www.mackie.com/products/spike/) to work on my Kubuntu Feisty
> > machine, and so far I have only gotten it to play out (I had to use
> > plughw instead of hw). I am using the generic USB drivers that came
> > with the distro. I am having trouble recording anything on the card.
> > Alsamixer (or Kmix) do not see the card. When I do alsamixer -c 1 (0
> > is my onboard card), it returns "no mixer elems found".
> >
> > I am aware that this card is not in the ALSA Matrix of supported
> > cards, but I am wondering what would it take for it to become
> > supported?
>
> USB audio is a standard so it might be incredibly easy to do this
> depending on what mackie did.
>
> if the documentation indicates that it needs no drivers for OSX than
> it's a class compliant device and all you should need to do is find
> it's ID string using lsusp and then stick it into the appropriate array
> in the driver:
>
> [jutz@jutz-fc6 ~]$ /sbin/lsusb
> Bus 002 Device 001: ID 0000:0000
> Bus 001 Device 001: ID 0000:0000
> Bus 003 Device 001: ID 0000:0000
> Bus 005 Device 001: ID 0000:0000
> Bus 004 Device 001: ID 0000:0000
> Bus 004 Device 002: ID 045e:0040 Microsoft Corp. Wheel Mouse Optical
>
> you should be able to find it this way.
>
> if osx needs a driver or loads firmware for it, then it gets more
> complex, but not too complex.
>
> An example of a firmware loading device is the Emagic A26 and A26m. It
> works in linux because it's class compliant after the linux driver loads
> the firmware and then exits(i think it exits!).
>
> > All the best,
> >
> > Sava
> >
> >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
