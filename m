From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: Re: emu10k1, sound blaster audigy two zs and digital
 output
Date: Wed, 15 Jun 2005 21:33:59 +0200
Message-ID: <42B082A7.2030706@pobox.sk>
References: <Pine.LNX.4.63.0506141947300.17981@localhost> <42AF208B.3020908@superbug.co.uk> <Pine.LNX.4.63.0506150013020.8393@localhost> <42AF5D6C.4060502@superbug.co.uk> <Pine.LNX.4.63.0506150156050.9025@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0506150156050.9025@localhost>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: edoardo <edoardo@lastorina.it>
Cc: James Courtier-Dutton <James@superbug.co.uk>, alsa users list <alsa-user@lists.sourceforge.net>, alsa developers' list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

"iec958 optical raw" - is switched on, because ac3 data have to pass 
through DSP unchanged.

try to play normal stereo wav file with aplay ("iec958 optical raw" will 
be turned on and you will be not able to change volume - set lower 
volume on your receiver, because otherways it will be high)

aplay -D spdif some.wav

You should be able to hear sound. If this works then problem can be, 
your audigy is not correctly identified (some have bug in ac3 passtrough).

What alsa version do you use (cat /proc/asound/version)?

Peter Zubaj


edoardo wrote:

>
> also, i noticed that when i run xine with pass through option set and 
> i keep alsamixer open, 'iec958 optical raw' and 'audigy analog/digital 
> output jack' get checked if they were unchecked. the optical raw 
> thing, when it's checked, don't let me hear any audio from the digital 
> output, and i have to uncheck it to hear anythin'. but with pass 
> through turned on, optical raw is forced on. how come? help! thankyou! 
> : )
>
> ciao! : )
>
> edoardo
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
