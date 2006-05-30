From: CE <ce7@sbcglobal.net>
Subject: Re: xruns with snd_intel8x0
Date: Tue, 30 May 2006 01:31:05 -0700
Message-ID: <20060530013105.0e4f8042.ce7@sbcglobal.net>
References: <20060410022151.96c42bea.ce7@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060410022151.96c42bea.ce7@sbcglobal.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

	Disabled ACPI and APM yet the problem still remains.  So am I
to assume IRQ problems?  Any clues would be helpful before ripping the
machine open.


You wrote:

> 	Hi, I've been having a terrible time with ALSA and a SiS SI7012
> (with ALC100,100P at 0xdc00).  Using a vanilla kernel and have tried
> with preempt both on and off.  Turning on debugging level 2 I get the
> following when an xrun occurs:
> 
> XRUN: pcmC0D0p
>  [<f8babd77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
>  [<f8b74652>] snd_intel8x0_interrupt+0x182/0x230 [snd_intel8x0]
>  [<c013154d>] handle_IRQ_event+0x3d/0x70
>  [<c01315e3>] __do_IRQ+0x63/0xc0
>  [<c011ab33>] __do_softirq+0x43/0x90
>  [<c0104a59>] do_IRQ+0x19/0x30
>  [<c0102d12>] common_interrupt+0x1a/0x20
> XRUN: pcmC0D0p
>  [<f8babd77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
>  [<f8b74652>] snd_intel8x0_interrupt+0x182/0x230 [snd_intel8x0]
>  [<c013154d>] handle_IRQ_event+0x3d/0x70
>  [<c01315e3>] __do_IRQ+0x63/0xc0
>  [<c0104a59>] do_IRQ+0x19/0x30
>  [<c0102d12>] common_interrupt+0x1a/0x20
> Unexpected hw_pointer value [2] (stream = 0, delta: -418, max jitter =
> 4456): wrong interrupt acknowledge? [<f8badfa9>] snd_pcm_update_hw_ptr
> +0x129/0x260 [snd_pcm] [<f8ba8bb5>] snd_pcm_common_ioctl1+0x695/0x1080
> [snd_pcm] [<f8b746ca>] snd_intel8x0_interrupt+0x1fa/0x230 [snd_intel8x0]
>  [<c011ab33>] __do_softirq+0x43/0x90
>  [<c02e4e55>] schedule+0x2f5/0x5c0
>  [<c02e54fc>] schedule_timeout+0x4c/0xc0
>  [<f8bab4af>] snd_pcm_lib_write_transfer+0x9f/0xd0 [snd_pcm]
>  [<c0162578>] poll_freewait+0x48/0x60
>  [<c0162a82>] do_select+0x422/0x4a0
>  [<f8ba9adf>] snd_pcm_playback_ioctl1+0x5f/0x4d0 [snd_pcm]
>  [<f8baa9ec>] snd_pcm_kernel_playback_ioctl+0x2c/0x40 [snd_pcm]
>  [<f8bbcbf5>] snd_pcm_oss_ioctl+0xa65/0xbe0 [snd_pcm_oss]
>  [<c0161c0a>] do_ioctl+0x2a/0x80
>  [<c0161cb2>] vfs_ioctl+0x52/0x2b0
>  [<c016392b>] sys_select+0x11b/0x200
>  [<c0161f55>] sys_ioctl+0x45/0x70
>  [<c0102b45>] syscall_call+0x7/0xb
> 
> 	Can anybody shed some insight into this?
