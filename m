From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: cs46xx experimental DSP drivers
Date: Tue, 24 Sep 2002 23:16:49 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D90D641.7050200@cucumelo.org>
References: <3D8F7F59.6030105@prism.gatech.edu> <3D90A8D8.7070103@cucumelo.org> <3D90B54F.20402@prism.gatech.edu>
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Weijia Yang <gte733z@prism.gatech.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Benny--
>     Where exactly do I set this "external_amp" option? I see a 
> 'External Amplifier Power Down' in amixer, but only option is muting, 
> which turns sound off completely.  Also, several other people have 
> also reported the "flat" sounds, as well as cpu usage spikes when 
> initiating a sound stream. The posts can be seen at 
> <http://forums.gentoo.org/viewtopic.php?t=10826&highlight=cs46xx>
> and
> <http://forums.gentoo.org/viewtopic.php?t=10810&highlight=cs46xx>

Finally, so far I know the Santa Cruz is yet another card where we dont 
have  technical specifications. It's possible that there is any GPIO or 
whatever kind of logic that controls "something" that makes the sound 
better.
Not having a Santa Cruz card dont make things easier ... I had one I 
would start testing all the EGPIO's by the hard way seing what happens, 
(maybe
someone that have time and such a card can do this ?) In the current 
cs46xx driver there is some debug code to control the EGPIO's from the
ALSA mixer that can be activated by defining 
CONFIG_SND_CS46XX_DEBUG_GPIO in cs46xx_lib.c, that I've been using to 
test EGPIO functionality on
the Game Theater XP card.

It's possible that the current ALSA driver needs to be optimized. When a 
new PCM channel is opened first time the driver needs to do a lot a 
things. Sure that the you got a small and short  peak when audio 
playback starts. Can you can meusure if it's System time, User time ?

The "external_amp" parameter is specified when module is loaded, eg. on 
a line in /etc/module.conf:
option snd-cs46xx external_amp=1

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
