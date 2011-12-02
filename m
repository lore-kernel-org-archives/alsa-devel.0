From: Liam Girdwood <lrg@ti.com>
Subject: Re: ASoC: Dynamic CODEC DAI
Date: Fri, 02 Dec 2011 10:11:25 +0000
Message-ID: <1322820685.7185.12.camel@odin>
References: <4ED42C0E.2080300@codeaurora.org>
	<20111129134913.GB26800@opensource.wolfsonmicro.com>
	<4ED83E52.6080004@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id DAFAB246BD
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 11:11:43 +0100 (CET)
Received: by lagv3 with SMTP id v3so1654111lag.35
	for <alsa-devel@alsa-project.org>; Fri, 02 Dec 2011 02:11:28 -0800 (PST)
In-Reply-To: <4ED83E52.6080004@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-12-01 at 18:56 -0800, Patrick Lai wrote:
> On 11/29/2011 5:49 AM, Mark Brown wrote:
> > On Mon, Nov 28, 2011 at 04:49:18PM -0800, Patrick Lai wrote:
> >
> >> In CODEC driver, I will declare codec dai for each port.
> >> Then, I will enhance ASoC framework to take a list of CODEC DAIs and
> >> pass list of CODEC DAIs back to callback function such as startup,
> >> hw_param, prepare, trigger. I believe this approach will not require
> >> massive amount of change to framework.
> >
> > The above is really vauge so it's hard to comment in any detail.
> The thing is that in order for DAPM to figure out which path to enable,
> AIF_IN and AIF_OUT widgets must be associated with stream name(e.g HiFi
>   Playback) as part of CODEC DAI definition. Now, with the grouping
> requirement, CODEC DAI definition with fixed number of channels will
> not work as interconnect table defined in the CODEC driver establishes
> relationship of AIF pins and codec dai stream name which now would have
> to be machine base. Another approach would be having machine driver
> define AIF pins, interconnect table and CODEC DAIs for CODEC driver. I
> would think this approach would bear too much burden on the machine
> driver developer. Instead, each slimbus port on the CODEC, by
> definition, is a mono CODEC DAI. Extending DAI link definition to take
> a list of CODEC dais allows machine driver to group the ports. Passing
> back the CODEC DAI list to CODEC driver allows CODEC driver know which 
> slimbus ports are associated with given pcm stream. As on the CPU side,
> instead of burdening CPU driver from knowing what ports and enumeration
> address of CODEC, we have concept of shared data channel IDs. So, both
> CODEC driver and CPU driver communicate to SLIMBUS driver to set up
> data channels using the channel ID. CPU and CODEC independently can
> setup their own SLIMBUS ports. Machine driver assigns channel ID to
> both CPU and CODEC drivers.

Fwiw, I'm looking at a similar channel mapping problem here for dyanmic
PCM and have the start of some working code. Basically I want to be able
to specify which channels from each PCM device are routed through each
DAI and DAPM widget.

This may be useful for Slimbus, so I've posted the abstract below :-

Features
========

1. Provide a method to identify unique channels streaming through a PCM,
DAI and DAPM widgets within a sound card.

2. Directly associate a PCM channel with a DAPM widget.

3. Simplicity wrt component drivers.

4. Provide multi-channel widgets for some users with easy to use
accesors to identify the the active channels (i.e. if the widget has
multiple power bits then we need to easily map channel to pm bit).


Assumptions
===========  

5. 64 Channels per ASoC sound card will be enough for everyone - 64 play
+ 64 capt also easy todo.


Initialisation
==============

6. There is a direct mapping between a PCM and AIF/DAC/ADC widgets.

7. Each widget has u64 channel mask. This mask is populated at runtime
by component PCM registration. Each channel is assigned a unique mask
that is set in each AIF/DAC/ADC widget. Channel mask bit is related to
PCM registration order and max supported playback and capture channels.

8. The AIF/DAC/ADC widget channels masks are then populated to their
reachable widgets so that each widget has a mask of all unique channels
it supports.


Runtime
=======

9. Widgets also have a u64 active status that is set for each channel on
stream events.

10. Widgets have accessors for active channel info.

11. PCMs have active supported and active channel masks too that are
propagated to their connected widgets at runtime. Based on hw_params
active channels etc.

12. Active channel mask can also be changed at runtime via kcontrols.
This should also be propagated to reachable widgets.

Regards

Liam
