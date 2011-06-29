From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH] pass ELD to HDMI/DP audio driver
Date: Wed, 29 Jun 2011 14:36:39 +0800
Message-ID: <20110629063639.GA18376@localhost>
References: <20110629062013.GA17296@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id CDFBC246F8
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 08:36:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110629062013.GA17296@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "intel-gfx@lists.freedesktop..." <intel-gfx@lists.freedesktop.org>
Cc: Keith Packard <keithp@keithp.com>, Wang Zhenyu <zhenyu.z.wang@intel.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Zhao Yakui <yakui.zhao@intel.com>, Ben Skeggs <bskeggs@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Christopher White <c.white@pulseforce.com>, Jeremy Bush <contractfrombelow@gmail.com>, "Bossart,
	Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

> This patch is tested OK on G45/HDMI and IbexPeak/HDMI. DisplayPort is
> tested on several IbexPeak and Sandybridge boxes, however not working,
> possibly due to hardware/monitor problems.

FYI, here is an example ELD dump in G45/HDMI.

wfg@slim ~% cat /proc/asound/card0/eld\#1.0
monitor_present         1
eld_valid               1
monitor_name            RX-V1800
connection_type         HDMI
eld_version             [0x2] CEA-861D or below
edid_version            [0x3] CEA-861-B, C or D
manufacture_id          0xa865
product_id              0x3116
port_id                 0x0
support_hdcp            0
support_ai              1
audio_sync_delay        0
speakers                [0x5f] FL/FR LFE FC RL/RR RC RLC/RRC
sad_count               8
sad0_coding_type        [0x1] LPCM
sad0_channels           2
sad0_rates              [0x1ee0] 44100 48000 88200 176400 192000 384000
sad0_bits               [0xe0000] 16 20 24
sad1_coding_type        [0x1] LPCM
sad1_channels           8
sad1_rates              [0x1ee0] 44100 48000 88200 176400 192000 384000
sad1_bits               [0xe0000] 16 20 24
sad2_coding_type        [0x2] AC-3
sad2_channels           6
sad2_rates              [0xe0] 44100 48000 88200
sad2_max_bitrate        640000
sad3_coding_type        [0x7] DTS
sad3_channels           7
sad3_rates              [0x6e0] 44100 48000 88200 176400 192000
sad3_max_bitrate        1536000
sad4_coding_type        [0x9] DSD (One Bit Audio)
sad4_channels           6
sad4_rates              [0x40] 48000
sad5_coding_type        [0xa] E-AC-3/DD+ (Dolby Digital Plus)
sad5_channels           8
sad5_rates              [0xc0] 48000 88200
sad6_coding_type        [0xc] MLP (Dolby TrueHD)
sad6_channels           8
sad6_rates              [0x1480] 88200 192000
sad7_coding_type        [0xb] DTS-HD
sad7_channels           8
sad7_rates              [0x1480] 88200 192000

Thanks,
Fengguang
