From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Strange err=25 result.
Date: Thu, 15 Jan 2004 00:50:04 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4005E3BC.4060504@superbug.demon.co.uk>
References: <40054D7E.5010902@superbug.demon.co.uk> <Pine.LNX.4.58.0401141511120.1877@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0401141511120.1877@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Wed, 14 Jan 2004, James Courtier-Dutton wrote:
> 
> 
>>Some debug output from calling snd_pcm_wait() when a USB device is 
>>unplugged.
>>
>>(pcm_hw.c from /alsa-lib/src/pcm/pcm_hw.c)
>>file=pcm_hw.c:406 function=snd_pcm_hw_status err=25
>>pcm_hw.c: snd_pcm_hw_status() SNDRV_PCM_IOCTL_STATUS failed.
>>
>>According to errno.h,
>>#define ENOTTY          25      /* Not a typewriter */
>>
>>I would think that the following would be a better err result.
>>#define ENODEV          19      /* No such device */
>>or even
>>#define EPIPE           32      /* Broken pipe */
>>
>>I have looked through alsa-lib and alsa-kernel and cannot find any place 
>>in the code that sets errno to 25!
>>
>>Can anybody help?
> 
> 
> Consult the toplevel filesystem routines. In case when the device is 
> disconnected, all i/o (filesystem operation) calls are redirected to empty 
> structure, so the Linux kernel filesystem code probably returns ENOTTY 
> errors when no ioctl/read/write callbacks are associated to the device.
> 
> 						Jaroslav

Thank you, that makes sense. :-)

Also, what should
snd_pcm_wait()
and
snd_pcm_state()
return if the USB device is unplugged.

At the moment, snd_pcm_wait() just hangs around until the timeout and 
returns errno -5
and snd_pcm_state() still returns state=3 which is SND_PCM_STATE_RUNNING

I would hardly say the the card is still in "RUNNING" state if you 
physically remove the card from the system!

I would prefer snd_pcm_wait() to imeadiately exit with an errno, and 
snd_pcm_state() to return a new state of "SND_PCM_STATE_DISCONNECTED" or 
similar.

Can I do what I want with snd_pcm_wait or not?

Cheers
James


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
