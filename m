From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 0/3] enable HDMI audio output for HDMI monitors
	V2
Date: Fri, 07 Nov 2008 14:23:38 +0800
Message-ID: <20081107062338.158523355@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmsmga102.fm.intel.com (mga10.intel.com [192.55.52.92])
	by alsa0.perex.cz (Postfix) with ESMTP id CB11D10388A
	for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2008 07:24:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wang Zhenyu <zhenyu.z.wang@intel.com>
Cc: alsa-devel@alsa-project.org, linux-gfx@linux.intel.com, xorg@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

Hello,

We can now enjoy music on HDMI monitors that are attached to Intel G35/G45
chipsets with the following X.org intel driver patches

      [PATCH 1/3] introduce i830_hdmi_priv.has_hdmi_sink
      [PATCH 2/3] enable Intel G45 integrated HDMI audio output
      [PATCH 3/3] enable Intel G35 SDVO HDMI audio output

_and_ the corresponding ALSA patch posted at
http://mailman.alsa-project.org/pipermail/alsa-devel/2008-November/012158.html

The patches are tested OK on Intel DG45ID board, HP 2230s notebook and
ASUS P5E-VM board.

Since the HDMI audio requires both audio and video driver support to function
well, I'd like to provide an overview here.

1) driver components:
	A) ALSA: audio driver (the above link)
	B) Xorg: audio output enabling (this patchset)
	C) Xorg: EDID/ELD information (patches to be submitted by Ma Ling)

2) summary of the feature sets:
	- basic 2-channel audio:
		(A) is required, (B) is mostly required, (C) is not needed
	- 2+ multichannel audio:
		not tested yet; in theory we need (C) to get HDMI monitor's
		speaker allocation configuration; there are also bandwidth
		constraints that should be coordinated between audio/video
		drivers in the future.
	- non-LPCM audio:
		not tested yet; need more work in ALSA code.

3) summary of the work flow:
	- basic audio output: (A) and (B)
		- ALSA HDMI driver: enable pin out and unmute
		- ALSA HDMI driver: fill audio infoframe and enable its transmission
		- Xorg intel driver: enable audio output
	- ELD info for advanced audio capabilities: (A) and (C)
		- Xorg xserver: get/parse/store EDID extensions
		- Xorg xserver: transform EDID into ELD
		- Xorg intel driver: feed ELD to hardware
		- Xorg intel driver: set ELD-Valid flag to inform audio driver of new ELD
		- ALSA HDMI driver: response to unsolicited response triggered by ELDV
		- ALSA HDMI driver: get ELD from hardware
		- ALSA HDMI driver: parse and show ELD info
		- ALSA HDMI driver: update hardware capabilities/constraints
				    according to ELD (TBD)

That describes my understandings of HDMI audio, comments and discussions are
warmly welcome.

Thank you,
Fengguang
--
