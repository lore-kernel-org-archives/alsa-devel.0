From: Raymond <rayau@netvigator.com>
Subject: Re: CVS compile issue
Date: Sun, 17 Jul 2005 11:58:00 +0800
Message-ID: <42D9D747.6090702@netvigator.com>
References: <1121482166.12420.80.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1121482166.12420.80.camel@mindpipe>
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


http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-driver/pci/au88x0/au88x0.c?r1=1.6&r2=1.7&sortby=date&diff_format=u
* fixed the DMA allocation.
   pci_set_dma_mask() is called together with pci_set_consistent_dma_mask().
   also clean up the double check of mask.
http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-driver/pci/au88x0/au88x0.c?r1=1.8&r2=1.9&sortby=date&diff_format=u
* added snd_card_set_dev() macro.
* sysfsfied more pci, isapnp and usb drivers.


These patches to alsa-driver (related to kernel 2.6) are missing when 
the au88x0 merged into alsa-kernel.

http://cvs.sourceforge.net/viewcvs.py/*checkout*/alsa/alsa-kernel/pci/au88x0/au88x0.c?rev=1.18


Lee Revell wrote:
> Kernel is 2.6.12-RT-V0.7.51-28.
> 
>   CC [M]  /smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97/ac97_codec.o
> In file included from /smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97/ac97_codec.c:1:
> /smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97/../../alsa-kernel/pci/ac97/ac97_codec.c: In function 'snd_ac97_resume':
> /smb/rlrevell/cvs/alsa/alsa-driver/include/adriver.h:644: sorry, unimplemented: inlining failed in call to 'msecs_to_jiffies': function body not available
> /smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97/../../alsa-kernel/pci/ac97/ac97_codec.c:2252: sorry, unimplemented: called from here
> /smb/rlrevell/cvs/alsa/alsa-driver/include/adriver.h:644: sorry, unimplemented: inlining failed in call to 'msecs_to_jiffies': function body not available
> /smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97/../../alsa-kernel/pci/ac97/ac97_codec.c:2264: sorry, unimplemented: called from here
> make[4]: *** [/smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97/ac97_codec.o] Error 1
> make[3]: *** [/smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97] Error 2
> make[2]: *** [/smb/rlrevell/cvs/alsa/alsa-driver/pci] Error 2
> make[1]: *** [_module_/smb/rlrevell/cvs/alsa/alsa-driver] Error 2
> make[1]: Leaving directory `/smb/rlrevell/kernel-source/linux-2.6.12-c3'
> make: *** [compile] Error 2
> 



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
