From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Sat, 12 Apr 2008 20:34:09 +0100
Message-ID: <48010EB1.4070606@superbug.co.uk>
References: <20080411204610.GA32413@tango.0pointer.de>	<20080412133536.GC32491@tango.0pointer.de>	<4800FC14.3060804@superbug.co.uk>	<200804122025.57165.faber@faberman.de>
	<48010CF9.4000600@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-37.mail.demon.net (anchor-post-37.mail.demon.net
	[194.217.242.87])
	by alsa0.perex.cz (Postfix) with ESMTP id DAC4E24432
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Apr 2008 21:34:10 +0200 (CEST)
In-Reply-To: <48010CF9.4000600@superbug.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Florian Faber <faber@faberman.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> Florian Faber wrote:
>   
>> On Saturday 12 April 2008 20:14:44 James Courtier-Dutton wrote:
>>   
>>     
>>> That sounds reasonable for now. Professional sound card users will
>>> maybe just have to remember to mute the master control before
>>> connecting their speakers.
>>>     
>>>       
>> This is very, very dangerous - not only can it harm the equipment, it 
>> can also harm the user. 0dBFS equals >121dB at a distance 2m away from 
>> my head, and I have a *small* setup.
>>
>> To be honest, I think I would then insert a switch in the RME driver 
>> that will enable the outputs only after the RME mixer application has 
>> been started.
>>
>>
>> Flo
>>   
>>     
>
> Thats not very helpful really.
> What value should we set it to then?
> Another alternative could be to leave everything at 0dB except the master.
> For the master we could select say minimum dB + 12.
> So, if the Master ranged from -70 to 0 dB, we would set Master to -70 + 
> 12 = -58dB.
>
> Would that suit everyone better.
>
> James
>
>   
Note this should be set after boot up. All ALSA drivers in the kernel 
should still default to muted. Once the value has been set, it is 
remember over a reboot and changed from the kernel mutes in a boot up 
init.d script.

James
