From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 0/5] updates for Intel SandyBridge/CougarPoint
	HDMI codec
Date: Wed, 12 May 2010 09:30:15 +0800
Message-ID: <20100512013015.752623810@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id B8FF0103933
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 03:58:40 +0200 (CEST)
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

So ALSA has to support more than 8 PCM playback devices now. The first two
patches do this dirty work, however I'm not sure if they will introduce some
side effects.

The last three patches are more straightforward and safe.

Thanks,
Fengguang
