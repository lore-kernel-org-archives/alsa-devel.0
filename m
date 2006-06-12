From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Problem with ALSA on PPC
Date: Mon, 12 Jun 2006 17:57:23 -0400
Message-ID: <1150149444.3062.55.camel@mindpipe>
References: <1149891511.3894.296.camel@mindpipe>
	<1149902770.13569.10.camel@mindpipe>
	<1149933605.5081.1.camel@localhost.localdomain>
	<1149958755.14253.24.camel@mindpipe>  <s5h7j3md4bf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h7j3md4bf.wl%tiwai@suse.de>
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
Cc: Adrian McMenamin <adrian@mcmen.demon.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-06-12 at 13:03 +0200, Takashi Iwai wrote:
> At Sat, 10 Jun 2006 12:59:15 -0400,
> Lee Revell wrote:
> > > > I found the problem by installing strace on the PPC board.  alsa-lib is
> > > > looking for its config files using the original path from the build
> > > > host.  Either my build environment is still incorrect or it's a bug -
> > > > probably the former ;-)
> > > > 
> > > > Once I am done maybe I will write an embedded ALSA HOWTO.
> > > > 
> > > > Lee
> > > > 
> > > 
> > > I had/have a very similar problem with the Dreamcast - I can only use
> > > the oss emulation
> > > 
> > > Asking about here didn't get me an answer so I await any answers to your
> > > problem with anticipation...
> > > 
> > > / # aplay -l
> > > **** List of PLAYBACK Hardware Devices ****
> > > aplay: device_list:230: control open (0): Invalid argument
> > 
> > I don't know how I ever could have solved this without strace - the ALSA
> > library is a twisty maze of function pointers.
> 
> Yeah, plugins hell.
> 
> >  Have you looked into
> > porting strace to your platform?
> 
> The open/close of all config stuff is done only in src/input.c and
> output.c.  The open of device files is done via snd_open_device()
> defined in include/local.h.  So, checking these entries cover most of
> open/close operations in alsa-lib.

How can I build alsa-lib with a non-standard --prefix, but at runtime
have it look for its config files in the standard location?  IOW how do
I prevent the --prefix from being prepended?

I am generating a ramdisk image that is transferred over to a PPC board,
and except for this problem, alsa-lib works on the target.

Looking at ./configure options, it seems like it's not possible?

Lee
