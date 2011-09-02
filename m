From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH v4] drm/i915: pass ELD to HDMI/DP audio
	driver
Date: Fri, 2 Sep 2011 16:29:26 +0800
Message-ID: <20110902082926.GA19820@localhost>
References: <20110902081428.GA19621@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id CBD1C1038A2
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Sep 2011 10:29:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110902081428.GA19621@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Keith Packard <keithp@keithp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
	Zhenyu Z" <zhenyu.z.wang@intel.com>, "intel-gfx@lists.freedesktop..." <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Zhao, Yakui" <yakui.zhao@intel.com>, Ben Skeggs <bskeggs@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Christopher White <c.white@pulseforce.com>, Jeremy Bush <contractfrombelow@gmail.com>, "Fu,
	Michael" <michael.fu@intel.com>, "Bossart,
	Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

Keith: this version completes the IvyBridge support :)

Bossart: hotplug is working fine now, with some minor issues:

- on G45, monitor hot removal is not handled at all in
  i915_driver_irq_handler(). I'll leave it as a future TODO.

- on IvyBridge, _repeated_ plug/unplug will trigger

  [ 1183.654859] ALSA hda_eld.c:259 HDMI: Unknown ELD version 0

  which means the ELD_valid flag will be seen by audio driver,
  however it cannot get any valid ELD data. I double checked and
  find everything in the graphics driver is working as expected:
  ironlake_write_eld() is writing the good ELD data to the same
  pipe on hot plug events. So I'll leave it as a possible bug of
  the early stage hardware.

Thanks,
Fengguang
