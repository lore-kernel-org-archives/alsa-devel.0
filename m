From: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>
Subject: Re: cs46xx -> Terratec DMX XFire 1024 4channel output
 success
Date: Mon, 07 Apr 2003 20:24:17 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E91C251.8020405@gmx.de>
References: <3E873CA2.2010607@cucumelo.org> <3E8B4877.4030306@gmx.de> <3E8F5C92.8080801@cucumelo.org> <3E901DC1.9090001@gmx.de> <3E90A8E0.6060507@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E90A8E0.6060507@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Benny,

Benny Sjostrand wrote:

>
> The intention with that if(...) statment was to make sure that there 
> was only one codec available and that codec was a cs4294.
>
> Could you test it again chaning the "0x5d2d" to "0x592d" ? (my 
> misstake ...)
> If that dont work could you send me a dump of 
> /proc/asound/card0/ac97#0regs

Yep, 0x592d works perfectly and I also find that "0x592d" as last output 
of /proc/asound/card0/ac97#0regs.

>
> I believe it should be possible to control the volume from the second 
> output, just need to find out how, so I'll try to find something in 
> the bloody cs4294 spec., well, and hopefully something will happen to 
> the code ;) 

Just to get sure you didn't misunderstand me :)
Volume control of the second output DOES work (using the 'headphones' 
slider), but the 'PCM' slider only controls the first output's volume.

I think I'm beginning to understand why:
The second output is a pure PCM output, i.e. no mixing of CD, line-in, 
mic-in, ... as for the first output. Therefore, there is only *one* 
mixer element to control the second output. Only the name "headphones" 
is misleading.
In the new 4 channel configuration this control could have been named 
"PCM2" or "rear PCM" or ...
... or isn't "headphones" sometimes the correct name?

That leads to the next point:
Is it possible to switch back to the oly behaviour at run time? (seem 
like the decision in which mode to initialize the codec is done while 
starting alsa). Using the second output as a headphone output of the 
first PCM device is not completely wrong: On the XFire there are jumpers 
which you can use to select the output type (amplified for loudspeakers 
-or- line level) of the *first* output only. The second output is always 
at line level, i.e. suitable for 600Ohm headphones.
I don't know whether it's a good idea to allow switching back to the 
2channel ("front-back-always-the-same-sound") for using headphones to 
hear at the first output.
I think there is an alternative: It should be possible to copy the data 
from the first output to the second output by some .asoundrc magic. But: 
how much CPU time will alsa eat for this (keeping in mind that the codec 
itself can do the same without any CPU cost)? If it's not too much, I 
wouldn't see any reason for switching back to the old codec configuration.
What do you think? (I know, you don't have the XFire, but anyway ;-) )
  fe



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
