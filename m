From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA and MediaController
Date: Tue, 17 May 2011 13:57:21 -0700
Message-ID: <20110517205721.GB2622@opensource.wolfsonmicro.com>
References: <BANLkTikWAZAh-1Bm=8n0=2-fJjnA6R4mrw@mail.gmail.com>
	<s5hhb8t2mn4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DEA821037EC
	for <alsa-devel@alsa-project.org>;
	Tue, 17 May 2011 22:57:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hhb8t2mn4.wl%tiwai@suse.de>
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
Cc: pl bossart <bossart.nospam@gmail.com>, alsa-devel@alsa-project.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 17, 2011 at 08:43:43PM +0200, Takashi Iwai wrote:

> The current flat array implementation is a result after hard time
> with attempts of implementing the graph in mixer API at the time
> of ALSA 0.5.x.  This ended up with a total mess of the code.

> Maybe now we'd implement it differently, but I believe that the
> flat array itself is the best as the primary data form.
> We can provide some extended attributes to each control if needed.

Yeah, the discussion was to initially keep the array of controls and
associate that with a separate graph so that we have a way for userspace
to figure out how all the controls are plumbed together and what they
actually mean.  One of the main drivers for interest in the media
controller API was that it's already doing the graph drawing to
userspace bit.

> > - Laurent suggested a new ioctl to export media_entity information to
> > userspace, as a binary buffer containing a list of TLV
> > (Type-Length-Value) field. However it looks like there's already an
> > ELEM_BYTES control type. It might make more sense to expose this
> > information using native ALSA controls, but again feedback from smart
> > people on this list would be welcome.

> You may use a TLV information provided for each control element, too.
> So far, this provides only the dB information.  But it doesn't have to
> be restricted to that.

We also need to be able to add non-control nodes to what's visible to
the user, showing fixed function connections.
