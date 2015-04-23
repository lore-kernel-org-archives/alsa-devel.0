From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC] File format for topology data
Date: Thu, 23 Apr 2015 09:12:14 +0530
Message-ID: <20150423034214.GL2738@intel.com>
References: <1429621606.3793.37.camel@loki> <20150422155816.GK2738@intel.com>
 <1429751473.2694.23.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F926265ADE
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 05:45:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1429751473.2694.23.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 23, 2015 at 02:11:13AM +0100, Liam Girdwood wrote:
> On Wed, 2015-04-22 at 21:28 +0530, Vinod Koul wrote:
> > On Tue, Apr 21, 2015 at 02:06:46PM +0100, Liam Girdwood wrote:
> > > I've pasted below the topology data for the broadwell firmware using the
> > > text file format being used by UCM. Using the UCM format allows to to
> > > share parser code and allows us to also have UCM define topology data.
> > > 
> 
> Jaroslav, what's your take on the file format. It's using the UCM format
> you designed with some changes.
> 
> > > I've not yet completed the byte or enum controls but the rest of the
> > > data is there for comments. I've also included the recent channel
> > > changes suggested in the UAPI header comments.
> > > 
> > > # Firmware Topology Configuration for Broadwell
> > > 
> > > # TLV scale used by both global and stream volumes
> > > SectionTLV."hsw_vol_tlv" {
> > > 
> > > 	DBScale [
> > > 		min "-9000"
> > > 		step "300"
> > > 		mute "1"
> > > 	]
> > > }
> > So for our DSP we need to pass some private data, how do we go about
> > describing it for this and other controls?
> 
> I'm thinking we should have the same method as UCM here. We could either
> specify an array of comma separated bytes or a file that contains the
> data.
Yes that would be okay. Also I realized later that above is defination of
gain, so the data should come with instance below as eahc instance will have
different data set.

