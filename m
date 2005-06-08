From: Raymond <rayau@netvigator.com>
Subject: Re: unresolved symbol class_device_destroy,   class_device_create
 - alsa-driver-1.0.9a on kernel 2.4
Date: Wed, 08 Jun 2005 16:03:06 +0800
Message-ID: <42A6A63A.2010300@netvigator.com>
References: <42A2E466.3080507@netvigator.com> <Pine.HPX.4.33n.0506060858380.4802-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0506060858380.4802-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks

http://sourceforge.net/mailarchive/forum.php?thread_id=7430161&forum_id=33141

alsa-utils-1.0.9a

There seem to be an inconsistency in amixer ( Those 10-bands stereo
equalizer control of au8830 should be stereo instead of mono - simple 
mixer control )

amixer contents

numid=16,iface=MIXER,name='Master Playback Volume'
   ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
   : values=22,22


numid=2,iface=MIXER,name='EQ0 31Hz'
   ; type=INTEGER,access=rw---,values=2,min=0,max=32767,step=0
   : values=32767,16022
numid=3,iface=MIXER,name='EQ1 63Hz'
   ; type=INTEGER,access=rw---,values=2,min=0,max=32767,step=0
   : values=16022,16022
numid=4,iface=MIXER,name='EQ2 125Hz'
   ; type=INTEGER,access=rw---,values=2,min=0,max=32767,step=0
   : values=16022,16022
numid=5,iface=MIXER,name='EQ3 250Hz'
   ; type=INTEGER,access=rw---,values=2,min=0,max=32767,step=0
   : values=16022,16022
numid=6,iface=MIXER,name='EQ4 500Hz'
   ; type=INTEGER,access=rw---,values=2,min=0,max=32767,step=0
   : values=16022,16022
numid=7,iface=MIXER,name='EQ5 1KHz'
   ; type=INTEGER,access=rw---,values=2,min=0,max=32767,step=0
   : values=16022,16022
numid=8,iface=MIXER,name='EQ6 2KHz'
   ; type=INTEGER,access=rw---,values=2,min=0,max=32767,step=0
   : values=16022,16022
numid=9,iface=MIXER,name='EQ7 4KHz'
   ; type=INTEGER,access=rw---,values=2,min=0,max=32767,step=0
   : values=16022,16022
numid=10,iface=MIXER,name='EQ8 8KHz'
   ; type=INTEGER,access=rw---,values=2,min=0,max=32767,step=0
   : values=16022,16022
numid=11,iface=MIXER,name='EQ9 16KHz'
   ; type=INTEGER,access=rw---,values=2,min=0,max=32767,step=0
   : values=16022,32767


amixer

Simple mixer control 'Master',0
   Capabilities: pvolume pswitch pswitch-joined
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Front Left: Playback 22 [71%] [on]
   Front Right: Playback 22 [71%] [on]


Simple mixer control 'EQ0 31Hz',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Limits: 0 - 32767
   Mono: 32767 [100%]
   Front Left:
   Front Right:
Simple mixer control 'EQ1 63Hz',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Limits: 0 - 32767
   Mono: 16022 [49%]
   Front Left:
   Front Right:
Simple mixer control 'EQ2 125Hz',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Limits: 0 - 32767
   Mono: 16022 [49%]
   Front Left:
   Front Right:
Simple mixer control 'EQ3 250Hz',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Limits: 0 - 32767
   Mono: 16022 [49%]
   Front Left:
   Front Right:
Simple mixer control 'EQ4 500Hz',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Limits: 0 - 32767
   Mono: 16022 [49%]
   Front Left:
   Front Right:
Simple mixer control 'EQ5 1KHz',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Limits: 0 - 32767
   Mono: 16022 [49%]
   Front Left:
   Front Right:
Simple mixer control 'EQ6 2KHz',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Limits: 0 - 32767
   Mono: 16022 [49%]
   Front Left:
   Front Right:
Simple mixer control 'EQ7 4KHz',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Limits: 0 - 32767
   Mono: 16022 [49%]
   Front Left:
   Front Right:
Simple mixer control 'EQ8 8KHz',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Limits: 0 - 32767
   Mono: 16022 [49%]
   Front Left:
   Front Right:
Simple mixer control 'EQ9 16KHz',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Limits: 0 - 32767
   Mono: 16022 [49%]
   Front Left:
   Front Right:




Clemens Ladisch wrote:
> Raymond wrote:
> 
>>Are there any patch to fix the unresolved symbol ?
>>
>>snd.o: unresolved symbol class_device_destroy
>>snd.o: unresolved symbol class_device_create
> 
> 
> Fixed in CVS since Friday.
> 




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
