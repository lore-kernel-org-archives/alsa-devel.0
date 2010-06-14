From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Tue, 15 Jun 2010 07:43:48 +0800
Message-ID: <AANLkTim2xGO3nS8DQAsVDFUZBcr4HVebEaGCuAFJJWNJ@mail.gmail.com>
References: <huicj9$t30$1@dough.gmane.org>
	<AANLkTimts4qRRneVmfY1Qw55OJ4ZwMqpVjp-wM3PTd2s@mail.gmail.com>
	<hulnlp$m00$1@dough.gmane.org>
	<AANLkTikqAJFo7kIjeJ2O1ulg9GUPZniF1NQNu6PAv0cH@mail.gmail.com>
	<hur2pt$uaa$1@dough.gmane.org>
	<20100613135349.GB5818@tango.0pointer.de>
	<AANLkTimwvTxPe66fk4hq2-eiky-8Yqd12vN6WYkh9qdQ@mail.gmail.com>
	<hv4pfi$gqr$3@dough.gmane.org>
	<AANLkTilTZ-QMAZPTx78J8-DPIozFO2G6s5VtX9f83-3X@mail.gmail.com>
	<hv4vs6$a6q$1@dough.gmane.org>
	<20100614184922.GE14916@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 00B56243F6
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jun 2010 01:43:49 +0200 (CEST)
Received: by vws8 with SMTP id 8so1373720vws.38
	for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2010 16:43:48 -0700 (PDT)
In-Reply-To: <20100614184922.GE14916@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/6/15 Lennart Poettering <mznyfn@0pointer.de>

> On Mon, 14.06.10 11:22, Colin Guthrie (gmane@colin.guthr.ie) wrote:
>
> >
> > 'Twas brillig, and James Courtier-Dutton at 14/06/10 09:56 did gyre and
> > gimble:
> > > On 14 June 2010 09:33, Colin Guthrie <gmane@colin.guthr.ie> wrote:
> > >> 'Twas brillig, and Raymond Yau at 14/06/10 01:25 did gyre and gimble:
> > >>> if your sound card have ac97 codec ., you can use audacity to record
> the
> > >>> output from hw:0,0 and you will see clipping occur when you set "PCM"
> volume
> > >>> above 0dB
> > >>
> > >> So the standard response is "don't do that then" :)
> > >>
> > >> That's why the base volume is shown to the user via GUIs so that they
> > >> can gauge the best point on the slider to use. Currently there is no
> > >> indication with alsa sliders at which point the 0dB "sweet spot" lies.
> > >>
> > >
> > > What do you mean.
> > > If you use "alsamixer", dB values are shown so it is easy to find the
> > > 0dB "sweet spot".
> > > I think it is pulse audio that hides this information when it combines
> > > two alsa mixer controls into one pulseaudio control.
> >
> > But it doesn't hide it. It's shown very clearly in the volume control
> > GUIs as the Base Volume.
>
> Let me also stress that "dB" is not at all understandable to most
> people. It is a very technical unit, and showing 0dB in the UI just like
> that won't be very helpful for most people.
>
> That's why we thought about this, and are recommending a color coded
> slider to be exposed in the UI which encodes the range information in a
> sane way that is intuitively understandable by users. In green, in
> yellow and in red. (meaning hw attenuated, hw amplified, sw amplified
> ranges)
>
> http://pulseaudio.org/wiki/WritingVolumeControlUIs#Colouredvolumesliders
>
> Lennart
>
>
Clipping may occur at recording if there is gain above hardware 0dB point  ,
the region should be coloured as red ,

What is the meaning of  the yellow region ?

For HDA base volume seem to be at the same point as the norm volume since
max_db of playback is 0dB

+12dB(400%) is even larger than the software gain 150% of PA
