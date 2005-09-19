From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] AZT3328 driver update (#2)
Date: Mon, 19 Sep 2005 11:24:25 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0509191118580.5074-100000@studcom.urz.uni-halle.de>
References: <20050919085041.GA6292@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050919085041.GA6292@rhlx01.fht-esslingen.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: andi@lisas.de
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Andreas Mohr wrote:
> On Fri, Sep 16, 2005 at 08:55:34PM -0400, Lee Revell wrote:
> > On Sat, 2005-09-17 at 01:48 +0200, Andreas Mohr wrote:
> > > - FOUND the 1us DirectX timer area (yay!), made the code respect it properly
> >
> > You should add support for the ALSA timer API if possible, it's actually
> > quite simple.  This will allow the ALSA sequencer to use it.  See
> > sound/pci/emu10k1/timer.c for an example.
>
> Is there any way (or a best way) to test this functionality?

There is a stupid test program in alsa-lib/test/.  Alternatively, set
the seq_default_timer_* parameters of the snd-seq module and play some
MIDI files.

The parameters for sound card timer devices are:

class: 2  (= SNDRV_TIMER_CLASS_CARD)
subclass: 0 (not used here)
card: the card number
device: 0 (for the 1st device)
subdevice: 0 (not used here)


HTH
Clemens



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
