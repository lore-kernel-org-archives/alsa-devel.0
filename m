From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: cs46xx -> Terratec DMX XFire 1024 4channel output
 success
Date: Mon, 07 Apr 2003 23:27:07 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E91ED2B.3020902@cucumelo.org>
References: <3E873CA2.2010607@cucumelo.org> <3E8B4877.4030306@gmx.de> <3E8F5C92.8080801@cucumelo.org> <3E901DC1.9090001@gmx.de> <3E90A8E0.6060507@cucumelo.org> <3E91C251.8020405@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Yep, 0x592d works perfectly and I also find that "0x592d" as last 
> output of /proc/asound/card0/ac97#0regs. 


Great!

> Just to get sure you didn't misunderstand me :)
> Volume control of the second output DOES work (using the 'headphones' 
> slider), but the 'PCM' slider only controls the first output's volume.
>
> I think I'm beginning to understand why:
> The second output is a pure PCM output, i.e. no mixing of CD, line-in, 
> mic-in, ... as for the first output. Therefore, there is only *one* 
> mixer element to control the second output. Only the name "headphones" 
> is misleading.
> In the new 4 channel configuration this control could have been named 
> "PCM2" or "rear PCM" or ...
> ... or isn't "headphones" sometimes the correct name?

Yeah that make sense, I was about to ask you if did'nt have a 
"Headphone" control in your mixer.

About the "Headphone" maybe a more correct name could be "Alternate 
Output", well, dont know, as that is done in the ac97 layer.

>
> That leads to the next point:
> Is it possible to switch back to the oly behaviour at run time? (seem 
> like the decision in which mode to initialize the codec is done while 
> starting alsa). Using the second output as a headphone output of the 
> first PCM device is not completely wrong: On the XFire there are 
> jumpers which you can use to select the output type (amplified for 
> loudspeakers -or- line level) of the *first* output only. The second 
> output is always at line level, i.e. suitable for 600Ohm headphones.
> I don't know whether it's a good idea to allow switching back to the 
> 2channel ("front-back-always-the-same-sound") for using headphones to 
> hear at the first output.
> I think there is an alternative: It should be possible to copy the 
> data from the first output to the second output by some .asoundrc 
> magic. But: how much CPU time will alsa eat for this (keeping in mind 
> that the codec itself can do the same without any CPU cost)? If it's 
> not too much, I wouldn't see any reason for switching back to the old 
> codec configuration.
> What do you think? (I know, you don't have the XFire, but anyway ;-) )
>  fe

To get back to the previous mode, it's just to unset the EAM bit. Maybe 
we could have a control in the mixer for that like "4 channel 
duplicate", or something that just unset/set the EAM bit when desired.

/Benny




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
