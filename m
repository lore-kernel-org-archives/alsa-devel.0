From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Mixer improvements
Date: Mon, 12 Sep 2005 14:44:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0509121434440.9569@tm8103.perex-int.cz>
References: <43241A35.8080903@superbug.co.uk> <s5hr7buh3qv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr7buh3qv.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 12 Sep 2005, Takashi Iwai wrote:

> > 1) Unsigned integer index to percent <-> dB function.
> > 2) Integer for Analog or Digital path. This will indicate which side of 
> > 3) Link information.
> > 4) Alternatively, we could implement this in alsa-lib, and just add 

I agree that 1 is the main required extension. 2 and 3 are optional in my 
eyes.

> Moreover, we should be careful to handle the value <-> dB conversion.
> The dB isn't integer in general, and defining the fixed resolution is
> no generic solution.

It's signed integer - fixed float resolution (* 100) in my implementation. 
I think that it's enough for our purpose.

> Adding a dB info into the driver would be required for the USB and HDA 
> stuff, at least, since they can (or need) retrieve such information from 
> the hardware directly. Meanwhile, others are basically given statically 
> - e.g. a simple table look-up for each ac97 codec.  This isn't 
> necessarily in the kernel code at all.

I agree, the alsa-lib should have a database containing this static 
information. Also, I think that this information does not belong to the 
universal control API at all. We need to decide, if we need another 
midlevel module providing this information, or in my eyes, better way 
might be to use the hwdep device and pass this information to the user 
space. The alsa-lib modules driving the specific hardware will parse this 
information and do own things with it. Perhaps, we can pass simple text 
from the driver to user space. In this way, the procfs or devfs might be 
used.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
