From: Vince <fuzzy77@free.fr>
Subject: Re: [OOPS] Alsa 0.9.4 / kernel 2.6.0-test1-mm1
Date: Mon, 21 Jul 2003 15:32:17 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F1BEB61.9040004@free.fr>
References: <Pine.LNX.4.44.0307211436010.3903-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0307211436010.3903-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sorry, I still get the oops with the patch...

--------------------------------------------------------------------
Unable to handle kernel paging request at virtual address d0c19000
  printing eip:
d0a9f07b
*pde = 0c03e067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<d0a9f07b>]    Tainted: PF  VLI
EFLAGS: 00210202
EIP is at resample_expand+0x34b/0x380 [snd_pcm_oss]
eax: d0a9f07b   ebx: 00000001   ecx: 00051e16   edx: fca8fd4b
esi: d0c23ff6   edi: cc4bf20c   ebp: d0c18ffe   esp: c7e37e58
ds: 007b   es: 007b   ss: 0068
Process festival (pid: 1271, threadinfo=c7e36000 task=cdcdaca0)
Stack: d0a9c2f2 cc4bf180 cc3239e0 c7e37e84 0000fd4a c7e36000 ffffffff 
ceac5600
        d0a9eea1 d0a9eff2 d0a9f07b cc4bf1f0 00000000 00000002 00000002 
00000000
        fd4bfd4b 000002a8 000017fd 00000800 cc4bf180 cc053a40 d0a9f56c 
cc4bf180
Call Trace:
  [<d0a9c2f2>] snd_pcm_plug_playback_channels_mask+0x72/0xe0 [snd_pcm_oss]
  [<d0a9eea1>] resample_expand+0x171/0x380 [snd_pcm_oss]
  [<d0a9eff2>] resample_expand+0x2c2/0x380 [snd_pcm_oss]
  [<d0a9f07b>] resample_expand+0x34b/0x380 [snd_pcm_oss]
  [<d0a9f56c>] rate_transfer+0x5c/0x60 [snd_pcm_oss]
  [<d0a9c6e7>] snd_pcm_plug_write_transfer+0x97/0x100 [snd_pcm_oss]
  [<d0a983e0>] snd_pcm_oss_write2+0xd0/0x150 [snd_pcm_oss]
  [<d0a98606>] snd_pcm_oss_write1+0x1a6/0x1d0 [snd_pcm_oss]
  [<d0a9a713>] snd_pcm_oss_write+0x43/0x60 [snd_pcm_oss]
  [<d0a9a6d0>] snd_pcm_oss_write+0x0/0x60 [snd_pcm_oss]
  [<c014e6f8>] vfs_write+0xb8/0x130
  [<c014e822>] sys_write+0x42/0x70
  [<c0109107>] syscall_call+0x7/0xb

Code: 66 35 00 80 eb d4 8b 45 00 c1 e8 08 eb cc 8b 45 00 c1 e8 08 66 35 
00 80 eb c2 8b 45 00 c1 e8 08 eb ba eb a6 eb b1 8b 55 00 eb bf <8b> 45 
00 eb ac 0f b6 45 00 c1 e0 08 eb a3 81 fa 00 80 00 00 b8
  <6>


> 
> Could you try the following patch? Note that this patch is a workaround 
> for your hardware, but it does not fix the oops for other users (like 
> the intel8x0 driver). I will work on this problem.
> 
> 						Jaroslav
> 
> Index: pcm_plugin.c
> ===================================================================
> RCS file: /cvsroot/alsa/alsa-kernel/core/oss/pcm_plugin.c,v
> retrieving revision 1.10
> retrieving revision 1.11
> diff -u -r1.10 -r1.11
> --- pcm_plugin.c	7 Feb 2003 08:29:08 -0000	1.10
> +++ pcm_plugin.c	21 Jul 2003 12:36:10 -0000	1.11
> @@ -56,6 +56,17 @@
>  	return 0;
>  }
>  
> +/*
> + *  because some cards might have rates "very close", we ignore
> + *  all "resampling" requests within +-5%
> + */
> +static int rate_match(unsigned int src_rate, unsigned int dst_rate)
> +{
> +	unsigned int low = (src_rate * 95) / 100;
> +	unsigned int high = (src_rate * 105) / 105;
> +	return dst_rate >= low && dst_rate <= high;
> +}
> +
>  static int snd_pcm_plugin_alloc(snd_pcm_plugin_t *plugin, snd_pcm_uframes_t frames)
>  {
>  	snd_pcm_plugin_format_t *format;
> @@ -420,7 +431,7 @@
>  
>  	/* Format change (linearization) */
>  	if ((srcformat.format != dstformat.format ||
> -	     srcformat.rate != dstformat.rate ||
> +	     !rate_match(srcformat.rate, dstformat.rate) ||
>  	     srcformat.channels != dstformat.channels) &&
>  	    !snd_pcm_format_linear(srcformat.format)) {
>  		if (snd_pcm_format_linear(dstformat.format))
> @@ -468,7 +479,7 @@
>  				ttable[v * sv + v] = FULL;
>  		}
>  		tmpformat.channels = dstformat.channels;
> -		if (srcformat.rate == dstformat.rate &&
> +		if (rate_match(srcformat.rate, dstformat.rate) &&
>  		    snd_pcm_format_linear(dstformat.format))
>  			tmpformat.format = dstformat.format;
>  		err = snd_pcm_plugin_build_route(plug,
> @@ -490,7 +501,7 @@
>  	}
>  
>  	/* rate resampling */
> -	if (srcformat.rate != dstformat.rate) {
> +	if (!rate_match(srcformat.rate, dstformat.rate)) {
>  		tmpformat.rate = dstformat.rate;
>  		if (srcformat.channels == dstformat.channels &&
>  		    snd_pcm_format_linear(dstformat.format))
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: VM Ware
> With VMware you can run multiple operating systems on a single machine.
> WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
> same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
