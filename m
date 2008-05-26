From: Charles Eidsness <charles.eidsness@ieee.org>
Subject: Re: USB Data Dropping
Date: Mon, 26 May 2008 14:45:36 -0400
Message-ID: <483B0550.8090505@ieee.org>
References: <48353DEE.1020502@atmel.com>
	<48355305.1090808@ladisch.de>	<4836D447.5030903@atmel.com>
	<4836E5FD.1080507@ieee.org>
Reply-To: charles.eidsness@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp105.rog.mail.re2.yahoo.com (smtp105.rog.mail.re2.yahoo.com
	[206.190.36.83]) by alsa0.perex.cz (Postfix) with SMTP id 7FDA224928
	for <alsa-devel@alsa-project.org>;
	Mon, 26 May 2008 20:45:48 +0200 (CEST)
In-Reply-To: <4836E5FD.1080507@ieee.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Charles Eidsness wrote:
> Hi All,
> 
> I'm developing a USB DAC and I've ran into an issue that has me scratching my 
> head. Every once in a while (30 seconds or so) my USB DAC gets sent a USB frame 
> that's missing a few samples, unless I'm also streaming audio through my 
> laptop's built-in audio interface, i.e. playing audio through my USB DAC alone 
> and I get dropped data, playing audio through my USB DAC and the built-in audio 
> device at the same time (unique streams to each device) and I get no dropped 
> data to my USB DAC. Once I stop playing audio on the built-in device I start 
> getting dropped data to my USB DAC again.
> 

I'm still not completely sure what's going on but if I turn off acpi support in 
the kernel I no longer have this issue. I guess there's some sort of unexpected 
IRQ interaction. Strangely setting acpi=noirq doesn't solve the problem so maybe 
it's related to interrupts that ACPI is throwing up. It may just be related to 
the configuration of my laptop (Acer 8104).

Cheers,
Charles
