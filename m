From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - Fix runtime PM accounting
Date: Tue, 28 Aug 2012 08:14:43 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F81DA4D0@SHSMSX101.ccr.corp.intel.com>
References: <s5hwr0l7msk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 475102652CA
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2012 10:14:46 +0200 (CEST)
In-Reply-To: <s5hwr0l7msk.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Sunday, August 26, 2012 10:26 PM

> The flag codec->d3_clk_stop_ok isn't always set when the codec is powered
> off.  If it's not set, the controller driver doesn't change the runtime PM
> count.  This causes an unblanced accounting when multiple codecs are
> present.  

If the flag codec->d3_clk_stop_ok is not set on changes to D3, this flag will keep 0 and the same codec will not call pm_runtime_get_sync() on change back to D0. So I feel the runtime PM count is still balanced although the controller may lose a chance to suspend itself.

Usually, the first codec is powered down with CLK_STOP_OK=0,
> then the next codec with CLK_STOP_OK=1.  At this moment, the first codec
> is changed also to CLK_STOP_OK=1, but this isn't informed to the controller.
> Thus it still thinks as if one codec is active.

Does this conflict with spec? The spec says that PS-ClkStopOk should be set or cleared *before* entering D3: "if the codec requires BCLK to be available in D3 state, while a pass through loop is active, then it must indicate so by clearing the PS-ClkStopOk bit before entering D3 state, otherwise it must set that bit." If this is not true, then checking later is necessary.

> For fixing this issue, move the check of CLK_STOP_OK bit at the runtime
> suspend time, and simple up/down by the codec power save in
> azx_power_notifier().  For CLK_STOP_OK bit checks of all codecs, a new
> helper function is introduced.

I've tested your patch but with a little change. Because one of my codecs cannot support stop-clock, I pretend it can by setting codec->d3_clk_stop. Then I found snd_hda_bus_ready_for_d3() blocks when getting this codec's power state, and so the runtime PM status keeps SUSPENDING. I'm not sure it's because this codec cannot support 'get state' after entering D3 for some time, or other reason. 
I've just got a new codec that should support 'stop-clk' in D3 and I'll test the new codec. My platform is not stable and it may take some time to do the test. Thanks!

> +/* check whether all codecs are ready to stop clock */ bool
> +snd_hda_bus_ready_for_d3(struct hda_bus *bus) {
> +	struct hda_codec *codec;
> +
> +	list_for_each_entry(codec, &bus->codec_list, list) {
> +		unsigned int state;
> +		int fg = codec->afg ? codec->afg : codec->mfg;
> +
> +		if (!codec->d3_stop_clk)
> +			return false;
> +		state = snd_hda_codec_read(codec, fg, 0,
> +					   AC_VERB_GET_POWER_STATE, 0);   ... blocked here.
> +		if (!(state & AC_PWRST_CLK_STOP_OK))
> +			return false;
> +	}
> +	return true;
> +}

Thanks
Mengdong
