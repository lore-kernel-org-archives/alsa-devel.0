From: "John L. Utz III" <john.utz@dmx.com>
Subject: Re: Mackie XD-2 Spike USB Drivers for Linux
Date: Thu, 10 May 2007 10:55:18 -0700
Message-ID: <20070510105518.6b1ca72c@jutz-fc6.na.corp.dmxmusic.com>
References: <200705101549.02071.tictactatic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A8DD243CF
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 19:53:22 +0200 (CEST)
In-Reply-To: <200705101549.02071.tictactatic@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sava Tatic <tictactatic@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Sava

On Thu, 10 May 2007 15:49:01 +0200
"Sava Tatic" <tictactatic@gmail.com> wrote:

> Hello,
> 
> I have been trying to get the Mackie XD-2 Spike 
> (http://www.mackie.com/products/spike/) to work on my Kubuntu Feisty
> machine, and so far I have only gotten it to play out (I had to use
> plughw instead of hw). I am using the generic USB drivers that came
> with the distro. I am having trouble recording anything on the card.
> Alsamixer (or Kmix) do not see the card. When I do alsamixer -c 1 (0
> is my onboard card), it returns "no mixer elems found". 
> 
> I am aware that this card is not in the ALSA Matrix of supported
> cards, but I am wondering what would it take for it to become
> supported? 

USB audio is a standard so it might be incredibly easy to do this
depending on what mackie did.

if the documentation indicates that it needs no drivers for OSX than
it's a class compliant device and all you should need to do is find
it's ID string using lsusp and then stick it into the appropriate array
in the driver:

[jutz@jutz-fc6 ~]$ /sbin/lsusb 
Bus 002 Device 001: ID 0000:0000  
Bus 001 Device 001: ID 0000:0000  
Bus 003 Device 001: ID 0000:0000  
Bus 005 Device 001: ID 0000:0000  
Bus 004 Device 001: ID 0000:0000  
Bus 004 Device 002: ID 045e:0040 Microsoft Corp. Wheel Mouse Optical

you should be able to find it this way.

if osx needs a driver or loads firmware for it, then it gets more
complex, but not too complex.

An example of a firmware loading device is the Emagic A26 and A26m. It
works in linux because it's class compliant after the linux driver loads
the firmware and then exits(i think it exits!).

> All the best,
> 
> Sava
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
