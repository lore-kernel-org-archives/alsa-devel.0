From: Steve deRosier <derosier@pianodisc.com>
Subject: Re: hw pause in USB
Date: Tue, 13 Dec 2005 09:31:57 -0800
Message-ID: <439F058D.1070600@pianodisc.com>
References: <439E2735.4060700@pianodisc.com>	<20051213091651.GA23938@turing.informatik.uni-halle.de> <s5hzmn5w8oj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hzmn5w8oj.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <ladischc@informatik.uni-halle.de>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 13 Dec 2005 10:16:51 +0100,
> Clemens Ladisch wrote:
> 
>>Steve deRosier wrote:
>>
>>>When running my player via commandline and pressing pause, I get the 
>>>following error message out of ALSA lib:
>>>
>>>ALSA lib pcm_hw.c:535:(snd_pcm_hw_pause) SNDRV_PCM_IOCTL_PAUSE failed: 
>>>Function not implemented
>>>
>>>I'm guessing that the USB driver doesn't implement pause.
>>
>>Yes.
>>

Perhaps it should?!?

>>
>>>My program implements pause by calling snd_pcm_pause( hPCM, 1 );.
>>
>>You cannot call snd_pcm_pause() when the device doesn't support it
>>(it should have returned an error code).
>>See snd_pcm_hw_params_can_pause().
>>
>>
>>>* Is there a better way to implement pause in my client program?  
>>
>>snd_pcm_stop()
> 
> 
> Heh, it's snd_pcm_drop() in alsa-lib :)
> 
> snd_pcm_drop() will stop DMA and abandon the whole data on the ring
> buffer.  To restart the stream, you have to call snd_pcm_prepare()
> and fill the rest data again (and start with snd_pcm_start() if
> necessary).
> 
> So, obviously, this procedure isn't "better" than snd_pcm_pause(),
> but works with all devices as a fallback.
> 

So, do I use snd_pcm_stop() or snd_pcm_drop()?  Also, if snd_pcm_drop() will abandon the data in the ringbuffer, how do I know what it abandoned so I can put the right data back to restart?  And what is the maximum amount of data it might discard?  After sending the samples to Alsa, my program doesn't normally keep track of that data so I'll need to know how much to buffer as a "pause undo" buffer.

On a design note, shouldn't the library hide this issue from the user?  I understand the point of alsa is to provide a powerful library for advanced apps, but most applications aren't going to care HOW pause is implemented and exposing the fact that some devices implement it and some don't really defeat the purpose of having a library API in the first place.  Don't take my criticism wrong, I think Alsa is great. But, having to put this sort of hardware based check in my code hurts.  And frankly also hurts my reputation around here since I didn't realize that snd_pcm_pause() actually should be titled snd_pcm_pause_if_device_supports_pause_else_burp() and I let a release out the door with this broken (my responsibility, I should've tested pause with USB devices; but man, who would've thunk it would've been an issue).

Seems to me that the library should take device differences into account and just Do The Right Thing, or that all the drivers must support such basic functionality in decent way, even if the driver has to simulate in software a feature the hardware can't support (if that is indeed the case here).

Again, don't take me to be too harsh.  I'm just trying to stimulate positive discussion so we can improve alsa if warranted in this case.  I'll even help w/ the patches if: 1. we can agree on what needs to be done and 2. if someone can point me to where (file/function) it needs to be fixed.

In the mean time I'll settle with getting my app to work right.

- Steve


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
