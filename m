From: ST <st@iss.tu-darmstadt.de>
Subject: Re: Tascam US122 on Arm
Date: Thu, 4 Oct 2007 10:43:27 +0200
Message-ID: <200710041043.28440.st@iss.tu-darmstadt.de>
References: <200709300116.50747.st@iss.tu-darmstadt.de>
	<8e4fc8270710031337x66778c0bn7bd3c42e93f97ddc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lnx130.hrz.tu-darmstadt.de (lnx130.hrz.tu-darmstadt.de
	[130.83.174.24]) by alsa0.perex.cz (Postfix) with ESMTP id 4AE5624542
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Oct 2007 10:43:31 +0200 (CEST)
In-Reply-To: <8e4fc8270710031337x66778c0bn7bd3c42e93f97ddc@mail.gmail.com>
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
To: Michael Bourgeous <sts.nitrogen@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Micheal
> -1 in a 16-bit integer (which would be 65535 if unsigned), and the
> driver is putting it in a 32-bit integer without sign extension and
> incrementing it as though it is the number of the usb frame. 
Thats an interesting idea. I think i will take a look at the code if this is 
the case.
> Look 
> through the driver code to see where that value is assigned to a
> variable, and find out what function is doing it.  Basically, since
> it's happening right after the limits of a 16-bit integer, I'd say
> it's either an overflow error, or an error code is being returned in
> the wrong kind of variable (signed vs. unsigned).  In my case, what
> solved my USB error messages was disabling PowerNow CPU frequency
> scaling.
Intresting. I got a different mail 
http://www.nslu2-linux.org/wiki/Peripherals/AudioAdapter
Since i have an 1.0 Soundcard and EHCI ports this is probably one cause of the 
problem.

Currently i have taken out the call usX2Y_clients_stop(usX2Y); in the function
usX2Y_error_sequence and added an subs->completed_urb = urb; to the 
corresponding else statement. Since them i didn't had any errors reported, 
but i suspect i did an error somewhere, since the error occured on every 
playback and now i don't get any usb glitches reported. I will test it a 
little bit more and get back with some results.

Best regards
ST
