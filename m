From: Andrew Gaydenko <a@etver.com>
Subject: Re: build error in pcm_native.c
Date: Fri, 16 Jul 2004 14:41:40 +0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200407161441.40443@goldspace.net>
References: <200407161357.56902@goldspace.net> <200407161414.54729@goldspace.net> <s5hn0206yaq.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0206yaq.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Have applied the patch. Unfortunately, the same: 

gcc -D__KERNEL__ -DMODULE=1 -I/wrk/cvs/alsa/alsa-driver/include  -I/lib/modules/2.4.26-lck1/build/include -O2 -mpreferred-stack-boundary=2 -march=i686 -D__SMP__ -DCONFIG_SMP -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc -iwithprefix include  -DKBUILD_BASENAME=pcm_native   -c -o pcm_native.o pcm_native.c
pcm_native.c: In function `snd_pcm_mmap_data_Rsmp_c77fab7a':
pcm_native.c:3157: warning: passing arg 1 of `remap_page_range_Rsmp_69d01e73' makes integer from pointer without a cast
pcm_native.c:3157: error: incompatible type for argument 4 of `remap_page_range_Rsmp_69d01e73'
pcm_native.c:3157: error: too many arguments to function `remap_page_range_Rsmp_69d01e73'
make[1]: *** [pcm_native.o] Error 1

Andrew

======= On Friday 16 July 2004 14:28, you wrote: =======
At Fri, 16 Jul 2004 14:14:54 +0400,
Andrew Gaydenko wrote:
> 
> There are no uncommented strings for this macro. The only is:
> 
> /* #undef CONFIG_OLD_REMAP_PAGE_RANGE */

Well then configure script couldn't detect it.
Please try the attached patch.


> Andrew
> 
> P.S. Must I reply to tiwai@suse.de or alsa-devel@lists.sourceforge.net
>      or both?

Both please.  Otherwise the information won't go outside.
I don't like to keep such things secret :)


Takashi



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
