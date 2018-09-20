From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v2 07/12] ASoC: SOF: Add DSP firmware trace
 event support
Date: Thu, 20 Sep 2018 17:02:42 +0100
Message-ID: <20f3315373b30624dd9ab83f3c909cbc9afe0b0c.camel@linux.intel.com>
References: <20180831151910.16122-1-liam.r.girdwood@linux.intel.com>
 <20180831151910.16122-8-liam.r.girdwood@linux.intel.com>
 <20180903162503.GS10302@sirena.org.uk>
 <579fc5f7d26a8cba21fe36eb4ff6bb4a1a0d8496.camel@linux.intel.com>
 <20180904150333.GF12993@sirena.org.uk>
 <fe9e199c8e9c3f688cc84393b85e1a390ace3c7b.camel@linux.intel.com>
 <20180904154639.GG12993@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id F204726787F
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2018 18:02:47 +0200 (CEST)
In-Reply-To: <20180904154639.GG12993@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2018-09-04 at 16:46 +0100, Mark Brown wrote:
> On Tue, Sep 04, 2018 at 04:28:49PM +0100, Liam Girdwood wrote:
> > On Tue, 2018-09-04 at 16:03 +0100, Mark Brown wrote:
> > > I was thinking the code could read it like it's doing now and then just
> > > have a trace event to dump it into the core trace infrastructure as it
> > > reads things in.
> > Most of the data is binary atm, so we were decoding in userspace. Any
> > objection
> > to decoding in the kernel as different trace events ?
> 
> I wouldn't think so.
> 

I was initially thinking about a partial decode. The FW has many subsystems for
trace that can be individually switched on/off via IPC. e.g. driver would read
the trace packet class and then call the appropriate trace event for that class
(note that class is not decoded any further). But I'm not so sure now as these
classes can change at runtime based on topologies. 

> The way the trace stuff works is that the writer dumps blocks of data
> into the trace buffer in raw binary form in a structured block tagged
> with the event type and then later on when something reads out the
> buffer they can be formatted as desired, including things like hex dumps
> (IIRC there's facilities to just get the raw buffer entries too, I've
> only ever used the human readable interface myself, writing software is
> hard). 

Yeah, I'm just reading up on this now, human readable is easy.

>  This gives very fast writes which is really nice for anything
> performance sensitive and means you can leave trace on a lot more than
> you would otherwise.  I'd guess if you were decoding it'd just be
> splitting the buffer up into per message chunks.

So I think now we will trace the driver side (easy) and then trace event
firmware trace packets as ASCII text (which userspace would decode).

I will delay upstreaming the trace part so v4 will be sent minus trace.

I will probably have some debugFS interface that would export dynamic firmware
trace tuning controls.

Liam

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
