From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 2/2] drm/i915: pass ELD to HDMI/DP audio
	driver
Date: Mon, 5 Sep 2011 14:50:42 +0800
Message-ID: <20110905065042.GB20230@localhost>
References: <20110905062320.GA7535@localhost>
	<20110905062534.GA20230@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id EDA4F103848
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Sep 2011 08:50:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110905062534.GA20230@localhost>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wang Zhenyu <zhenyu.z.wang@intel.com>, "intel-gfx@lists.freedesktop..." <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Chris Wilson <chris@chris-wilson.co.uk>, Zhao Yakui <yakui.zhao@intel.com>, "Fu,
	Michael" <michael.fu@intel.com>, Ben Skeggs <bskeggs@redhat.com>, James Cloos <cloos@jhcloos.com>, Christopher White <c.white@pulseforce.com>, Jeremy Bush <contractfrombelow@gmail.com>, Paul Menzel <paulepanter@users.sourceforge.net>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

I'd like to do more cleanups:

> +	int aud_cntl_st;
> +	int aud_cntrl_st2;

s/aud_cntrl_st2/aud_cntl_st2/

> +	if (IS_IVYBRIDGE(connector->dev)) {
> +		hdmiw_hdmiedid = GEN7_HDMIW_HDMIEDID_A;
> +		aud_cntl_st = GEN7_AUD_CNTRL_ST_A;
> +		aud_cntrl_st2 = GEN7_AUD_CNTRL_ST2;
> +	} else {
> +		hdmiw_hdmiedid = GEN5_HDMIW_HDMIEDID_A;
> +		aud_cntl_st = GEN5_AUD_CNTL_ST_A;
> +		aud_cntrl_st2 = GEN5_AUD_CNTL_ST2;
> +	}
> +
> +	i = to_intel_crtc(crtc)->pipe;
> +	hdmiw_hdmiedid += i * 0x100;
> +	aud_cntl_st += i * 0x100;
> +
> +	DRM_DEBUG_DRIVER("ELD on pipe %c\n", pipe_name(i));
[...]
> +	len = min_t(uint8_t, eld[2], 21);	/* 84 bytes of hw ELD buffer */
> +	DRM_DEBUG_DRIVER("ELD size %d\n", len);

Merge the above two DRM_DEBUG_DRIVER() calls into:

+       DRM_DEBUG_DRIVER("writing %d ELD dword(s) on pipe %c\n",
+                        len, pipe_name(to_intel_crtc(crtc)->pipe));

> +	for (i = 0; i < len; i++)
> +		I915_WRITE(hdmiw_hdmiedid, *((uint32_t *)eld + i));

Thanks,
Fengguang
