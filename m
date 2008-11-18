From: Wu Fengguang <wfg@linux.intel.com>
Subject: Re: [PATCH 3/4] hda: HDMI channel allocations for
	audio infoframe
Date: Tue, 18 Nov 2008 19:30:07 +0800
Message-ID: <20081118113007.GA25180@localhost>
References: <20081118085713.252457834@linux.intel.com>
	<20081118085809.151205160@linux.intel.com>
	<s5hmyfxfgjf.wl%tiwai@suse.de> <20081118110817.GA24476@localhost>
	<s5hfxlpffuk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga102.ch.intel.com (mga12.intel.com [143.182.124.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 49C772450C
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 12:30:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hfxlpffuk.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 18, 2008 at 12:12:03PM +0100, Takashi Iwai wrote:
> At Tue, 18 Nov 2008 19:08:18 +0800,
> Wu Fengguang wrote:
> > 
> > On Tue, Nov 18, 2008 at 11:57:08AM +0100, Takashi Iwai wrote:
> > > At Tue, 18 Nov 2008 16:57:16 +0800,
> > > Wu Fengguang wrote:
> > > > 
> > > > To play a 3+ channels LPCM/DSD stream via HDMI,
> > > > 
> > > > 	- HDMI sink must tell HDMI source about its speaker placements
> > > > 	  (via ELD, speaker-allocation field)
> > > > 	- HDMI source must tell the HDMI sink about channel allocation
> > > > 	  (via audio infoframe, channel-allocation field)
> > > > 
> > > > (related docs: HDMI 1.3a spec section 7.4, CEA-861-D section 7.5.3 and 6.6)
> > > > 
> > > > This patch attempts to set the CA(channel-allocation) byte in the audio infoframe
> > > > according to
> > > > 	- the number of channels in the current stream
> > > > 	- the speakers attached to the HDMI sink
> > > > 
> > > > A channel_allocations[] line must meet the following two criterions to be
> > > > considered as a valid candidate for CA:
> > > > 	1) its number of allocated channels = substream->runtime->channels
> > > > 	2) its speakers are a subset of the available ones on the sink side
> > > > 
> > > > If there are multiple candidates, the first one is selected.  This simple
> > > > policy shall cheat the sink into playing music, but may direct data to the
> > > > wrong speakers.
> > > > 
> > > > Sorry, this last step is not obvious to me. Any domain experts, please?
> > > 
> > > The problem is that the speaker positioning isn't defined in the ALSA
> > > API yet.  I think your implementation will work in practice.
> > 
> > OK. Let's forget it until (possibly) some one complains ;-)
> > 
> > > > +static struct cea_channel_speaker_allocation channel_allocations[] = {
> > > > +/* channel number:  8      7     6     5     4      3     2     1 */
> > > 
> > > Do we need to set ca_index explicitly?
> > > Any case ca_index != array index?
> > 
> > Yes, since we stop at the first matching item, the lines could be
> > reordered somewhere to give priority to some popular ones.
> 
> Fair enough.  One thing I forgot is the initialization style.
> Try to initialize in C99 style, something like
> 
> static struct cea_channel_speaker_allocation channel_allocations[] = {
> 	{ .ca_index = 0x00,
> 	  .speakers = { ..... } },   
> 	{ .ca_index = 0x01,
> 	  .speakers = { ..... } },   
> 	...
> };
> 
> You can indent as you like, though.

OK, they still fits nicely into one line :-)

        { .ca_index = 0x10, .speakers = { RRC, RLC, RR, RL,  0,   0, FR, FL } },
        { .ca_index = 0x11, .speakers = { RRC, RLC, RR, RL,  0, LFE, FR, FL } },
        { .ca_index = 0x12, .speakers = { RRC, RLC, RR, RL, FC,   0, FR, FL } },
        { .ca_index = 0x13, .speakers = { RRC, RLC, RR, RL, FC, LFE, FR, FL } },
        { .ca_index = 0x14, .speakers = { FRC, FLC,  0,  0,  0,   0, FR, FL } },
        { .ca_index = 0x15, .speakers = { FRC, FLC,  0,  0,  0, LFE, FR, FL } },
        { .ca_index = 0x16, .speakers = { FRC, FLC,  0,  0, FC,   0, FR, FL } },
        { .ca_index = 0x17, .speakers = { FRC, FLC,  0,  0, FC, LFE, FR, FL } },
        { .ca_index = 0x18, .speakers = { FRC, FLC,  0, RC,  0,   0, FR, FL } },
        { .ca_index = 0x19, .speakers = { FRC, FLC,  0, RC,  0, LFE, FR, FL } },
        { .ca_index = 0x1a, .speakers = { FRC, FLC,  0, RC, FC,   0, FR, FL } },
        { .ca_index = 0x1b, .speakers = { FRC, FLC,  0, RC, FC, LFE, FR, FL } },

But it's a bit too crowded, and I feel better with this one:

{ .ca_index = 0x14,  .speakers = { FRC,  FLC,   0,   0,   0,    0,  FR,  FL } },
{ .ca_index = 0x15,  .speakers = { FRC,  FLC,   0,   0,   0,  LFE,  FR,  FL } },
{ .ca_index = 0x16,  .speakers = { FRC,  FLC,   0,   0,  FC,    0,  FR,  FL } },
{ .ca_index = 0x17,  .speakers = { FRC,  FLC,   0,   0,  FC,  LFE,  FR,  FL } },
{ .ca_index = 0x18,  .speakers = { FRC,  FLC,   0,  RC,   0,    0,  FR,  FL } },
{ .ca_index = 0x19,  .speakers = { FRC,  FLC,   0,  RC,   0,  LFE,  FR,  FL } },
{ .ca_index = 0x1a,  .speakers = { FRC,  FLC,   0,  RC,  FC,    0,  FR,  FL } },
{ .ca_index = 0x1b,  .speakers = { FRC,  FLC,   0,  RC,  FC,  LFE,  FR,  FL } },
{ .ca_index = 0x1c,  .speakers = { FRC,  FLC,  RR,  RL,   0,    0,  FR,  FL } },
{ .ca_index = 0x1d,  .speakers = { FRC,  FLC,  RR,  RL,   0,  LFE,  FR,  FL } },
