From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Confusing about Playback/Capture, CODEC/CODEC links,
	and	snd_soc_dapm_link_dai_widgets()
Date: Fri, 1 Jun 2012 00:37:09 +0100
Message-ID: <20120531233702.GA30717@opensource.wolfsonmicro.com>
References: <4FC7F576.30101@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 03472103FD2
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jun 2012 01:37:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4FC7F576.30101@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 31, 2012 at 04:49:26PM -0600, Stephen Warren wrote:

> I have an issue with the paths that snd_soc_dapm_link_dai_widgets() sets
> up inside both the AHUB XBAR and the I2S. I'll use the I2S to explain
> since it's internally much simpler.

You shouldn't be using this at all for new code, you should be using
explicit DAPM routes to link to the widgets and specifying NULL
stream_name.

> 2) Is it more that Playback==RX_into_codec, Capture==TX_from_codec? This
> appears to be supported by the fact that the paths get set up correctly
> with the second set of AIF definitions above.

Yes.

> But if (2) is correct, I wonder why soc_dapm_stream_event()'s first if
> statement appears to consider the playback_widget of both sides of the
> DAI to be coupled; wouldn't one side's playback widget be coupled to the
> other side's capture widget?

The DAIs on CPUs have the opposite sense to DAIs on CODECs.  In a
traditional CPU<->CODEC link we do connect the two playback widgets
directly to each other.  The current code isn't correct, it's not
normally noticable since most of the time the CPU DAI end of the link is
a baseband which doesn't do anything real and is always activated
bidirectionally so it really makes no odds which widget we look at.

I'll fix this tomorrow.

> As an aside, I'm not sure if it's conceptually correct to talk about
> playback or capture any more (beyond the initial CPU DAI) with arbitrary
> CODEC/CODEC links, since who knows what kind of routing/CPU->CPU
> loopbacks/external CODEC->CODEC loopbacks/... might exist in the CODECs?

We could rename everything to RX and TX but it's a pain and going to be
annoying for backporting.

> Either way though, something is still not working correctly even when
> the expected paths show up in debugfs. When I start playback on a PCM
> exposed by the DMA FIFO driver, I see the relevant AHUB XBAR's stream
> turned on, and a route exists to the relevant AIF_IN widget, but that

Works for me.

> > # cat APBIF0\ Playback 
> > APBIF0 Playback: On  in 1 out 1
> >  stream APBIF0 Playback active
> >  out "static" "APBIF0 RX"
> >  out "static" "APBIF0 RX"
> > # cat APBIF0\ RX
> > APBIF0 RX: Off  in 2 out 0       <<<<< last value shouldn't be 0?
> >  stream APBIF0 Playback inactive <<<<< still inactive?
> >  in  "static" "APBIF0 Playback"
> >  in  "static" "APBIF0 Playback"
> >  out "APBIF0 RX" "I2S0 TX Mux"

So what's the rest of the route look like - what's I2S0 TX Mux look like
and so on?  For real widgets the number of outputs is a function of the
rest of the graph so you need to trace through that, clearly you want to
have some outputs but unless they are connected all the way back to an
input DAPM will leave everything powered off.  This is just like any
other DAPM widget in this regard, everything behaves just like an
analogue link.

> Probably related, the I2S and WM8903 (DAI) drivers aren't being called
> by the ASoC core to initialize themselves for playback either; pretty
> much all that happens is that DMA is started. Is the machine driver
> responsible for this?

No, of course not.  This is what soc_dapm_stream_event() is all about.
It looks like all that's happening is that since DAPM hasn't found a
complete route it didn't power anything (including the inter device
links) on.

> At this point, I'm not sure whether I have a gross mis-understanding of
> how this is supposed to work, or whether there are simply bits missing
> from the DAPM code to fully support CODEC/CODEC links, rather than
> CPU/CODEC links.

It's really hard to comment in much more detail, you've not shown enough
information.  What are the DAI links connecting the devices?  Is the
rest of the DAPM path through the system connected?  My best guess is
that (possibly due to the linking of the playback widgets) you don't
have a full DAPM path.

This is all working just fine in mainline on littlemill.

> > int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
> > 	struct snd_soc_dapm_widget_list **list)
> ...
> > 	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
> > 		paths = is_connected_output_ep(dai->playback_widget, list);
> > 	else
> > 		paths = is_connected_input_ep(dai->playback_widget, list);

> I would have expected this to use capture_widget on the final line, but
> I haven't thought about this in detail, just noticed the lack of
> symmetry by very brief inspection.

Yes, that looks buggy.  Don't think there's any mainline users so nobody
would notice.
