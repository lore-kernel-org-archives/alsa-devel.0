From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: emu10k1.h + ctl id
Date: Fri, 13 Aug 2004 15:02:56 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0408131451450.1779@pnote.perex-int.cz>
References: <200408131235.i7DCZfAo021971@www4.pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200408131235.i7DCZfAo021971@www4.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 13 Aug 2004, Peter Zubaj wrote:

> Hi,
> 
> emu10k1 driver exports some hwdep ioctls. 
> Some of them use emu10k1_fx8010_control_gpr_t struct (definied in
> emu10k1.h).
> There is one member snd_ctl_elem_id_t id.
> Problem is that alsa try to hide internal structs from users space and
> this member needs to be accessible from userspace program.
> Can I change id member to something like this ?
> 
> insigned int iface; or this can be sndrv_ctl_elem_iface iface ????
> unsigned char name[44];
> unsigned int index;

I prefer to redefine the snd_ctl_elem_id_t (for example
emu10k1_ctl_elem_id_t). The public data from emu10k1.h should be
moved to alsa-lib/include/sound/emu10k1.h at first and applications
should use only '#include <alsa/sound/emu10k1.h>' header file.

I've commited an initial version of alsa/sound/emu10k1.h now.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
