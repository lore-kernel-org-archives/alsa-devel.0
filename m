From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA Fireworks driver
Date: Tue, 21 Jun 2011 13:38:14 +0200
Message-ID: <4E0082A6.4030502@ladisch.de>
References: <4DFAF3AC.3030506@nostar.net> <4DFAFF24.9000401@ladisch.de>
	<4DFB007E.9090805@nostar.net> <4DFB0643.7070700@ladisch.de>
	<4DFB1F0B.5010201@nostar.net> <4DFB37D7.5030204@ladisch.de>
	<4DFD163D.9050408@nostar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 3D062244B1
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jun 2011 13:38:22 +0200 (CEST)
In-Reply-To: <4DFD163D.9050408@nostar.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Doug McLain <doug@nostar.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Doug McLain wrote:
> It looks like 44.1Khz is the default setting the AF12 powers up at, and
> the alsa driver doesn't know how to change SR yet, is this the case?

Actually, the driver knows quite well how to change SR, and does this to
initialize the device to 44.1 kHz.  However, this driver was intended as
a prototype, so I didn't bother to implement making the other SRs
available to ALSA applications.

> FYI I tried #define FIXED_RATE 48000 just to see if I could use the
> driver at 48K for soem recording sessions today.

This should work if you also change FIXED_RATE_SFC (0...6 = 32/44.1/48/
88.2/96/176.4/192 kHz).

> Aplay plays wav files using plughw, but not hw.

This is to be expected if your .wav doesn't have twelve channels of
32-bit samples.

> I also wonder if you can explain to me how to clone just that driver so
> I can keep up with it correctly using git pull.  I'm a little weak on
> git.  I just grabbed the .c and .h files manually and made my own
> Makefile for standalone module building.

The driver is in a kernel repository because it is part of the kernel;
using it with other kernel versions would require back-porting any
changes in the kernel API (as you did this with the CSR_ symbols).

Current development is in the firewire-kernel-streaming branch, where
the drivers are composed of more files and depend on some changes in
the core kernel.  There is no easy way of using these with another
kernel.


Regards,
Clemens
