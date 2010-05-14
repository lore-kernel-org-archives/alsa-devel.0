From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 0/4] updates for Intel SandyBridge/CougarPoint
	HDMI codec V2
Date: Fri, 14 May 2010 16:36:11 +0800
Message-ID: <20100514083611.624260274@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id BD4E5244B8
	for <alsa-devel@alsa-project.org>;
	Fri, 14 May 2010 10:41:19 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

The Intel SandyBridge/CougarPoint HDMI codec is very similar to the
IbexPeak HDMI codec, except that it exports one more Audio Converter.

Now we have 3 Audio Converters, each of them present one HDMI PCM device:
(and expect a 4th HDMI PCM device in future)

	$ aplay -l | grep HDMI
	card 0: PCH [HDA Intel PCH], device 3: INTEL HDMI 0 [INTEL HDMI 0]
	card 0: PCH [HDA Intel PCH], device 7: INTEL HDMI 1 [INTEL HDMI 1]
	card 0: PCH [HDA Intel PCH], device 8: INTEL HDMI 2 [INTEL HDMI 2]

So enable devices minors to support more than 8 PCM playback devices.

Thanks,
Fengguang
