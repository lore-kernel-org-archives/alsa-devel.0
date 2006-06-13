From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: Problem with ALSA on PPC
Date: Tue, 13 Jun 2006 12:57:21 +0200
Message-ID: <20060613105721.GA25976@roarinelk.homelinux.net>
References: <1149891511.3894.296.camel@mindpipe>
	<1149902770.13569.10.camel@mindpipe>
	<1149933605.5081.1.camel@localhost.localdomain>
	<1149958755.14253.24.camel@mindpipe> <s5h7j3md4bf.wl%tiwai@suse.de>
	<1150149444.3062.55.camel@mindpipe> <s5hver5bdp5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hver5bdp5.wl%tiwai@suse.de>
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
Cc: Adrian McMenamin <adrian@mcmen.demon.co.uk>, Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 13, 2006 at 11:35:34AM +0200, Takashi Iwai wrote:
> At Mon, 12 Jun 2006 17:57:23 -0400,
> Lee Revell wrote:
> > 
> > On Mon, 2006-06-12 at 13:03 +0200, Takashi Iwai wrote:
> > > At Sat, 10 Jun 2006 12:59:15 -0400,
> > > Lee Revell wrote:
> > > > > > I found the problem by installing strace on the PPC board.  alsa-lib is
> > > > > > looking for its config files using the original path from the build
> > > > > > host.  Either my build environment is still incorrect or it's a bug -
> > > > > > probably the former ;-)
> > > > > > 
> > > > > > Once I am done maybe I will write an embedded ALSA HOWTO.
> > > > > > 
> > > > > > Lee
> > > > > > 
> > > > > 
> > > > > I had/have a very similar problem with the Dreamcast - I can only use
> > > > > the oss emulation
> > > > > 
> > > > > Asking about here didn't get me an answer so I await any answers to your
> > > > > problem with anticipation...
> > > > > 
> > > > > / # aplay -l
> > > > > **** List of PLAYBACK Hardware Devices ****
> > > > > aplay: device_list:230: control open (0): Invalid argument
> > > > 
> > > > I don't know how I ever could have solved this without strace - the ALSA
> > > > library is a twisty maze of function pointers.
> > > 
> > > Yeah, plugins hell.
> > > 
> > > >  Have you looked into
> > > > porting strace to your platform?
> > > 
> > > The open/close of all config stuff is done only in src/input.c and
> > > output.c.  The open of device files is done via snd_open_device()
> > > defined in include/local.h.  So, checking these entries cover most of
> > > open/close operations in alsa-lib.
> > 
> > How can I build alsa-lib with a non-standard --prefix, but at runtime
> > have it look for its config files in the standard location?  IOW how do
> > I prevent the --prefix from being prepended?
> 
> How about specifying --datadir=/usr/share explicitly?
> The default config directory is $DATADIR/alsa/alsa.conf.


I just cross-compiled alsa-lib for SH4 on x86, and
--prefix works without problems:

CFLAGS="-Os -m4 -ml" ./configure --prefix=/usr --host=sh4-unknown-linux-gnu
--target=sh4-unknown-linux-gnu --build=i686-pc-linux-gnu

make DESTDIR=/var/chroot/sh install

/var/chroot/sh is my target's NFSroot.

shlinux # / aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: sh7760-ac97 [sh7760-ac97-0], device 0: sh7760-ac97-PCM []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

-- 
 ml.
