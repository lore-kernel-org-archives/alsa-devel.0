From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: emu10k1 multichannel playback design (was Re: [PATCH] emu10k1:
 add interval timer support)
Date: Sun, 26 Sep 2004 13:38:13 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409261335020.1744@pnote.perex-int.cz>
References: <Pine.LNX.4.58.0409241546570.2289@pnote.perex-int.cz>
 <200409241453.i8OErtVR029650@localhost.localdomain>  <s5hk6uj3dko.wl@alsa2.suse.de>
 <1096059735.11589.45.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1096059735.11589.45.camel@krustophenia.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 24 Sep 2004, Lee Revell wrote:

> While certainly easier to implement in the driver, the problem with a
> single 16 channel device is that it wastes voices.  In the example of a
> non-ReWire compliant app (which is the same as working around a non-JACK
> aware app), you would have to use 16 voices for each open, even if the
> device will only use 2 of the channels.

No, read carefully my messages:

- legacy applications will use standard device
- multichannel applications will use one (or more) multichannel device

Then you need an application like ReWire which will touch / modify the 
universal controls to reroute channels from bloth multichannel and legacy 
application to appropriate FX bus.

Everybody will be happy with minimal count of extended voices.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
