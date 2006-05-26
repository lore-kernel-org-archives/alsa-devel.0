From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: TODO list
Date: Fri, 26 May 2006 18:30:36 +0100
Message-ID: <44773B3C.4020206@superbug.co.uk>
References: <4475F316.5000908@superbug.co.uk>	<s5hpsi1qc1h.wl%tiwai@suse.de>	<4476E687.10608@superbug.co.uk>	<s5hfyiwpzoe.wl%tiwai@suse.de>	<44772DE3.60104@superbug.co.uk>
	<s5hslmwu3s2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from anchor-post-34.mail.demon.net (anchor-post-34.mail.demon.net
	[194.217.242.92])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3AAB613E
	for <alsa-devel@alsa-project.org>;
	Fri, 26 May 2006 19:30:37 +0200 (MEST)
In-Reply-To: <s5hslmwu3s2.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>> For mmap, all that happens is that the application asks for a mmap 
>> address from the kernel.
>> If we could get the kernel to manipulate shared memory, so that the mmap 
>> address given to the application is shared with the daemon, surely that 
>> would work.
>>     
>
> The sharing of memory between the app and the daemon is easy via a
> simple mmap invoked from both sides.  But, sharing the mmapped buffer
> from a sound driver between the daemon and the app over yet another
> driver is a tough problem, because the buffer is strictly bound to the
> sound card hardware.
>   

> We need to consider first the basic design more deeply.
> For example, even if we get the mmapped buffer, it's not enough for
> the whole operation, especially when the period/buffer size doesn't
> match with whta OSS requires.
>
>
> Takashi
>   

I was thinking more along the lines of User App -> OSS kernel shim -> 
userland daemon buffer, one buffer per user app -> alsa-lib.
So, the mmap would not be a real mmap, it would be a simple matter of 
tricking the User app into thinking it is mmapped. It would be a double 
buffer really.
So, the daemon buffer would just be whatever size the OSS user app 
wanted, and the daemon would then pass it's contents to alsa-lib or 
jackd as and when needed.
All this would probably only be possible if some high res timer source 
(e.g. the system timer) was used to trigger the period boundaries. I 
think I mentioned that idea some time ago. Maybe we should just aim for 
that TODO item to help dmix work better at 44100Hz, and then worry about 
the OSS kernel shim after that.
Maybe by that time....OSS would have disappeared! :-)

James
