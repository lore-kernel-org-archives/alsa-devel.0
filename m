From: Raymond <rayau@netvigator.com>
Subject: Re: Volume per voices [Feature Request]
Date: Sat, 13 Aug 2005 11:59:08 +0800
Message-ID: <42FD700C.9010603@netvigator.com>
References: <Pine.HPX.4.33n.0507280926040.9785-100000@studcom.urz.uni-halle.de>	<Pine.LNX.4.58.0507281927310.14095@denise.shiny.it> <s5hzms5c0v6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hzms5c0v6.wl%tiwai@suse.de>
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
> At Thu, 28 Jul 2005 19:51:16 +0200 (CEST),
> Giuliano Pochini wrote:
> 
>>>>In my driver we have A analog channels and D digital channels. The
>>>>driver registers a "PCM Playback Volume" control as an array of
>>>>A+D integers, where each element is the gain (-128..+6) of each
>>>>channel, but they don't map directly to the PCM channels because
>>>>the driver exports analog and digital channels as two separate
>>>>devices (this feature can be removed easily). So pcmvol[0..A-1]
>>>>controls the volume of hw:0,0 and pcmvol[A..A+D-1] controls the
>>>>volume of hw:0,1. Furthermore, the user can open hw:0,0,x to
>>>>address the xth channel.
>>>
>>>As far as I can see, no driver actually uses the subdevice (substream)
>>>field for PCM substreams; probably because this would require a
>>>separate control for each substream instead of using an array.
>>
>>My case is even more compicated because one ctl controls the volume of two
>>devices. A callback that gets snd_pcm_substream_t* and returns {int numid,
>>firstindex, lastindex} or sort of would make things much simpler wrt hw
>>controls. In case there are both hw volume and softvol, which has
>>priority ? :)
> 
> 
> Returning a list of controls would be simplest as the lowlevel API.
> The higher level API decides which control to use, for example,  while
> h/w specific apps can use the lowlevel API to get certain controls
> directly.
> 
> 

For those controls with SNDRV_CTL_ELEM_IFACE_PCM , ctl->id.device and 
ctl->id.subdevice.

Is it feasible to have a function which return snd_pcm_substream_t* of 
the PCM substream with parameters (snd_kcontrol_t *kcontrol, int device 
,int subdevice)  ?

The topology which the hardware mixers are connected depends on the 
number of channels (mono,stereo,quad,..) of the PCM substream




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
