From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: Bug in setting channels,
 related to recent ELD/EDID changes?
Date: Sun, 02 Jan 2011 12:16:44 +0200
Message-ID: <4D20508C.7070609@iki.fi>
References: <AANLkTikneYHc9NmrRW41=xRBW_PVgc0jqdcOaTgHcC-t@mail.gmail.com>	<4D12E292.9050204@iki.fi>
	<AANLkTimxHsUS_zVm0_m-vUcwt4vupUAf-vRhH5VWLwoy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sypressi.dnainternet.net (sypressi.dnainternet.net
	[83.102.40.135]) by alsa0.perex.cz (Postfix) with ESMTP id BAC76245AA
	for <alsa-devel@alsa-project.org>; Sun,  2 Jan 2011 11:16:50 +0100 (CET)
In-Reply-To: <AANLkTimxHsUS_zVm0_m-vUcwt4vupUAf-vRhH5VWLwoy@mail.gmail.com>
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
Cc: VDR User <user.vdr@gmail.com>, alsa-dev <alsa-devel@alsa-project.org>, mailing@alsa-project.org, list@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

Takashi, it seems the "allow all when not plugged in" behaviour you
implemented in bbbe3390 is not enough to allow applications to open the
device before the output device is ready. Switched-off A/V receivers may
provide the information of the plugged-in television which usually
restricts the max_channels to 2, causing applications to fail opening
the device with more channels when a the A/V receiver is switched off.

Also, even if the application can gracefully fallback to stereo, AFAIK
there is no method for an application to get informed when the
limitation is lifted, so it can't automatically resume multichannel
output when the A/V receiver is switched on again.

Based on this info, I guess the restrictions based on ELD should be
removed :/
Unless you have some other ideas to fix the issue, of course.


On 23.12.2010 09:13, VDR User wrote:
> On Wed, Dec 22, 2010 at 9:48 PM, Anssi Hannula <anssi.hannula@iki.fi> wrote:
>> On 23.12.2010 04:22, VDR User wrote:
>>> Hi.  After updating my stable kernel from 2.6.35.7 to 2.6.36.2, I get
>>> a problem when tuning HDTV channels that use surround sound.  The
>>> error I get is as follows:
>>>
>>> audio_alsa_out: Cannot set number of channels to 6 (err=-22:Invalid argument)
>>> audio_out: open failed!
>>>
>>> With the following xine error:
>>> ---------------------- (ERROR) ----------------------
>>> The audio device is unavailable. Please verify if another program
>>> already uses it.
>>>
>>> ['Audio device unavailable' '']
>>> ------------------ (END OF ERROR) -------------------
>>
>> What are the contents of /proc/asound/NVidia/eld* and
>> /proc/asound/NVidia/codec* ?
> 
> Booted into 2.6.35.7 with receiver ON:
> $ cat /proc/asound/NVidia_1/eld*
> monitor_present         1
> eld_valid               1
> monitor_name            SONY AVAMP
> 
> connection_type         HDMI
> eld_version             [0x2] CEA-861D or below
> edid_version            [0x3] CEA-861-B, C or D
> manufacture_id          0xd94d
> product_id              0xfb01
> port_id                 0x20000
> support_hdcp            0
> support_ai              0
> audio_sync_delay        0
> speakers                [0x5f] FL/FR LFE FC RL/RR RC RLC/RRC
> sad_count               6
> sad0_coding_type        [0x1] LPCM
> sad0_channels           2
> sad0_rates              [0x1ee0] 44100 48000 88200 176400 192000 384000
> sad0_bits               [0xe0000] 16 20 24
> sad1_coding_type        [0x1] LPCM
> sad1_channels           6
> sad1_rates              [0x1ee0] 44100 48000 88200 176400 192000 384000
> sad1_bits               [0xe0000] 16 20 24
> sad2_coding_type        [0x1] LPCM
> sad2_channels           8
> sad2_rates              [0x1ee0] 44100 48000 88200 176400 192000 384000
> sad2_bits               [0xe0000] 16 20 24
> sad3_coding_type        [0x2] AC-3
> sad3_channels           6
> sad3_rates              [0xe0] 44100 48000 88200
> sad3_max_bitrate        680000
> sad4_coding_type        [0x7] DTS
> sad4_channels           6
> sad4_rates              [0x6e0] 44100 48000 88200 176400 192000
> sad4_max_bitrate        1536000
> sad5_coding_type        [0xa] E-AC-3/DD+ (Dolby Digital Plus)
> sad5_channels           8
> sad5_rates              [0xc0] 48000 88200
> 
> Booted into 2.6.35.7 with receiver OFF:
> $ cat /proc/asound/NVidia_1/eld*
> monitor_present         1
> eld_valid               1
> monitor_name            SONY AVAMP
> 
> connection_type         HDMI
> eld_version             [0x2] CEA-861D or below
> edid_version            [0x3] CEA-861-B, C or D
> manufacture_id          0xd94d
> product_id              0xfb01
> port_id                 0x20000
> support_hdcp            0
> support_ai              0
> audio_sync_delay        0
> speakers                [0xffff] FL/FR LFE FC RL/RR RC FLC/FRC RLC/RRC
> FLW/FRW FLH/FRH TC FCH
> sad_count               1
> sad0_coding_type        [0x1] LPCM
> sad0_channels           2
> sad0_rates              [0xe0] 44100 48000 88200
> sad0_bits               [0x20000] 16
> 
> I'm certain at the time I experienced this error, my receiver was
> turned off, could this be the cause of the error?  If so, this really
> needs to be fixed/reworked as many people don't have their receivers
> on (to save power usage, noise, etc) unless they specifically
> need/want it.  In the event a receiver is off and the user is trying
> to watch something that requires more then 2 channels, he should
> either turn the receiver on, or adjust the speaker arrangement in xine
> to stereo -- however, what should not happen is the alsa driver
> failing.  Maybe a better solution would be to log an error to syslog
> or something rather then the driver itself returning an error?

A/V receivers showing TV information is indeed something that wasn't
thought about :(

-- 
Anssi Hannula
