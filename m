From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Mon, 14 Apr 2008 22:07:22 +0100
Message-ID: <4803C78A.3020109@superbug.co.uk>
References: <20080411204610.GA32413@tango.0pointer.de>	<480099C6.3040708@superbug.co.uk>	<20080412133536.GC32491@tango.0pointer.de>	<48010E62.2020404@keyaccess.nl>	<20080414170022.GH22115@tango.0pointer.de>	<480392F3.9030701@keyaccess.nl>
	<20080414172839.GA26513@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-37.mail.demon.net (anchor-post-37.mail.demon.net
	[194.217.242.87])
	by alsa0.perex.cz (Postfix) with ESMTP id DF3822460E
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 23:07:24 +0200 (CEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.0.10])
	by anchor-post-37.mail.demon.net with esmtp (Exim 4.68)
	id 1JlVtb-0007gl-N2
	for alsa-devel@alsa-project.org; Mon, 14 Apr 2008 21:07:24 +0000
In-Reply-To: <20080414172839.GA26513@tango.0pointer.de>
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
> 
> Yes, but what I am asking for is to define the dB values of the master
> control relative to the some ref level on this line-out. What happens
> after the line-out doesn't matter at all.
> 
> Lennart
> 

The aim of the dB values in the ALSA mixer is this.

For Playback:
Set all the mixer controls to 0dB.
Send a sample digital signal from the CPU to the sound card.
The measured analog signal on the line-out should be the same for ALL 
sound cards.

For Capture:
Set all the mixer controls to 0dB.
Send a sample analog signal to the line-in of the sound card.
The captured digital signal at the CPU should be the same for ALL sound 
cards.

The reason for using 0dB is that it should mean no gain and no 
attenuation to the signal and so minimize distortions.

Now, we have tried to get this right by looking at datasheets of sound 
cards, but it might not be right for all sound cards yet. It is at least 
a task we may be able to actually achieve.
When the datasheets are wrong, the only available method to get it right 
is actually to measure the analog signals. Can anyone provide a simple 
reliable test for this? E.g. Using this sample .wav file and a cheapo 
digital volt meter, this is the output you should get. I am not even 
sure that a simple digital volt meter can do the task as a volt meter is 
only expecting 50-60Hz, and not all sound cards work at all well at that 
frequency.

The problem comes with the speakers, that will have varying level of 
amplification/attenuation before them. This is outside of the control of 
ALSA as they are not part of the sound card. This is essentially why 
setting the default MASTER control to anything other than MUTED is 
really the best we can do.

The one exception to this is laptops, where, on an individual basis, we 
could potentially have a constant value indicating the affect that the 
internal speaker amp has on the sound card output to the internal 
speakers. For these, we could probably use ALSA to recommend to userland 
what a sensible default value for the master mixer control should be.

If anyone thinks that there is anything more than this that can be done 
by ALSA, I will be amazed.



James
