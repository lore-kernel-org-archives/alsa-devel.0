From: Raymond <rayau@netvigator.com>
Subject: Re: [ALSA - driver 0001025]: kernel panic when trying to load module
 snd-au8830
Date: Sun, 17 Jul 2005 12:15:47 +0800
Message-ID: <42D9DB73.7070400@netvigator.com>
References: <2407912799486cb54fbd13ab25aa8c3d@bugtrack.alsa-project.org>	<42B02D7C.7040000@netvigator.com> <s5hekb3y9t2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hekb3y9t2.wl%tiwai@suse.de>
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

In Capture view, beside Red (LR Catpure) can be toogled on/off at Line,
CD, Mic, Video, Phone, Aux, Mix and Mix Mono, it can also be toggled 
on/off at the Capture Volume Control? ( another feature or bug )


According to page 42 of AC97 2.1 specification.

Record Control Select Register (index 1A h)
Use to select the record source independently for left and right.


Does it mean that the AC97 specification allow capture Left/Righ
channels from different source ? (i.e. Right channel of Mic and Left
channel of Aux )


Takashi Iwai wrote:
> At Wed, 15 Jun 2005 21:30:36 +0800,
> Raymond wrote:
> 
>>Alien wrote:
>>
>>>Op dinsdag 7 juni 2005 15:44, schreef Raymond:
>>>
>>>
>>>>From your png, it seem that you are not using the alsamixer in the
>>>>latest version of alsa-utils.
>>>
>>>
>>>since i'm using alsa CVS for driver, kernel and lib; i'll use utils 
>>>from CVS as well...
>>
>>It seem that there are bugs in alsamixer 1.0.9a ( even CVS Rev 1.88 )
>>
>>alsamixer -V capture
>>
>>1) The volume (Line,CD,Mic,Video,Home,Aux,Mix,Mix Mono) cannot be 
>>changed in view capture.
> 
> 
> They have no "capture" volumes.
> 
> 
>>2) The Mic Select(Mic1,Mic2) and Mono Out(Mix,Mic) controls are missing 
>>in view capture.
> 
> 
> It's a so-called feature :)
> All enum controls belong to playback view, so far.
> 






-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
