From: Raymond <rayau@netvigator.com>
Subject: Re: Volume Peak display
Date: Tue, 21 Jun 2005 17:08:41 +0800
Message-ID: <42B7D919.8020400@netvigator.com>
References: <1064034672.10497.7.camel@localhost>	<s5hfzinr34z.wl@alsa2.suse.de>	<1064414023.1630.11.camel@localhost> <s5hisnikuw5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hisnikuw5.wl@alsa2.suse.de>
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

Takashi Iwai wrote:
> At Wed, 24 Sep 2003 10:33:43 -0400,
> Manuel Jander wrote:
> 
>>Hi Takashi,
>>
>>I was thinking that wouldn't it be a good idea to have a "visualization"
>>category for alsa controls ? Or at least some naming scheme that allows
>>to identify controls that should just show some data, like VU meters, or
>>the hardware EQ peak i'm implementing for the aureal vortex.
> 

Are those VU meters measure in db or percentage ?

> 
> well, the volatile flag should be used for such a purpose.
> if it's set, the control change won't be notified to the application.
> the application which shows these controls must re-read the data
> periodically (not passively like others).
> 
> the other flag name might be more obvious, though.
> 
> 
>>>>- The peaks doesnt get updated by alsamixer nor alsamixergui.
>>>>I set the "volatile" flag, but is doesnt have any effect.
>>>
>>>this is inteintional.
>>>(otherwise it will be too heavy for terminals over a slow network
>>> connection :)
>>>
>>>for these purposes, we'll need anyway a special mixer app like
>>>envy24control.
>>
>>Ok. I got it. I'll start writing our "Vortex turbo  mixer" as soon as i
>>can :-)
>>

10-bands Graphic equalizer has been implemented in vortexcontrol.

>>
>>>>- Alsamixer shows only 4 of the peak control set (20 total), and other
>>>>mixers just show 2 of them.
>>>
>>>maybe the result of abstraction by simple-mixer API.
>>>
>>>
>>>>- The controls are declared as read only, but i can change their value.
>>>>This shouldn't be allowed.
>>>
>>>really?  then it must be fixed.
>>>could you elaborate how this can happen?
>>

>>This could be a problem of the mixer app. I mean that i can modify the
>>sliders on alsamixer or alsamixergui. The alsalib doesnt try to invoke a
>>"control_put()" function (which is correct), since that would yield a
>>segfault (i didnt implemented the control_put(), because that would be
>>nonsense). 

The message return by amixer seem to be misleading.


# amixer cget numid=12
numid=12,iface=MIXER,name='EQ Peaks'
   ; type=INTEGER,access=r----,values=20,min=0,max=32767,step=0
   : values=0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

# amixer sget numid=12 1,1,1,1,1,1,1,1,1
amixer: Unable to find simple control 'numid=12',0



static snd_kcontrol_new_t vortex_levels_kcontrol __devinitdata = {
	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
	.name = "EQ Peaks",
	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
	.info = snd_vortex_peaks_info,
	.get = snd_vortex_peaks_get,
};

Refer to Alien's png

http://article.gmane.org/gmane.linux.alsa.devel/23112

There are 4 sliders marked as "EQ peaks" in alsamixer (1.0.9a) , the
first two are stereo and the last two are mono.

The 4 EQ peaks sliders in alsamixer can be adjusted and it is strange
that alsamixer do not get "segfault" when ".put" has not been
implemented in au88x0.


The following error only appear with compile with option --with-debug=full

Vortex: init.... <3>ALSA control.c:325: control 3:0:0:Playback PCM
advanced processing:0 is already present
done.

It seem that this HRTF kcontrols with 6 values cannot be created.

Does it mean that kcontrols ( not enumerated ) cannot contains more than
2 values ?

>>
>>What i wanted to say, is that it shouldn't be possible in a mixer app to
>>"Move" sliders from readonly controls. Their appearance should be
>>different too. They should look like "progress bars" or something else.
>>Or better than that, VU meters should look like VU meters :)
> 
> 
> agreed.  at least, showing the elements with volatile in alsamixer
> doens't make sense unless alsamixer shows vu meter (hey, it's not bad
> :)
> 
> 


Is it possible to standardise the API of multi-band equalizer ( hardware 
equalizer / graphic equalizer )

Beside Turtle Beach Montego II (au8830) , it seem that other cards such 
as Santa Cruz (cs46xx) , Montego DDL  also have hardware equalizer.







-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
