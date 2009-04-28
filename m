From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Driver code with mpc5200 pointer problem.
Date: Tue, 28 Apr 2009 10:55:53 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0904281022210.25064@eeebox2.perex-int.cz>
References: <9e4733910904270650g204d2660y7e3b9ea03446a752@mail.gmail.com>
	<20090427135737.GA20591@sirena.org.uk>
	<9e4733910904270702w317c8c62vbee38230979ad121@mail.gmail.com>
	<20090427140554.GB20591@sirena.org.uk>
	<9e4733910904270716v289e6d5exaf6e17331786ea11@mail.gmail.com>
	<20090427142437.GF20591@sirena.org.uk>
	<9e4733910904270742l751e660bg66844b98fe261f23@mail.gmail.com>
	<s5h4owa5f1y.wl%tiwai@suse.de>
	<9e4733910904270804k6ed079d4h16b433b6f8a06fc7@mail.gmail.com>
	<alpine.LNX.2.00.0904271707000.25064@eeebox2.perex-int.cz>
	<20090427151512.GI20591@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 097CA24415
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 10:55:54 +0200 (CEST)
In-Reply-To: <20090427151512.GI20591@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 27 Apr 2009, Mark Brown wrote:

> On Mon, Apr 27, 2009 at 05:09:27PM +0200, Jaroslav Kysela wrote:
>
>> Appearently, FIFO is too big. I'm working on some changes to take account
>> fifo_size to the jiffies based check. Please, set fifo_size correctly in
>> your driver. USB drivers with big "URB FIFOs" should be changed as well,
>> too.
>
> Could you expand a bit on what qualifies as "too big" here?  I've not
> been following the thread here or the changes that caused problems.

The problem is that period_elapsed() callback checks if data are not 
"consumed" (playback) or "produced" (capture) too quickly using jiffies 
timing (with HZ/100 margin). In case of large FIFO, the data are 
buffered, but the real playback position is different.

The question is, if driver's pointer function should estimate more real 
stream position (taking in account the FIFO) in this case or if upper 
layers of the ALSA driver and applications should handle the situation 
using FIFO size value.

I would suggest this:

- implement the stream position corrections in the pointer callback -
   in this case applications get valid realtime timing source for
   A/V synchronization etc. - in case of mpc driver, another timing
   and interrupt source should be used to compute the pointer value not
   DMA engine
- leave current fifo_size without change (there will be only small FIFO
   values to notify applications about small extra delays before samples
   reaches DAC or leaves ADC)
- add cache_size value to snd_pcm_hardware struct - here will be
   stored area of buffer which might be cached in the hardware for large
   FIFOs including prepared USB's URBs (the upper layer should not work
   with this buffer area - rewind operation etc.)

Other ideas?

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
