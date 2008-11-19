From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 0/5] assorted HDMI cleanups
Date: Wed, 19 Nov 2008 15:13:58 +0800
Message-ID: <20081119071358.231716724@linux.intel.com>
Content-Type: multipart/mixed; boundary="===============4203606613362849021=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga101.ch.intel.com (mga07.intel.com [143.182.124.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 24CAA245C1
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 08:25:58 +0100 (CET)
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

--===============4203606613362849021==

Hi Takashi,

Here are 5 HDMI cleanup patches, some renames the code and others renames the
user visible output messages. The new output goes like:

dmesg

	[ 5742.169578] detected monitor <9d><80>t connection type Display Port
	[ 5742.169580] available speakers: FL/FR LFE FLC/FRC
	[ 5742.169582] supports coding type MLP (Dolby TrueHD): channels = 7, rates = 48000 176400
	[ 5742.169585] supports coding type AC-3: channels = 1, rates = 48000 88200 192000, max bitrate = 1208000
	[ 5742.169588] supports coding type AC-3: channels = 2, rates = 48000 384000, max bitrate = 960000
	[ 5742.169591] supports coding type ATRAC: channels = 5, rates = 48000 88200 384000, max bitrate = 224000


/proc/asound/card0/eld\#3

	monitor name            ���
	connection_type         Display Port
	eld_version             [0xb] reserved
	edid_version            [0x3] CEA-861-B, C or D
	manufacture_id          0xee5a
	product_id              0x923c
	port_id                 0x18b263a03e17d1b5
	support_hdcp            1
	support_ai              1
	audio_sync_delay        216
	speakers                [0x23] FL/FR LFE FLC/FRC
	sad_count               4
	sad0_coding_type        [0xc] MLP (Dolby TrueHD)
	sad0_channels           7
	sad0_rates              [0x240] 48000 176400
	sad1_coding_type        [0x2] AC-3
	sad1_channels           1
	sad1_rates              [0x4c0] 48000 88200 192000
	sad1_max_bitrate        1208000
	sad2_coding_type        [0x2] AC-3
	sad2_channels           2
	sad2_rates              [0x1840] 48000 384000
	sad2_max_bitrate        960000
	sad3_coding_type        [0x8] ATRAC
	sad3_channels           5
	sad3_rates              [0x8c0] 48000 88200 384000
	sad3_max_bitrate        224000

Thanks,
Fengguang
-- 


--===============4203606613362849021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4203606613362849021==--
