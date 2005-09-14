From: Raymond <rayau@netvigator.com>
Subject: Re: mixer control - Captuer Source - rename item name in enumerated
 control
Date: Wed, 14 Sep 2005 18:31:47 +0800
Message-ID: <4327FC13.7010001@netvigator.com>
References: <4326EEA6.8070007@netvigator.com> <s5hvf15dllp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hvf15dllp.wl%tiwai@suse.de>
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


Is it possible to detect which daugther card is connected (e.g Yamaha
DB50XG, TurtleBeach Cancun FX, Roland SCD-15...) and replace "Video"
with the name of daugther card on the mixer control ?

The hardware driver know how the hardware are connected more than the
alsa-lib

Not only the capture source will need to be changed.

numid=33,iface=MIXER,name='Video Playback Switch'
   ; type=BOOLEAN,access=rw---,values=1
   : values=on
numid=34,iface=MIXER,name='Video Playback Volume'
   ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
   : values=9,9

It seem that get_compare_weight() use pre-defined names to perform
matching


Takashi Iwai wrote:
> At Tue, 13 Sep 2005 23:22:14 +0800,
> Raymond wrote:
> 
>>Is it possible to rename "Video" to "MPU401" in enumerated "Capture 
>>Source" mixer control by the au88x0 driver ?
>>
>>numid=39,iface=MIXER,name='Capture Source'
>>   ; type=ENUMERATED,access=rw---,values=2,items=8
>>   ; Item #0 'Mic'
>>   ; Item #1 'CD'
>>   ; Item #2 'Video' <---------------MPU 401 / wavetable daugther card
>>   ; Item #3 'Aux'
>>   ; Item #4 'Line'
>>   ; Item #5 'Mix'
>>   ; Item #6 'Mix Mono'
>>   ; Item #7 'Phone'
>>   : values=0,0
> 
> 
> Currently, you need an ugly hack.
> 
> Find "Capture Source" control and replace the private_value field with
> the point to a new own struct ac97_enum.  For example,
> 
> /* taken from ac97/ac97_local.h */
> #define AC97_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, xtexts) \
> { .reg = xreg, .shift_l = xshift_l, .shift_r = xshift_r, \
>   .mask = xmask, .texts = xtexts }
> 
> static const char *my_own_sel[] = { "Mic", "CD", "WaveTable", "Aux",
> "line", Mix", "Mix Mono", "Phone" };
> 
> static const struct ac97_enum my_own_enum =
> AC97_ENUM_DOUBLE(AC97_REC_SEL, 8, 0, 8, my_own_sel);
> 
> 
> Then use snd_ctl_find_id() to get a snd_kcontrol_t object, and
> replace its private_value field with (unsigned long)&my_own_enum.
> 
> 
> Takashi
> 




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
