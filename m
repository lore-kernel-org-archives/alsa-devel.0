From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Alsa-devel] Re: irq handler top half timestamps
Date: Fri, 10 Dec 2004 08:41:58 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0412100840520.1749@pnote.perex-int.cz>
References: <20041209180706.GA11397@elte.hu>  <200412091819.iB9IJiLX013123@localhost.localdomain>
  <20041209183342.GB13132@elte.hu>  <20041209220741.7562b6a0@mango.fruits.de>
 <1102626628.21688.11.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <jackit-devel-admin@lists.sourceforge.net>
In-Reply-To: <1102626628.21688.11.camel@krustophenia.net>
Sender: jackit-devel-admin@lists.sourceforge.net
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>, Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>, jackit-devel@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 9 Dec 2004, Lee Revell wrote:

> Doesn't ALSA already do this?  IIRC when you call snd_pcm_period_elapsed
> in the ALSA irq handler the PCM stream is timestamped.

Exactly. We need only use continuous (monotonic) timer source from 2.6 
kernels, because standard gettimeofday() might slip when time is corrected 
(from an NTP source, for example).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
