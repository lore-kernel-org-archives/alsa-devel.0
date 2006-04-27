From: Hans-Christian Egtvedt <hcegtvedt@norway.atmel.com>
Subject: Re: bad page when freeing preallocated pages
Date: Thu, 27 Apr 2006 13:02:07 +0200
Message-ID: <4450A4AF.1000501@norway.atmel.com>
References: <444F2FA6.7010305@atmel.com>	<s5hslo049f5.wl%tiwai@suse.de>	<4450622C.80802@norway.atmel.com> <s5hr73jxpu6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr73jxpu6.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 27 Apr 2006 08:18:20 +0200,
> Hans-Christian Egtvedt wrote:
>> Takashi Iwai wrote:
>>> At Wed, 26 Apr 2006 10:30:30 +0200,
>>> Hans-Christian Egtvedt wrote:

<snip>

>> The interessting part is that if I preallocate a small area (4kB), then
>> the bad pages go away on rmmod. It could maybe be that we have some
>> undiscovered bug in dma_alloc_coherent() or dma_free_coherent(), but we
>> use there function calls in other drivers, so i doubt it (but keeping
>> the option open;) ).
> 
> Ah, that enlighted me.
> 
> According to your first post, snd_pcm_preallocate_pages*() is called
> like below:
> 
> 	snd_pcm_lib_preallocate_pages_for_all(chip->pcm,
> 		SNDRV_DMA_TYPE_DEV, 
> 		snd_dma_continuous_data(GFP_KERNEL),
> 		 64 * 1024, 64 * 1024);
> 
> The third argument is wrong in this case.  You have to pass struct
> device pointer there instead of snd_dma_continuous_data().

I tried that, but the result is the same. I have stored the platform
device in chip->pdev and passed this to preallocation of pages:

snd_pcm_lib_preallocate_pages_for_all(chip->pcm, SNDRV_DMA_TYPE_DEV,
			&chip->pdev->dev, 64 * 1024, 64 * 1024);

I've looked into the library and it all seems to be correct in the
deeper layers.

Thank you for you feedback. Any tips or hints to where start debugging
would be greatly appreciated.

> (Yeah, the function is messy and the clean-up is on my test tree for
> long time.)

:)

-- 
With kind regards,
Med vennlig hilsen,

Hans-Christian Egtvedt
Applications Engineer - AVR Applications Lab
Atmel Norway


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
