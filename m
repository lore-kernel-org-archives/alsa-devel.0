From: Olivier Langlois <olivier@trillion01.com>
Subject: Re: [RFC/RFT v2 0/4] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Wed, 09 Oct 2013 00:32:14 -0400
Message-ID: <1381293134.845.4.camel@Wailaba2>
References: <1380659456-3746-1-git-send-email-anssi.hannula@iki.fi>
 <1380870371.875.14.camel@Wailaba2> <524F51C6.7050203@iki.fi>
 <1381031338.10109.2.camel@Wailaba2> <5251528B.4010506@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy4-pub.mail.unifiedlayer.com
 (oproxy4-pub.mail.unifiedlayer.com [74.220.216.66])
 by alsa0.perex.cz (Postfix) with SMTP id 5D1CA260795
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2013 06:32:17 +0200 (CEST)
In-Reply-To: <5251528B.4010506@iki.fi>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, linux-kernel@vger.kernel.org, Peter =?ISO-8859-1?Q?Fr=FChberger?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org


> 
> Then please test everything again. I.e.
>   o speaker-test -D hdmi:CARD=Generic,DEV=0 -c8 -r192000 -F S32_LE
> 
this work fine

>   o Is there any difference seen
>     with these, in the beginning/end (i.e. fade-out/in):
>     speaker-test -D hdmi:CARD=Generic,DEV=0,AES0=0x04 -c2 -r48000
>     speaker-test -D hdmi:CARD=Generic,DEV=0,AES0=0x06 -c2 -r48000
> 
I have the same result as before the last fix. AES0=0x04 works
AES0=0x06 doesn't. No error is emitted from speaker-test but no sound is
coming out speakers.

>   o Also, is there a difference in the beginning of these
>     (maybe garbage sound and/or slightly slower startup?):
>     aplay -Dhdmi:CARD=Generic,DEV=0,AES0=4 -r44100 -f s16_le -c2
> testi.dts.cut.spdif
>     aplay -Dhdmi:CARD=Generic,DEV=0,AES0=6 -r44100 -f s16_le -c2
> testi.dts.cut.spdif

no garbage. Maybe slightly slower startup with AES0=0x6.
> 
>   o Contents of /proc/asound/cardX/eld#0.0
> 
> Thanks a lot :)
> 
monitor_present		1
eld_valid		1
monitor_name		SC-09TX
connection_type		HDMI
eld_version		[0x2] CEA-861D or below
edid_version		[0x0] no CEA EDID Timing Extension block present
manufacture_id		0x2f41
product_id		0x0
port_id			0x10000000005
support_hdcp		0
support_ai		0
audio_sync_delay	0
speakers		[0x4f] FL/FR LFE FC RL/RR RLC/RRC
sad_count		7
sad0_coding_type	[0x1] LPCM
sad0_channels		8
sad0_rates		[0x1ee0] 32000 44100 48000 88200 96000 176400 192000
sad0_bits		[0xe0000] 16 20 24
sad1_coding_type	[0x2] AC-3
sad1_channels		6
sad1_rates		[0xe0] 32000 44100 48000
sad1_max_bitrate	640000
sad2_coding_type	[0x7] DTS
sad2_channels		7
sad2_rates		[0x6c0] 44100 48000 88200 96000
sad2_max_bitrate	1536000
sad3_coding_type	[0xa] E-AC-3/DD+ (Dolby Digital Plus)
sad3_channels		8
sad3_rates		[0xc0] 44100 48000
sad4_coding_type	[0xb] DTS-HD
sad4_channels		8
sad4_rates		[0x1ec0] 44100 48000 88200 96000 176400 192000
sad5_coding_type	[0xc] MLP (Dolby TrueHD)
sad5_channels		8
sad5_rates		[0x1ec0] 44100 48000 88200 96000 176400 192000
sad6_coding_type	[0xe] WMAPro
sad6_channels		8
sad6_rates		[0x6e0] 32000 44100 48000 88200 96000
sad6_profile		3
