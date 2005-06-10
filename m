From: Raymond <rayau@netvigator.com>
Subject: Re: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Fri, 10 Jun 2005 19:28:18 +0800
Message-ID: <42A97952.3030200@netvigator.com>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org>	<s5h8y1n7af3.wl@alsa2.suse.de>	<42A5B7D4.50201@netvigator.com>	<200506071716.05194.alien999999999@users.sourceforge.net>	<s5hwtp6w2nw.wl@alsa2.suse.de>	<42A6B51F.20405@netvigator.com>	<s5h8y1lkv1c.wl@alsa2.suse.de>	<42A942CD.7030900@netvigator.com> <s5h4qc633ib.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4qc633ib.wl@alsa2.suse.de>
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
Cc: openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org


The amixer display 10-bands EQ stereo controls as mono controls.

The function of the equalizer is similar to bass, treble but equalizer 
has 10-bands instead of 2-bands ( bass & treble )

Why do snd_mixer_selem_has_capture_channel(elem, SND_MIXER_SCHN_MONO) = 
1 for those equalizer gain control ?


amixer

Simple mixer control 'Master',0
   Capabilities: pvolume pswitch pswitch-joined
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 31
pmono = 0, cmono = 0 (0, 0, 0, 0)
   Front Left: Playback 22 [71%] [on]
   Front Right: Playback 22 [71%] [on]


Simple mixer control 'EQ0 31Hz',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Limits: 0 - 32767
pmono = 0, cmono = 1 (1, 0, 0, 0)
   Mono: 32767 [100%]
   Front Left:
   Front Right:

...

Simple mixer control 'EQ9 16KHz',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Limits: 0 - 32767
pmono = 0, cmono = 1 (1, 0, 0, 0)
   Mono: 16022 [49%]
   Front Left:
   Front Right:



amixer contents

numid=16,iface=MIXER,name='Master Playback Volume'
   ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
   : values=22,22

numid=2,iface=MIXER,name='EQ0 31Hz'
   ; type=INTEGER,access=rw---,values=2,min=0,max=32767,step=0
   : values=32767,16022

...

numid=11,iface=MIXER,name='EQ9 16KHz'
   ; type=INTEGER,access=rw---,values=2,min=0,max=32767,step=0
   : values=16022,32767


Takashi Iwai wrote:
> At Fri, 10 Jun 2005 15:35:41 +0800,
> Raymond wrote:
> 
>>
>>Do the au88x0 driver need to free those kcontrols for EQ peak and 
>>10-bands EQ gain kcontrol  ?
> 
> 
> No.  The added controls are released automatically.
> 
> 
>>Any method to detect memory leak ? ( THere are other kcontrol such as 
>>HRTF,ITD,ILD,...)
> 
> 
> Compild alsa-driver with debug option (--with-debug=full).
> Then bookkeeping of the kmalloc/vmalloc chunks is enabled.
> You'll be warned if any of them are not released after removing ALSA
> modules.
> 




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
