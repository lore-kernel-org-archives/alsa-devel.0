From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Sat, 12 Apr 2008 22:55:35 +0100
Message-ID: <48012FD7.6050904@superbug.co.uk>
References: <20080411204610.GA32413@tango.0pointer.de>
	<20080412133536.GC32491@tango.0pointer.de>
	<4800FC14.3060804@superbug.co.uk>
	<200804122025.57165.faber@faberman.de>
	<48010CF9.4000600@superbug.co.uk> <20080412214143.GB2828@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-33.mail.demon.net (anchor-post-33.mail.demon.net
	[194.217.242.91])
	by alsa0.perex.cz (Postfix) with ESMTP id DE60B244C6
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Apr 2008 23:55:40 +0200 (CEST)
In-Reply-To: <20080412214143.GB2828@localhost>
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
Cc: Florian Faber <faber@faberman.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

John Rigg wrote:
> On Sat, Apr 12, 2008 at 08:26:49PM +0100, James Courtier-Dutton wrote:
>   
>> Florian Faber wrote:
>>     
>>> On Saturday 12 April 2008 20:14:44 James Courtier-Dutton wrote:
>>>   
>>>       
>>>> That sounds reasonable for now. Professional sound card users will
>>>> maybe just have to remember to mute the master control before
>>>> connecting their speakers.
>>>>     
>>>>         
>>> This is very, very dangerous - not only can it harm the equipment, it 
>>> can also harm the user. 0dBFS equals >121dB at a distance 2m away from 
>>> my head, and I have a *small* setup.
>>>
>>> To be honest, I think I would then insert a switch in the RME driver 
>>> that will enable the outputs only after the RME mixer application has 
>>> been started.
>>>
>>>
>>> Flo
>>>   
>>>       
>> Thats not very helpful really.
>> What value should we set it to then?
>>     
>
> Minimum gain. On the aforementioned RME mixer, setting all the channels
> to anything other than that would make it unusable.
> Pro cards with high channel counts are very different from consumer
> cards, and their users have totally different requirements. Is it
> really a problem to accomodate both classes of card/user?
>
>   
>> Another alternative could be to leave everything at 0dB except the master.
>>     
>
> With 64 channels, that is likely to cause massive clipping
> even if damage is prevented by keeping the master down.
> The usual use case here would be to just turn up the required
> channels. Having to turn all the rest down manually would seriously
> disrupt work flow. No studio client would be happy about this.
>
>   
>> For the master we could select say minimum dB + 12.
>> So, if the Master ranged from -70 to 0 dB, we would set Master to -70 + 
>> 12 = -58dB.
>>
>> Would that suit everyone better.
>>     
>
> That would be reasonable for consumer cards. Pro sound cards should
> never initialise themselves to anything other than minimum gain.
>
> John
>   

I think everyone is misunderstanding the issue here.
All ALSA sound cards, without any intervention from user space, will 
boot up with ALL SOUND MUTED.
Most distros then have an /etc/init.d startup script that restores sound 
card levels to the previous state before the previous power off.
The problem is, what to do the first time the system is installed. I.e. 
No "previous state" exists.
a) General users will normally want some level of sound by default the 
first time they boot into a newly installed system.
b) Professional users want everything muted the first time.

My personal preference is ALL SOUND MUTED in ALL cases.
I figure that if a user does not have sound, the first thing they will 
do is go to the volume control and turn it up!
I do believe that a general user should only have to touch one "Master" 
volume control to do this "turn it up" step.

Most consumer distos do not agree with me and want the volume turned up 
already by default.
The problem is deciding on a generally good level for these distros.

James
