From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Driver code with mpc5200 pointer problem.
Date: Tue, 28 Apr 2009 10:26:00 +0100
Message-ID: <20090428092600.GF14626@sirena.org.uk>
References: <9e4733910904270702w317c8c62vbee38230979ad121@mail.gmail.com>
	<20090427140554.GB20591@sirena.org.uk>
	<9e4733910904270716v289e6d5exaf6e17331786ea11@mail.gmail.com>
	<20090427142437.GF20591@sirena.org.uk>
	<9e4733910904270742l751e660bg66844b98fe261f23@mail.gmail.com>
	<s5h4owa5f1y.wl%tiwai@suse.de>
	<9e4733910904270804k6ed079d4h16b433b6f8a06fc7@mail.gmail.com>
	<alpine.LNX.2.00.0904271707000.25064@eeebox2.perex-int.cz>
	<20090427151512.GI20591@sirena.org.uk>
	<alpine.LNX.2.00.0904281022210.25064@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D20210384A
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 11:26:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0904281022210.25064@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 28, 2009 at 10:55:53AM +0200, Jaroslav Kysela wrote:
> On Mon, 27 Apr 2009, Mark Brown wrote:

>> Could you expand a bit on what qualifies as "too big" here?  I've not
>> been following the thread here or the changes that caused problems.

> The problem is that period_elapsed() callback checks if data are not  
> "consumed" (playback) or "produced" (capture) too quickly using jiffies  
> timing (with HZ/100 margin). In case of large FIFO, the data are  
> buffered, but the real playback position is different.

Right.  As I said in my excellently timed reply to Takashi just now this
is liable to cause problems for some embedded applications.  There are
some which can use a large (tens to hundreds of kilobytes) FIFO to allow
audio playback to proceed with the processor and RAM suspended, reducing
power consumption during things like MP3 playback which aren't latency
sensitive.  In latency sensitive cases the application needs to submit
less data - there's no requirement to fill.

> The question is, if driver's pointer function should estimate more real  
> stream position (taking in account the FIFO) in this case or if upper  
> layers of the ALSA driver and applications should handle the situation  
> using FIFO size value.

Or both, I guess.

> I would suggest this:

> - implement the stream position corrections in the pointer callback -
>   in this case applications get valid realtime timing source for
>   A/V synchronization etc. - in case of mpc driver, another timing
>   and interrupt source should be used to compute the pointer value not
>   DMA engine

This feels like it's being done at the wrong level - if estimation code
is needed it should probably be pushed up the stack, done based on
information provided by the driver about how accurate the information
it's providing is.
