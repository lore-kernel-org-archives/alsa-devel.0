From: Raymond <rayau@netvigator.com>
Subject: Re: Volume per voices [Feature Request]
Date: Thu, 28 Jul 2005 15:31:41 +0800
Message-ID: <42E889DD.2070808@netvigator.com>
References: <s5hll3slj32.wl%tiwai@suse.de> <Pine.HPX.4.33n.0507271709230.25935-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0507271709230.25935-100000@studcom.urz.uni-halle.de>
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


In theory, and sound cards with hardware mixing can support this kind of
volume control.

au88x0 driver may provide this kind of volume control on playing PCM
streams by using hardware mixers.

However the hardware mixers are dynamically allocated in routine
snd_vortex_pcm_hw_params(), this means that the kcontrol can be put/get
only between snd_pcm_hw_params() (return no error) and
snd_pcm_hw_free()/snd_pcm_close().

Is there any flag in kcontrol which enable/disable the put/get from
mixer application ?

How do the alsa mixer application get notification when a PCM stream is
play by another alsa application ?

May be the volume controls can only be accessed by the alsa application
which open the PCM stream. (e.g. The hardware acclerated version of
openal http://www.lost.org.uk/openal.html or sound mixing/recording
application )

Is there any limitation of ctlid if the kcontrol is dynamically created
on snd_vortex_pcm_hw_params() and deleted on snd_vortex_pcm_hw_free() ?

There is no need for alsactl to store/restore the values of these kind
of volume controls.

Clemens Ladisch wrote:
> Takashi Iwai wrote:
> 
> 
>>At Wed, 27 Jul 2005 10:30:36 +0200,
>>I wrote:
>>
>>>The problem is that it's not clearly defined how to find the bound
>>>control for the currently opened pcm.  We may assume that the index
>>>number corresponds to the substream index, but this may be different
>>>on drivers.
>>
>>Well, I mean, we have no API for providing this information.
>>Not only PCM but other controls (e.g. effects like chorus/reverb)
>>would be bound to a PCM voice, so only defining consistent control
>>names wouldn't suffice.
>>
>>I believe PCM iface attribute could be used for such a purpose,
> 
> 
> As far as I see, the iface/device/subdevice fields were designed for
> exactly this purpose, i.e., associating a control with a specific
> (sub)device.
> 
> 
>>but unfortunately, the situation is confusing.  Some drivers
>>already use PCM iface for different purposes (e.g. hdsp) and some
>>use mixer iface for exactly this purpose (e.g. emu10k1)...
> 
> 
> Then I'd consider these drivers buggy.
> 
> I'll write a patch unless anybody objects ...
> 
> 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
