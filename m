From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Sun, 20 Apr 2008 08:23:30 -0700
Message-ID: <480B5FF2.7010906@cox.net>
References: <20080411204610.GA32413@tango.0pointer.de>	<480099C6.3040708@superbug.co.uk>	<20080412133536.GC32491@tango.0pointer.de>	<48010E62.2020404@keyaccess.nl>	<20080414170022.GH22115@tango.0pointer.de>	<480392F3.9030701@keyaccess.nl>	<20080414172839.GA26513@tango.0pointer.de>	<4803C78A.3020109@superbug.co.uk>
	<20080420010116.GA22033@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao106.cox.net (fed1rmmtao106.cox.net [68.230.241.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 13D1F2435A
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Apr 2008 17:23:32 +0200 (CEST)
Received: from fed1rmimpo03.cox.net ([70.169.32.75]) by fed1rmmtao106.cox.net
	(InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP id
	<20080420152325.OXIZ12496.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>
	for <alsa-devel@alsa-project.org>; Sun, 20 Apr 2008 11:23:25 -0400
In-Reply-To: <20080420010116.GA22033@tango.0pointer.de>
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

Lennart Poettering wrote:
> On Mon, 14.04.08 22:07, James Courtier-Dutton (James@superbug.co.uk) wrote:
>   
>   
[snip]
> So, what does this mean for the task I initially wanted to get done,
> i.e. to find some way to initialize mixers properly so that they are
> not fully unmuted? Nothing good.
>   
Why not open a dialog when encountering a device for which there is no 
existing asound.state or equivalent pulseaudio file?  Something like 
"This sound device has not been used on this machine before.  Therefore 
the volume is muted.  Hit enter to go to alsamixer to adjust the volume 
to the level you want".  Then bring up alsamixer for the device, and 
when it exits write an asound.state.  And a pulseaudio version so if you 
see the device again, you don't have to ask.  Or instead of alsamixer, 
you could just bring up the window manager volume adjustment app, or 
your own volume adjustment app.  No guessing, no problem.

> Thanks,
>
> Lennart
>
>   
