From: Jonathan Andrews <jon@jonshouse.co.uk>
Subject: Re: Random process lockup on ARM board:
 alsa-lib-1.0.25, FUTEX_WAIT_PRIVATE
Date: Thu, 08 Mar 2012 13:47:19 +0000
Message-ID: <1331214439.27232.12.camel@jonspc>
References: <1329393691.6830.20.camel@jonspc>
	<1329512682.29051.1.camel@jonspc> <1329570128.6670.0.camel@jonspc>
	<4F400BBF.9020707@ladisch.de> <1329603022.1089.57.camel@jonspc>
	<4F41FC28.1070605@ladisch.de> <1329926198.22918.10.camel@jonspc>
	<4F45167A.6080706@ladisch.de> <1329933773.24266.44.camel@jonspc>
	<4F58736F.6010500@ladisch.de> <1331199625.22455.7.camel@jonspc>
	<4F588213.2030600@ladisch.de> <1331203724.22455.44.camel@jonspc>
	<4F589B58.6090203@ladisch.de>
Reply-To: jon@jonshouse.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.jonshouse.co.uk (unknown [91.84.151.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AE8810BA87
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 14:47:21 +0100 (CET)
In-Reply-To: <4F589B58.6090203@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-03-08 at 12:43 +0100, Clemens Ladisch wrote:
> Jonathan Andrews wrote:
> > On Thu, 2012-03-08 at 10:55 +0100, Clemens Ladisch wrote:
> >> Jonathan Andrews wrote:
> >>> I'm using this script to build both static and dynamic versions of the
> >>> alsalib. Can you check the configure arguments are correct.
> >>
> >> They look correct.
> >
> > Tried to compile my application, still fails asking for pthreads.
> 
> The configure.in file contains the patch, but the generated configure
> script does not have it (although its time stamp is newer).
> Please ensure that you've run autoconf (although make should do this
> automatically).
> 
> 

Getting closer, alsalib now builds without the need for pthreads but
seems to insist on dlopen dlclose even in static lib ?


Compiling udp-many-way-audio-rx.c                        -> udp-many-way-audio-rx_alsa_arms (static)
/usr/lib/gcc/arm-linux-gnueabi/4.3.2/../../../../arm-linux-gnueabi/lib/libasound.a(pcm_dshare.o): In function `snd_pcm_dshare_sync_ptr':
pcm_dshare.c:(.text+0x6a4): warning: Warning: snd_pcm_hwsync() is deprecated, consider to use snd_pcm_avail()
/usr/lib/gcc/arm-linux-gnueabi/4.3.2/../../../../arm-linux-gnueabi/lib/libasound.a(pcm_direct.o): In function `snd1_pcm_direct_parse_open_conf':
pcm_direct.c:(.text+0x58c8): warning: Using 'getgrnam' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
/usr/lib/gcc/arm-linux-gnueabi/4.3.2/../../../../arm-linux-gnueabi/lib/libasound.a(pcm_shm.o): In function `_snd_pcm_shm_open':
pcm_shm.c:(.text+0x27dc): warning: Using 'gethostbyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
/usr/lib/gcc/arm-linux-gnueabi/4.3.2/../../../../arm-linux-gnueabi/lib/libasound.a(dlmisc.o): In function `snd_dlopen':
dlmisc.c:(.text+0x38): undefined reference to `dlopen'
/usr/lib/gcc/arm-linux-gnueabi/4.3.2/../../../../arm-linux-gnueabi/lib/libasound.a(dlmisc.o): In function `snd_dlclose':
dlmisc.c:(.text+0x90): undefined reference to `dlclose'
/usr/lib/gcc/arm-linux-gnueabi/4.3.2/../../../../arm-linux-gnueabi/lib/libasound.a(dlmisc.o): In function `snd_dlsym_verify':
dlmisc.c:(.text+0x190): undefined reference to `dlsym'
/usr/lib/gcc/arm-linux-gnueabi/4.3.2/../../../../arm-linux-gnueabi/lib/libasound.a(dlmisc.o): In function `snd_dlsym':
dlmisc.c:(.text+0x2f8): undefined reference to `dlsym'
/usr/lib/gcc/arm-linux-gnueabi/4.3.2/../../../../arm-linux-gnueabi/lib/libasound.a(pcm_ladspa.o): In function `snd_pcm_ladspa_free_plugins':
pcm_ladspa.c:(.text+0x3cc): undefined reference to `dlclose'
/usr/lib/gcc/arm-linux-gnueabi/4.3.2/../../../../arm-linux-gnueabi/lib/libasound.a(pcm_ladspa.o): In function `snd_pcm_ladspa_check_file':
pcm_ladspa.c:(.text+0x41c4): undefined reference to `dlopen'
pcm_ladspa.c:(.text+0x41e4): undefined reference to `dlsym'
pcm_ladspa.c:(.text+0x4250): undefined reference to `dlclose'
pcm_ladspa.c:(.text+0x4344): undefined reference to `dlclose'
pcm_ladspa.c:(.text+0x43b0): undefined reference to `dlclose'
collect2: ld returned 1 exit status
~                                                 
