From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 0/4] multi-channel HDMI audio support
Date: Wed, 19 Nov 2008 08:56:14 +0800
Message-ID: <20081119005614.431653658@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga101.ch.intel.com (mga07.intel.com [143.182.124.22])
	by alsa0.perex.cz (Postfix) with ESMTP id B8DAF244E9
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 02:41:26 +0100 (CET)
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

Hi Takashi,

This patchset attempts to support multi-channel HDMI audio.

It contains two basic operations:

- setup the CA(channel-allocation) byte in the audio infoframe
- setup the converter channel to HDMI slot mapping

Please read patch 3 for more detailed descriptions:

	[PATCH 1/4] hda: make standalone hdmi_fill_audio_infoframe()                               
	[PATCH 2/4] hda: make global snd_print_channel_allocation()                       
	[PATCH 3/4] hda: HDMI channel allocations for audio infoframe                               
	[PATCH 4/4] hda: HDMI channel mapping cleanups                                               

The current implementation only does minimal works that ensure multi-channel
audio playing out. However the wrong speakers may be selected. We could
elaborate the framework/policy if it proves to be a problem.

Thank you,
Fengguang
-- 
