From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Driver code with mpc5200 pointer problem.
Date: Tue, 28 Apr 2009 10:00:02 +0100
Message-ID: <20090428090002.GE14626@sirena.org.uk>
References: <9e4733910904270702w317c8c62vbee38230979ad121@mail.gmail.com>
	<20090427140554.GB20591@sirena.org.uk>
	<9e4733910904270716v289e6d5exaf6e17331786ea11@mail.gmail.com>
	<20090427142437.GF20591@sirena.org.uk>
	<9e4733910904270742l751e660bg66844b98fe261f23@mail.gmail.com>
	<s5h4owa5f1y.wl%tiwai@suse.de>
	<9e4733910904270804k6ed079d4h16b433b6f8a06fc7@mail.gmail.com>
	<alpine.LNX.2.00.0904271707000.25064@eeebox2.perex-int.cz>
	<20090427151512.GI20591@sirena.org.uk>
	<s5hzle11fax.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DAA8A24417
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 11:00:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hzle11fax.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 28, 2009 at 08:08:06AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > On Mon, Apr 27, 2009 at 05:09:27PM +0200, Jaroslav Kysela wrote:

> > > Appearently, FIFO is too big. I'm working on some changes to take account 

> > Could you expand a bit on what qualifies as "too big" here?  I've not
> > been following the thread here or the changes that caused problems.

> It's bigger than the pre-defined tolerance of jiffies check in PCM
> core code.

Hrm, OK.  That may create problems for some embedded systems which can
use very large FIFOs (well, FIFO equivalents) to allow the processor to
go to sleep when doing things like MP3 playback.  I don't think any of
those have audio support in mainline yet, though.

> The new PCM core checks the returned hw_ptr together with jiffies
> delta whether it's a sane value.  When FIFO is used with the ring
> buffer, the hardware tends to report back earlier before the expected
> timing.

But (from other messages in the thread) it's possible to disable these
checks if required?
