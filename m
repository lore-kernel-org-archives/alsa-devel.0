From: Niklas Werner <bergtroll@gmx.li>
Subject: Re: usb-audio
Date: Fri, 31 Oct 2003 09:23:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310310923.02399.bergtroll@gmx.li>
References: <20031027180300.GA5016@Zeryn> <200310301342.14872.bergtroll@gmx.li> <s5hoevywlst.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hoevywlst.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 30. Oktober 2003 20:46 wurde geschrieben:
> At Thu, 30 Oct 2003 13:42:14 +0100,
>

> hmm, really weird.
>
> meanwhile, i rewrote snd_pcm_linear_convert() without goto trick.
> could you try the attached patch?
... you don't really want to know...


Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 16384 (LWP 22147)]
0x0fd41564 in snd_pcm_linear_conv_xx12_xx21 (
    src=0x104e4000 <Address 0x104e4000 out of bounds>, dst=0x30c28590 "", 
    src_step=4, dst_step=4, frames=7835) at pcm_linear.c:303
303     DEF_CONV(conv_xx12_xx21,l_conv_xx12_xx21);
(gdb) bt
#0  0x0fd41564 in snd_pcm_linear_conv_xx12_xx21 (
    src=0x104e4000 <Address 0x104e4000 out of bounds>, dst=0x30c28590 "", 
    src_step=4, dst_step=4, frames=7835) at pcm_linear.c:303
#1  0x0fd429f4 in snd_pcm_linear_convert (dst_areas=0x104d1f18, 
dst_offset=0, 
    src_areas=0x7fffcf10, src_offset=0, channels=2, frames=16384, 
convidx=0)
    at pcm_local.h:362
#2  0x0fd435a0 in snd_pcm_linear_write_areas (pcm=0x0, areas=0x1, 
    offset=2147471120, size=12, slave_areas=0x0, slave_offset=1140885572, 
    slave_sizep=0xfdb408c) at pcm_linear.c:722
#3  0x0fd3f808 in snd_pcm_plugin_write_areas (pcm=0x2, areas=0x7fffcf10, 
    offset=0, size=273489688) at pcm_plugin.c:365
#4  0x0fd35d94 in snd_pcm_write_areas (pcm=0x104db890, areas=0xfd41554, 
    offset=0, size=273489688, func=0) at pcm.c:6206
#5  0x0fd3fc14 in snd_pcm_plugin_writei (pcm=0x104db600, 
buffer=0x30c28590, 
    size=273489688) at pcm_plugin.c:436
#6  0x0fd2ec3c in snd_pcm_writei (pcm=0x0, buffer=0x0, size=0)
    at pcm_local.h:368
#7  0x10078718 in outputaudio ()
#8  0x1007837c in outputaudio ()
#9  0x1002ed74 in main ()



Niklas
-- 



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
