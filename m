From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Problem with ALSA on PPC
Date: Tue, 13 Jun 2006 14:22:15 -0400
Message-ID: <1150222936.19205.43.camel@mindpipe>
References: <1149891511.3894.296.camel@mindpipe>
	<1149902770.13569.10.camel@mindpipe>
	<1149933605.5081.1.camel@localhost.localdomain>
	<1149958755.14253.24.camel@mindpipe> <s5h7j3md4bf.wl%tiwai@suse.de>
	<1150149444.3062.55.camel@mindpipe> <s5hver5bdp5.wl%tiwai@suse.de>
	<20060613105721.GA25976@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060613105721.GA25976@roarinelk.homelinux.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: Takashi Iwai <tiwai@suse.de>, Adrian McMenamin <adrian@mcmen.demon.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-06-13 at 12:57 +0200, Manuel Lauss wrote:
> I just cross-compiled alsa-lib for SH4 on x86, and
> --prefix works without problems:
> 
> CFLAGS="-Os -m4 -ml" ./configure --prefix=/usr --host=sh4-unknown-linux-gnu
> --target=sh4-unknown-linux-gnu --build=i686-pc-linux-gnu
> 
> make DESTDIR=/var/chroot/sh install
> 
> /var/chroot/sh is my target's NFSroot.
> 
> shlinux # / aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: sh7760-ac97 [sh7760-ac97-0], device 0: sh7760-ac97-PCM []
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0

Thanks, it works perfectly.

Lee
