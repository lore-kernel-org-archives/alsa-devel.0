From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: hardware channel mixing
Date: Mon, 6 Sep 2004 13:54:37 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409061347340.8854@linux.local>
References: <Pine.HPX.4.33n.0409031451550.24397-100000@studcom.urz.uni-halle.de>
  <1094254221.6575.94.camel@krustophenia.net>  <1094260793.3727.19.camel@localhost>
 <1094408916.4445.13.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1094408916.4445.13.camel@krustophenia.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: mjander@users.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 5 Sep 2004, Lee Revell wrote:

> If you look at the kX project header files, 8010.h is clearly derived
> from emu10k1.h.  But, there are several unknown values in the comments
> that seem to be the result of reverse engineering, probably a PCI bus
> capture with the Windows driver.  One of these comments refers to a half
> loop interrupt.
> 
> It seems like if this were the case, then it would require a workaround
> similar to the extra voice hack.  Does this seem plausible?

Maybe. But it forces us to use only two periods per ring buffer. It can be
easy to add an extra check for this case and don't allocate extra voice
for it. It still might be that it won't work correctly (I think that emu
chips interrupt a bit earlier and not all samples are transferred via PCI
bus at the time). Also note that the current code uses a ccis correction
for the extra voice (I don't know what this is - probably some cache or
interpolation correction). Without complete specs describing the exact
hardware behaviour, it's difficult to do a proper driver design.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
