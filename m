From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Misusing snd_pcm_avail_update()
Date: Tue, 20 Jan 2009 21:29:34 +0100
Message-ID: <20090120202933.GA17626@tango.0pointer.de>
References: <20090120025727.GA30499@tango.0pointer.de>
	<49758B71.8090605@ladisch.de>
	<20090120142614.GA27494@tango.0pointer.de>
	<49761C79.8060605@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FD5610384A
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 21:29:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49761C79.8060605@ladisch.de>
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

On Tue, 20.01.09 19:48, Clemens Ladisch (clemens@ladisch.de) wrote:

> > I currently deal with this by always halving the first wakeup time --
> > which works most of the time but is a hack.
> 
> In theory, you could deduce this behaviour from
> snd_pcm_hw_params_is_double(), but the USB driver forgets to set this
> flag.

But still, with this flag I would only now that the startup sequence
is "fast". But not how "fast".

I appears to me that it would make a lot more sense if the driver
would simply tell me how long I may sleep instead of adding multiple
new functions 1) that tell me if double-buffering is used and what the
size of the second buffer is, 2) that tell me that data is pulled
block-by-block from the buffer and what the block size is, and so on. 

The function should look like this:

    snd_pcm_sframes_t snd_pcm_busy_for(snd_pcm_t *pcm);

I called the prototype "busy for" since effectively the value I am
looking for is the time the card will be busy with the data it already
has, and doesn't need any new data.

Can I convince you guys that a function like this would make a lot of
sense?

Instead of exporting all the gory details about blocks/double
buffering and so on, just a simple high-level call. 

> > With the function I suggest I'd be able to explicitly query how much
> > time I have before I need to wake up.
> 
> I was thinking about a function that returns the hardware's block size
> (i.e., the precision of the avail/delay values), but that wouldn't be
> able to describe this behaviour of the USB driver.  I think I might just
> remove this feature.

I am pretty sure there might be other drivers that work like this as
well. Hence I think simply removing double buffering in the USB driver
doesn't really solve the general issues I have.

> > > Well, you could make the "some extra margin" above larger than one
> > > period.
> >
> > To save power I want to disable interrupts from the sound cards as
> > much as possible.
> 
> In some cases (unusal hardware, but also USB), the period size affects
> the block size, i.e., smaller periods give better timing precision.

It would be good if this could be controlled independantly from
each other. 

> For this case, it might be useful to make the "pointer precision" a
> hardware parameter that can be restricted by an interval, like the other
> parameters.

That would be good.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
