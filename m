From: Perry Gilfillan <perrye@linuxmail.org>
Subject: Re: Adding a Mute Switch to snd-tvmixer
Date: Tue, 13 Apr 2004 14:32:34 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <407C4052.1080103@linuxmail.org>
References: <Pine.HPX.4.33n.0404131832410.10741-100000@studcom.urz.uni-halle.de>
Reply-To: perrye@linuxmail.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0404131832410.10741-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>, alsa-list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> Does it show up in alsamixer?
> In /etc/asound.state after running "alsactl store"?

It does now :)

I had neglected to increase the TVMIXER_CONTROLS define when I added the 
Mute Switch control.

Now I get other starange behaviour.

	Right hand slider in gnome-volumecontrol has no effect.
	(related) Balance slider in gnome-alsa-mixer is off center.
	xawtv/motv only push volume up to 3% (other mixers work fine).

I'll have to go over the math again, and find out about the oss 
emulation.  Maybe it's time to look at xawtv/motv ASLA support status.

Thanks for the tip. `alsactl store` pointed me in the right direction!

Cheers,

Perry
-----
Gilfillan Family: http://www.gilfillan.org/

Projects:
   V3TV: http://www.gilfillan.org/v3tv/
   VPX3224:  http://www.gilfillan.org/vpx3224/
   snd-tvmixer:  http://www.gilfillan.org/ALSA/



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
