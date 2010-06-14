From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: wrong decibel data?
Date: Mon, 14 Jun 2010 20:49:22 +0200
Message-ID: <20100614184922.GE14916@tango.0pointer.de>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D7F024753
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jun 2010 20:49:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <hv4vs6$a6q$1@dough.gmane.org>
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

On Mon, 14.06.10 11:22, Colin Guthrie (gmane@colin.guthr.ie) wrote:

> 
> 'Twas brillig, and James Courtier-Dutton at 14/06/10 09:56 did gyre and
> gimble:
> > On 14 June 2010 09:33, Colin Guthrie <gmane@colin.guthr.ie> wrote:
> >> 'Twas brillig, and Raymond Yau at 14/06/10 01:25 did gyre and gimble:
> >>> if your sound card have ac97 codec ., you can use audacity to record the
> >>> output from hw:0,0 and you will see clipping occur when you set "PCM" volume
> >>> above 0dB
> >>
> >> So the standard response is "don't do that then" :)
> >>
> >> That's why the base volume is shown to the user via GUIs so that they
> >> can gauge the best point on the slider to use. Currently there is no
> >> indication with alsa sliders at which point the 0dB "sweet spot" lies.
> >>
> > 
> > What do you mean.
> > If you use "alsamixer", dB values are shown so it is easy to find the
> > 0dB "sweet spot".
> > I think it is pulse audio that hides this information when it combines
> > two alsa mixer controls into one pulseaudio control.
> 
> But it doesn't hide it. It's shown very clearly in the volume control
> GUIs as the Base Volume.

Let me also stress that "dB" is not at all understandable to most
people. It is a very technical unit, and showing 0dB in the UI just like
that won't be very helpful for most people.

That's why we thought about this, and are recommending a color coded
slider to be exposed in the UI which encodes the range information in a
sane way that is intuitively understandable by users. In green, in
yellow and in red. (meaning hw attenuated, hw amplified, sw amplified
ranges)

http://pulseaudio.org/wiki/WritingVolumeControlUIs#Colouredvolumesliders

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
