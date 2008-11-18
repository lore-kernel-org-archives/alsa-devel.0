From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 0/4] [RFC] multi-channel HDMI audio support
Date: Tue, 18 Nov 2008 16:57:13 +0800
Message-ID: <20081118085713.252457834@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga102.ch.intel.com (mga12.intel.com [143.182.124.36])
	by alsa0.perex.cz (Postfix) with ESMTP id C62C1244D7
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 09:58:27 +0100 (CET)
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

Hi all,

This patchset attempts to support multi-channel HDMI audio.

It contains two basic operations:

- setup the CA(channel-allcation) byte in the audio infoframe
- setup the converter channel to HDMI slot mapping

Please check the last two patches for the detailed descriptions:

	[PATCH 1/4] hda: make standalone hdmi_fill_audio_infoframe()                               
	[PATCH 2/4] hda: make global snd_print_channel_allocation()                       

	[PATCH 3/4] hda: HDMI channel allocations for audio infoframe                               
	[PATCH 4/4] hda: HDMI channel mapping cleanups                                               

The current implementation only does minimal works that can ensure the
multi-channel audio playing out. However the wrong speakers may be choosed, and
I really need more information/knowledge/instructions from you to get it right.

Thank you,
Fengguang
-- 
