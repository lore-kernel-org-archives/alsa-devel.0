From: Josh Buhl <uzs33d@uni-bonn.de>
Subject: Re: intel8x0 driver motorboots (gets caught in loop)
 in Quake 3
Date: Thu, 13 Feb 2003 11:47:45 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E4B77D1.3070904@uni-bonn.de>
References: <3E4A8A39.9000608@uni-bonn.de>	<s5h4r78mrrr.wl@alsa2.suse.de>	<3E4B6E83.2070000@uni-bonn.de> <s5hznp0lc2u.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hznp0lc2u.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


> check /proc/interrupts during the playback whether the number of irq
> 10 increases.

During the looped sound, the number of interrupts increases by about 
fifty a second:

josh@spleen:/proc$ date; cat interrupts | grep SiS
Thu Feb 13 11:41:10 CET 2003
  10:      64806          XT-PIC  SiS SI7012
josh@spleen:/proc$ date; cat interrupts | grep SiS
Thu Feb 13 11:41:20 CET 2003
  10:      65281          XT-PIC  SiS SI7012


> 
> also, check the status shown in /proc/asound/card0/pcm0p/sub0 during
> the playback, too.

Here are several polls taken a couple of seconds apart while the looped 
sound is playing:

josh@spleen:/proc$ cat asound/card0/pcm0p/sub0/status
state: RUNNING
trigger_time: 1045132684.647330
tstamp      : 1045133005.954117
delay       : -11695398
avail       : 11711782
avail_max   : 11711782
-----
hw_ptr      : 15423782
appl_ptr    : 3728384
josh@spleen:/proc$ cat asound/card0/pcm0p/sub0/status
state: RUNNING
trigger_time: 1045132684.647330
tstamp      : 1045133012.359933
delay       : -12002901
avail       : 12019285
avail_max   : 12019285
-----
hw_ptr      : 15731285
appl_ptr    : 3728384
josh@spleen:/proc$ cat asound/card0/pcm0p/sub0/status
state: RUNNING
trigger_time: 1045132684.647330
tstamp      : 1045133015.458098
delay       : -12151624
avail       : 12168008
avail_max   : 12168008
-----
hw_ptr      : 15880008
appl_ptr    : 3728384



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
