From: Wu Fengguang <fengguang.wu@intel.com>
Subject: the monitors with working Displayport audio
Date: Wed, 9 Nov 2011 15:20:53 +0800
Message-ID: <20111109072053.GA21956@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Lv, Jane" <jane.lv@intel.com>, alsa-devel@alsa-project.org, "Barnes,
	Jesse" <jesse.barnes@intel.com>, "intel-gfx@lists.freedesktop..." <intel-gfx@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I enumerated all the DELL DisplayPort monitors in our lab and find
only two of them being able to produce audible DisplayPort audio...

- DELL 2408WFP
- DELL 2709W
- DELL 3008WFP
        no CEA extension found

- DELL U2410
        ELD reports OK but cannot hear DP sound

        monitor_present         1
        eld_valid               1
        monitor_name            DELL U2410
        connection_type         DisplayPort
        eld_version             [0x2] CEA-861D or below
        edid_version            [0x3] CEA-861-B, C or D
        manufacture_id          0xac10
        product_id              0xf017
        port_id                 0x0
        support_hdcp            0
        support_ai              0
        audio_sync_delay        0
        speakers                [0x1] FL/FR
        sad_count               1
        sad0_coding_type        [0x1] LPCM
        sad0_channels           2
        sad0_rates              [0xe0] 32000 44100 48000
        sad0_bits               [0xe0000] 16 20 24

- DELL U3011
        ELD and DP sound both OK

        monitor_present         1
        eld_valid               1
        monitor_name            DELL U3011
        connection_type         DisplayPort
        eld_version             [0x2] CEA-861D or below
        edid_version            [0x3] CEA-861-B, C or D
        manufacture_id          0xac10
        product_id              0x4065
        port_id                 0x0
        support_hdcp            0
        support_ai              0
        audio_sync_delay        0
        speakers                [0xf] FL/FR LFE FC RL/RR
        sad_count               1
        sad0_coding_type        [0x1] LPCM
        sad0_channels           6
        sad0_rates              [0x1ee0] 32000 44100 48000 96000 176400 192000 384000
        sad0_bits               [0xe0000] 16 20 24

- Eizo FlexScan EV2333W
        ELD and DP sound both OK

        monitor_present         1
        eld_valid               1
        monitor_name            EV2333W
        connection_type         DisplayPort
        eld_version             [0x2] CEA-861D or below
        edid_version            [0x3] CEA-861-B, C or D
        manufacture_id          0xc315
        product_id              0x2068
        port_id                 0x0
        support_hdcp            0
        support_ai              1
        audio_sync_delay        0
        speakers                [0x1] FL/FR
        sad_count               1
        sad0_coding_type        [0x1] LPCM
        sad0_channels           2
        sad0_rates              [0x1ee0] 32000 44100 48000 96000 176400 192000 384000
        sad0_bits               [0xe0000] 16 20 24

Thanks,
Fengguang
