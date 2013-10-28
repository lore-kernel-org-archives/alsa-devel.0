From: Andre Heider <a.heider@gmail.com>
Subject: Re: [PATCH v3 0/5] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Mon, 28 Oct 2013 23:00:46 +0100
Message-ID: <20131028220045.GA71497@localhost>
References: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>
 <s5hli1imfsi.wl%tiwai@suse.de>
 <20131025165452.GA89428@deflower.internal>
 <526AA924.5070508@iki.fi> <20131028175206.GA70365@localhost>
 <526EA91B.3090607@iki.fi> <20131028181743.GA70502@localhost>
 <526EAC12.5000905@iki.fi> <20131028183554.GB70502@localhost>
 <526ECAAC.306@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f180.google.com (mail-ea0-f180.google.com
 [209.85.215.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C97A260320
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 23:00:52 +0100 (CET)
Received: by mail-ea0-f180.google.com with SMTP id l9so2034801eaj.11
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 15:00:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <526ECAAC.306@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Peter =?iso-8859-1?Q?Fr=FChberger?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 28, 2013 at 10:35:56PM +0200, Anssi Hannula wrote:
> 28.10.2013 20:35, Andre Heider kirjoitti:
> > On Mon, Oct 28, 2013 at 08:25:22PM +0200, Anssi Hannula wrote:
> >> 28.10.2013 20:17, Andre Heider kirjoitti:
> >>> On Mon, Oct 28, 2013 at 08:12:43PM +0200, Anssi Hannula wrote:
> >>>> 28.10.2013 19:52, Andre Heider kirjoitti:
> >>>>> On Fri, Oct 25, 2013 at 08:23:48PM +0300, Anssi Hannula wrote:
> >>>>>> 25.10.2013 19:54, Andre Heider kirjoitti:
> >>>>>>> cat /proc/asound/card0/eld\#0.0
> >>>>>>> 	monitor_present		1
> >>>>>>> 	eld_valid		0
> >>>>>>
> >>>>>> However, this should have eld_valid=1 and contain more info. To get a
> >>>>>> hint on whether it is a bug in audio or video driver, could you give a
> >>>>>> log with CONFIG_SND_DEBUG ?
> >>>>>>
> >>>>>> AFAICS the sound git master tree should have the necessary support in
> >>>>>> the radeon video driver to allow the audio driver to generate a valid
> >>>>>> ELD with your card.
> >>>>>
> >>>>> With CONFIG_SND_DEBUG=y I get a bunch of
> >>>>> "HDMI ATI/AMD: no speaker allocation for ELD"
> >>>>> but afaics that's about it.
> >>>>
> >>>> Thanks, that is exactly what I was looking for.
> >>>>
> >>>> Looks like a radeon driver issue - it does not seem to setup the speaker
> >>>> allocation registers properly (so that ALSA could read them from there),
> >>>> and I verified that the EDID you posted has a valid speaker allocation
> >>>> byte 0x4f.
> >>>>
> >>>> Just to recheck - you are running sound git master, or something else?
> >>>
> >>> This is from 3.12-rc7 with today's sound/master (3fbdaf9b) merged on top.
> >>>
> >>
> >> Ah, OK, that certainly explains it. 3.12-x has this one:
> >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/gpu/drm/radeon?id=555b1b651acf44bf27ebbb04235d38a8fd2d58dc
> >>
> >> Could you revert that for testing, just to see if you get proper ELD
> >> info then?
> > 
> > Blergh, guess that's my fault for not just using sound/master.
> > 
> > But that looks better:
> > 
> > cat /proc/asound/card0/eld\#0.0
> > 	monitor_present		1
> > 	eld_valid		1
> > 	monitor_name		
> > 	connection_type		HDMI
> > 	eld_version		[0x2] CEA-861D or below
> > 	edid_version		[0x0] no CEA EDID Timing Extension block present
> > 	manufacture_id		0x0
> > 	product_id		0x0
> > 	port_id			0x0
> > 	support_hdcp		0
> > 	support_ai		0
> > 	audio_sync_delay	0
> > 	speakers		[0x4f] FL/FR LFE FC RL/RR RLC/RRC
> > 	sad_count		4
> > 	sad0_coding_type	[0x1] LPCM
> > 	sad0_channels		2
> > 	sad0_rates		[0x1ee0] 32000 44100 48000 88200 96000 176400 192000
> > 	sad0_bits		[0xe0000] 16 20 24
> 
> Thanks.
> 
> Hmm, seems we have bug in the radeon driver, we are missing the
> 8-channel PCM SAD here.
> 
> Can you try the attached patch?

Sure, with that patch I get:

	monitor_present		1
	eld_valid		1
	monitor_name		
	connection_type		HDMI
	eld_version		[0x2] CEA-861D or below
	edid_version		[0x0] no CEA EDID Timing Extension block present
	manufacture_id		0x0
	product_id		0x0
	port_id			0x0
	support_hdcp		0
	support_ai		0
	audio_sync_delay	0
	speakers		[0x4f] FL/FR LFE FC RL/RR RLC/RRC
	sad_count		5
	sad0_coding_type	[0x1] LPCM
	sad0_channels		8
	sad0_rates		[0x6e0] 32000 44100 48000 88200 96000
	sad0_bits		[0xe0000] 16 20 24
	sad1_coding_type	[0x1] LPCM
	sad1_channels		2
	sad1_rates		[0x1ee0] 32000 44100 48000 88200 96000 176400 192000
	sad1_bits		[0xe0000] 16 20 24
	sad2_coding_type	[0x2] AC-3
	sad2_channels		8
	sad2_rates		[0xe0] 32000 44100 48000
	sad2_max_bitrate	640000
	sad3_coding_type	[0x6] AAC-LC
	sad3_channels		8
	sad3_rates		[0xe0] 32000 44100 48000
	sad3_max_bitrate	640000
	sad4_coding_type	[0x7] DTS
	sad4_channels		8
	sad4_rates		[0xe0] 32000 44100 48000
	sad4_max_bitrate	1536000

Those are supposed to be hardware capabilities, right? Because I'm
pretty sure this dated receiver doesn't support AAC bitstreams.

Thanks,
Andre
