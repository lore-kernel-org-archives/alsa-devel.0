From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Alsa-devel] Re: irq handler top half timestamps
Date: Fri, 10 Dec 2004 08:52:39 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0412100849470.1749@pnote.perex-int.cz>
References: <20041209180706.GA11397@elte.hu> <200412091819.iB9IJiLX013123@localhost.localdomain>
 <20041209183342.GB13132@elte.hu> <20041209220741.7562b6a0@mango.fruits.de>
 <1102626628.21688.11.camel@krustophenia.net> <20041210023548.5042f406@mango.fruits.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <jackit-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041210023548.5042f406@mango.fruits.de>
Sender: jackit-devel-admin@lists.sourceforge.net
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>, jackit-devel@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 10 Dec 2004, Florian Schmidt wrote:

> So it would be very useful, if, for example, the top half irq handler of
> the alsa driver would timestamp each IRQ with i.e. a TSC timestamp and
> expose this timestamp to the application in userspace.

We can do any timestamp in the IRQ handler (this enum can be extended):

enum sndrv_pcm_tstamp {
        SNDRV_PCM_TSTAMP_NONE = 0,
        SNDRV_PCM_TSTAMP_MMAP,
        SNDRV_PCM_TSTAMP_LAST = SNDRV_PCM_TSTAMP_MMAP,
};

And this structure is used to store timestamp value:

struct timespec tstamp;

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
