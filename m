From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: hardware channel mixing
Date: Sun, 05 Sep 2004 14:28:36 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094408916.4445.13.camel@krustophenia.net>
References: <Pine.HPX.4.33n.0409031451550.24397-100000@studcom.urz.uni-halle.de>
	 <1094254221.6575.94.camel@krustophenia.net>
	 <1094260793.3727.19.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1094260793.3727.19.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mjander@users.sourceforge.net
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-09-03 at 21:19, Manuel Jander wrote:
> Hi,
> 
> [snip]
> > Not quite, it's 32 mono substreams, 21 stereo.  Each mono substream
> > requires 2 voices, each stereo substream, three.  There is an extra
> > voice allocated per playback substream that is silent, and is just used
> > to generate the period interrupts.
> > 
> > I have pored over the code, and I don't understand exactly why the extra
> > voice is needed, Jaroslav said something like "if you don't use the
> > extra voice the interrupts are going faster than the voice position".  I
> > think it might be needed so that multiple can playback, each with
> > different period sizes.
> 
> Smells like incomplete hardware spec. Wasting a DMA channel for timing
> purposes sounds pretty stupid, despite it may be the only known way to
> make it work right now.

I thought about this and you may be right.  It seems like there is no
half loop interrupt for playback, only IPR_CHANNELLOOP.  This seems
wrong.

If you look at the kX project header files, 8010.h is clearly derived
from emu10k1.h.  But, there are several unknown values in the comments
that seem to be the result of reverse engineering, probably a PCI bus
capture with the Windows driver.  One of these comments refers to a half
loop interrupt.

It seems like if this were the case, then it would require a workaround
similar to the extra voice hack.  Does this seem plausible?

Lee



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
