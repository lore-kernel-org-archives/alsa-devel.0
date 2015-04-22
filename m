From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - add AZX_DCAPS_I915_POWERWELL
	to Baytrail
Date: Wed, 22 Apr 2015 09:54:24 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B83AB96@SHSMSX101.ccr.corp.intel.com>
References: <e8074c2236ff5b224dbc8a92cca40f348ca5032c.1429592999.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 3111C260566
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 11:54:29 +0200 (CEST)
In-Reply-To: <e8074c2236ff5b224dbc8a92cca40f348ca5032c.1429592999.git.mengdong.lin@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
Cc: "Yang, Libin" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Lin, Mengdong
> Sent: Tuesday, April 21, 2015 1:12 PM
> To: alsa-devel@alsa-project.org; tiwai@suse.de
> Cc: Lin, Mengdong
> Subject: [PATCH] ALSA: hda - add AZX_DCAPS_I915_POWERWELL to Baytrail
> 
> From: Mengdong Lin <mengdong.lin@intel.com>
> 
> This patch addes AZX_DCAPS_I915_POWERWELL to BYT (Baytrail).
> 
> Like Braswell and Skylake, the HDMI codec on Bytrail is also in the shared
> power well with GPU. This power well must be turned on before we reset link
> to probe the codec, to avoid communication failure with the codec.
> 
> The side effect is that this power is always ON in S0 because the BYT HDMI
> codec does not support EPSS or D3ClkStop and so the controller doesn't enter
> D3 at runtime, and the HDMI codec and analog codec share a single physical
> HD-A link and so we cannot reset the HD-A link freely when we re-enable the
> power to use the HDMI codec.
> 
> Next step is to test if an AGP reset or double AGP reset on BYT HDMI codec is
> okay to bring the HDMI codec back to a functional state after restoring the
> power. If okay, we can bind the power on/off with the HDMI codec PM without
> interrupting the analog audio.

Test on Baytrail is positive. There is no need to use AGP reset. We can
-  release the shared i915 power at the end of azx_probe_continue()
-  request the power in snd_hda_codec_register(), since the codec initial power state is D0.
-  request/release the power in hda_codec_runtime_resume/suspend.

We'll do more stress test on Baytrail and Braswell. These two platforms have similar silicon implementation. 
And finally we'll test Skylake.

Thanks
Mengdong
