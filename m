From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: 1.0.3rc2 release ... alsa-utils fails compiling
 aplay.
Date: Thu, 26 Feb 2004 00:19:25 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <403D3B8D.9010709@superbug.demon.co.uk>
References: <Pine.LNX.4.58.0402252108180.15215@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-30.mail.demon.net (anchor-post-30.mail.demon.net [194.217.242.88])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id BAA12463
	for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2004 01:12:06 +0100
In-Reply-To: <Pine.LNX.4.58.0402252108180.15215@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> Hello all,
> 
> 	I released 1.0.3rc2 packages. The full changelog from 1.0.2 will 
> came with the final release, but it would be nice to do some tests with 
> this code with smaller number of testers to not follow the 1.0.2 situation 
> when we have to quickly release several versions due to compilation 
> problems. Please, test the packages.
> 
> 					Thanks,
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
> 
alsa-driver-1.0.3rc2 compiles and installs ok.
alsa-lib-1.0.3rc2 compiles and installs ok.
alsa-utils-1.0.3rc2 fails with:

make[1]: Entering directory `/u/alsa/alsa-utils-1.0.3rc2/aplay'
if gcc -DHAVE_CONFIG_H -I. -I. -I../include -I../include    -g -O2 -MT 
aplay.o -MD -MP -MF ".deps/aplay.Tpo" \
   -c -o aplay.o `test -f 'aplay.c' || echo './'`aplay.c; \
then mv -f ".deps/aplay.Tpo" ".deps/aplay.Po"; \
else rm -f ".deps/aplay.Tpo"; exit 1; \
fi
aplay.c: In function `set_params':
aplay.c:841: warning: passing arg 3 of `snd_pcm_hw_params_set_rate_near' 
makes integer from pointer without a cast
aplay.c:860: warning: passing arg 3 of 
`snd_pcm_hw_params_set_period_time_near' makes integer from pointer 
without a cast
aplay.c:863: warning: passing arg 3 of 
`snd_pcm_hw_params_set_period_size_near' makes integer from pointer 
without a cast
aplay.c:867: warning: passing arg 3 of 
`snd_pcm_hw_params_set_buffer_time_near' makes integer from pointer 
without a cast
aplay.c:870: warning: passing arg 3 of 
`snd_pcm_hw_params_set_buffer_size_near' makes integer from pointer 
without a cast
aplay.c:879: warning: passing arg 2 of 
`snd_pcm_hw_params_get_period_size' from incompatible pointer type
aplay.c:879: error: too many arguments to function 
`snd_pcm_hw_params_get_period_size'
aplay.c:880: error: too many arguments to function 
`snd_pcm_hw_params_get_buffer_size'
aplay.c:886: error: too many arguments to function 
`snd_pcm_sw_params_get_xfer_align'
make[1]: *** [aplay.o] Error 1
make[1]: Leaving directory `/u/alsa/alsa-utils-1.0.3rc2/aplay'
make: *** [all-recursive] Error 1


Cheers
James


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
