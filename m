From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Tue, 15 Apr 2008 15:43:30 +0100
Message-ID: <4804BF12.9050100@superbug.co.uk>
References: <20080411204610.GA32413@tango.0pointer.de>	<20080414172839.GA26513@tango.0pointer.de>	<4803C78A.3020109@superbug.co.uk>	<200804150552.13578.faber@faberman.de>
	<20080415131203.GA2818@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net
	[194.217.242.85])
	by alsa0.perex.cz (Postfix) with ESMTP id CC624103800
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 16:43:32 +0200 (CEST)
In-Reply-To: <20080415131203.GA2818@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Rigg <aldev@sound-man.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

John Rigg wrote:
>> On Monday 14 April 2008 23:07:22 James Courtier-Dutton wrote:
>>     
>>> The aim of the dB values in the ALSA mixer is this.
>>>
>>> For Playback:
>>> Set all the mixer controls to 0dB.
>>> Send a sample digital signal from the CPU to the sound card.
>>> The measured analog signal on the line-out should be the same for ALL
>>> sound cards.
>>>       
>
> The dB setting in a mixer refers to gain, not level.
> Expecting the same absolute level from pro and consumer
> sound cards at the same gain setting is a little ridiculous.
> If I set a control at 0dB I want just that: 0dB gain.
>
> John
>   
But surely it is a bit more than that.
If I work with Pro gear and I capture some sound via line-in.
I then send the digital sound file produced to another person who also 
has pro gear.
When they output that digital sound file to their line-out, it should be 
identical, level wise, to the captured line-in was so long as both 
people have the same dB gain levels set.
In this case, we would need some way to convert Volts from the line-in 
to specific digital samples in the sound file.
I have not been able to find out what this conversion should be.
E.g. a 16bit signed digital sample with value +5000 equals X Volts 
output from line-out.
What is that X value?

James