Also you should add feild for assigning default values
> 
> > 
> > > 
> > > # Controls from default pipeline
> > > SectionControl."Default Pipeline" {
> > > 
> > > 	Index "1"
> > > 
> > > 	# Master DSP volume
> > > 	Mixer [
> > > 		name "Master Playback Volume"
> > > 		Channel.0 [
> > > 			map "Left"
> > > 			reg "0"
> > > 			shift "0"
> > > 		]
> > > 		Channel.1 [
> > > 			map "Right"
> > > 			reg "0"
> > > 			shift "8"
> > > 		]
> > > 		max "31"
> > > 		invert "false"
> > > 		get "0"
> > > 		put "0"
> > what do these two mean?
> 
> These are for binding to the info(), get(), put() methods, but I'm not
> 100% sure of using an ID number here. Maybe we should be using a name
> that matches the names in the UAPI header. Let me think more about that.
> 
> > 
> > > 		tlv_array "hsw_vol_tlv"
> > > 	]
> > > 
> > > 	# Offload 0 volume
> > > 	Mixer [
> > > 		name "Media0 Playback Volume"
> > > 		Channel.0 [
> > > 			map "Left"
> > > 			reg "1"
> > > 			shift "0"
> > > 		]
> > > 		Channel.1 [
> > > 			map "Right"
> > > 			reg "1"
> > > 			shift "8"
> > > 		]
> > > 		max "31"
> > > 		invert "false"
> > > 		get "1"
> > > 		put "1"
> > > 		tlv_array "hsw_vol_tlv"
> > > 	]
> > > 
> > > 	# Enum controls
> > > 	Enum [
> > > 		...
> > > 	]
> > > 
> > > 	# Byte controls
> > > 	Bytes [
> > > 		...
> > > 	]
> > > }
> > > 
> > > # DAPM Widgets for main pipeline
> > > SectionWidget."Pipeline1" {
> > > 
> > > 	Index "1"
> > > 
> > > 	AIF_IN [
> > > 		name "SSP0 CODEC IN"
> > > 		stream_name ""
> > > 		slot ""
> > > 		reg "0"
> > > 		shift "0"
> > > 		invert "false"
> > > 	]
> > > 
> > > 	AIF_OUT [
> > > 		name "SSP0 CODEC OUT"
> > > 		stream_name ""
> > > 		slot ""
> > > 		reg "0"
> > > 		shift "0"
> > > 		invert "false"
> > > 	]
> > > 
> > > 	...
> > > }
> > > 
> > > # DAPM Routes
> > > SectionGraph."Pipeline 1 Graph" {
> > > 
> > > 	Index 1
> > > 
> > > 	Routes [
> > > 		"Playback VMixer, , System Playback"
> > > 		"Playback VMixer, , Offload0 Playback"
> > > 		"Playback VMixer, , Offload1 Playback"
> > > 		"SSP0 CODEC OUT, , Playback VMixer"
> > > 		"Analog Capture, , SSP0 CODEC IN"
> > > 	]
> > > }
> > > 
> > > # PCM Configurations supported by FW
> > > SectionPCMConfig."PCM 48k Stereo 24bit" {
> > > 
> > > 	Playback [
> > > 		format "S24_LE"
> > > 		rate "48000"
> > > 		channels "2"
> > > 		tdm_slot "0xf"
> > > 	]
> > > 
> > > 	Capture [
> > > 		format "S24_LE"
> > > 		rate "48000"
> > > 		channels "2"
> > > 		tdm_slot "0xf"
> > > 
> > > 	]
> > > }
> > > 
> > > SectionPCMConfig."PCM 48k Stereo 16bit" {
> > > 
> > > 	Playback [
> > > 		format "S16_LE"
> > > 		rate "48000"
> > > 		channels "2"
> > > 		tdm_slot "0xf"
> > > 	]
> > > 
> > > 	Capture [
> > > 		format "S16_LE"
> > > 		rate "48000"
> > > 		channels "2"
> > > 		tdm_slot "0xf"
> > > 
> > > 	]
> > > }
> > > 
> > > SectionPCMConfig."PCM 48k 2P/4C 16bit" {
> > > 
> > > 	Playback [
> > > 		format "S16_LE"
> > > 		rate "48000"
> > > 		channels "2"
> > > 		tdm_slot "0xf"
> > > 	]
> > > 
> > > 	Capture [
> > > 		format "S16_LE"
> > > 		rate "48000"
> > > 		channels "4"
> > > 		tdm_slot "0xf"
> > > 
> > > 	]
> > > }
> > > 
> > > # PCM capabilities supported by FW
> > > SectionPCMCapabilities."System Playback" {
> > > 
> > > 	Capabilities [
> > > 		formats "S24_LE, S16_LE"
> > > 		rate_min "48000"
> > > 		rate_max "48000"
> > > 		channels_min "2"
> > > 		channels_max "2"
> > > 	]
> > > }
> > > 
> > > SectionPCMCapabilities."Analog Capture" {
> > > 
> > > 	Capabilities [
> > > 		formats "S24_LE, S16_LE"
> > > 		rate_min "48000"
> > > 		rate_max "48000"
> > > 		channels_min "2"
> > > 		channels_max "4"
> > > 	]
> > > }
> > > 
> > > SectionPCMCapabilities."Offload Pin Playback" {
> > > 
> > > 	Capabilities [
> > > 		formats "S24_LE, S16_LE"
> > > 		rate_min "8000"
> > > 		rate_max "192000"
> > > 		channels_min "2"
> > > 		channels_max "2"
> > > 	]
> > > }
> > > 
> > > SectionPCMCapabilities."Loopback Capture" {
> > > 
> > > 	Capabilities [
> > > 		formats "S16_LE"
> > > 		rate_min "48000"
> > > 		rate_max "48000"
> > > 		channels_min "2"
> > > 		channels_max "2"
> > > 	]
> > > }
> > > 
> > > # PCM devices exported by Firmware
> > > SectionPCM."System Pin" {
> > > 
> > > 	Index 1
> > > 
> > > 	Playback [
> > > 		Capabilities "System Playback"
> > > 		Config "PCM 48k Stereo 24bit"
> > > 		Config "PCM 48k Stereo 16bit"
> > > 	]
> > > 
> > > 	Capture [
> > > 		Capabilities "Analog Capture"
> > > 		Config "PCM 48k Stereo 24bit"
> > > 		Config "PCM 48k Stereo 16bit"
> > > 		Config "PCM 48k 2P/4C 16bit"
> > > 	]
> > > }
> > Is this a FE or a BE? How about Dailinks?
> > 
> 
> This is PCM FE. I'll give some examples for the codec <-> codec links
> and BE DAI link shortly with updates to the other questions.
Okay, that will help

-- 
~Vinod

> 
> Liam
> 
> > -- 
> > ~Vinod
> > 
> > > 
> > > SectionPCM."Offload Pin 0" {
> > > 
> > > 	Index 1
> > > 
> > > 	Playback [
> > > 		Capabilities "Offload Pin Playback"
> > > 		Config "PCM 48k Stereo 24bit"
> > > 		Config "PCM 48k Stereo 16bit"
> > > 	]
> > > }
> > > 
> > > SectionPCM."Offload Pin 1" {
> > > 
> > > 	Index 1
> > > 
> > > 	Playback [
> > > 		Capabilities "Offload Pin Playback"
> > > 		Config "PCM 48k Stereo 24bit"
> > > 		Config "PCM 48k Stereo 16bit"
> > > 	]
> > > }
> > > 
> > > SectionPCM."Loopback Pin" {
> > > 
> > > 	Index 1
> > > 
> > > 	Capture [
> > > 		Capabilities "Loopback Capture"
> > > 		Config "PCM 48k Stereo 16bit"
> > > 	]
> > > }
> > > 
> > 
> 
> 

-- 
