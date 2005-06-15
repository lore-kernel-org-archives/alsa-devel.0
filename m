From: edoardo <edoardo@lastorina.it>
Subject: Re: [Alsa-user] Re: emu10k1, sound blaster audigy two zs and digital
 output
Date: Wed, 15 Jun 2005 22:37:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0506152227060.15735@localhost>
References: <Pine.LNX.4.63.0506141947300.17981@localhost> <42AF208B.3020908@superbug.co.uk>
 <Pine.LNX.4.63.0506150013020.8393@localhost> <42AF5D6C.4060502@superbug.co.uk>
 <Pine.LNX.4.63.0506150156050.9025@localhost> <42B082A7.2030706@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42B082A7.2030706@pobox.sk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: edoardo <edoardo@lastorina.it>, James Courtier-Dutton <James@superbug.co.uk>, alsa users list <alsa-user@lists.sourceforge.net>, alsa developers' list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


output for the version:
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13 09:39:32 2005 UTC).

i remember readin' here in this mailin' list that my card is fully 
supported from 1.0.9 on, so that may be the issue? anyway, playin' the 
.wav file as you suggested works, and optical raw *is* turned on, so 
that's not the issue. also playin' cds with both totem and xine-ui works 
fine, although optical raw is not turned on and you *can* change the 
volume from software.

now what i'm wonderin' is that maybe the alsa-driver i'm usin' ain't 
appropriate, but that's what comes with my kernel (2.6.11). shall i 
uncheck the modules from within the kernel and install gentoo's 
alsa-driver, which is 1.0.9? i'll try, then i'll let y'all now.

ciao! : )

edoardo


On Wed, 15 Jun 2005, Peter Zubaj wrote:

> "iec958 optical raw" - is switched on, because ac3 data have to pass through 
> DSP unchanged.
>
> try to play normal stereo wav file with aplay ("iec958 optical raw" will be 
> turned on and you will be not able to change volume - set lower volume on 
> your receiver, because otherways it will be high)
>
> aplay -D spdif some.wav
>
> You should be able to hear sound. If this works then problem can be, your 
> audigy is not correctly identified (some have bug in ac3 passtrough).
>
> What alsa version do you use (cat /proc/asound/version)?
>
> Peter Zubaj
>
>
> edoardo wrote:
>
>>
>>  also, i noticed that when i run xine with pass through option set and i
>>  keep alsamixer open, 'iec958 optical raw' and 'audigy analog/digital
>>  output jack' get checked if they were unchecked. the optical raw thing,
>>  when it's checked, don't let me hear any audio from the digital output,
>>  and i have to uncheck it to hear anythin'. but with pass through turned
>>  on, optical raw is forced on. how come? help! thankyou! 
>> : ) 
>>
>>  ciao! : )
>>
>>  edoardo
>> 
>>
>>  -------------------------------------------------------
>>  SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
>>  from IBM. Find simple to follow Roadmaps, straightforward articles,
>>  informative Webcasts and more! Get everything you need to get up to
>>  speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
>>  _______________________________________________
>>  Alsa-user mailing list
>>  Alsa-user@lists.sourceforge.net
>>  https://lists.sourceforge.net/lists/listinfo/alsa-user
>> 
>> 
>
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Alsa-user mailing list
> Alsa-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-user
>
>


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
