From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v2 1/3] ASoC: rockchip: Parse dai links
	from dts
Date: Wed, 16 Aug 2017 16:50:58 -0700
Message-ID: <20170816235058.GA173745@google.com>
References: <1502340898-28403-1-git-send-email-jeffy.chen@rock-chips.com>
 <1502340898-28403-2-git-send-email-jeffy.chen@rock-chips.com>
 <20170816215909.GC109008@google.com>
 <5994CD58.7030406@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f52.google.com (mail-pg0-f52.google.com [74.125.83.52])
 by alsa0.perex.cz (Postfix) with ESMTP id A4165266BF6
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 01:51:02 +0200 (CEST)
Received: by mail-pg0-f52.google.com with SMTP id t80so3261233pgb.5
 for <alsa-devel@alsa-project.org>; Wed, 16 Aug 2017 16:51:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5994CD58.7030406@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jeffy <jeffy.chen@rock-chips.com>
Cc: alsa-devel@alsa-project.org, heiko@sntech.de, Liam Girdwood <lgirdwood@gmail.com>, briannorris@chromium.org, dianders@chromium.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, dgreid@chromium.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

El Thu, Aug 17, 2017 at 06:55:20AM +0800 jeffy ha dit:

> hi matthias,
> 
> thanks for your suggestion.
> 
> On 08/17/2017 05:59 AM, Matthias Kaehlcke wrote:
> >El Thu, Aug 10, 2017 at 12:54:56PM +0800 Jeffy Chen ha dit:
> >
> >>>Refactor rockchip_sound_probe, parse dai links from dts instead of
> >>>hard coding them.
> >Mark doesn't seem to be overly convinced that 'rockchip,codec-names'
> >is a good idea (https://lkml.org/lkml/2017/8/10/511).
> >
> >How about using something like this instead:
> >
> >static const char *dailink_compat[] = {
> >	[DAILINK_MAX98357A] = "maxim,max98357a",
> >	[DAILINK_RT5514] = "realtek,rt5514",
> >	[DAILINK_DA7219] = "dlg,da7219",
> >};
> i've thought about this too, but i'm working on converting rt5514
> dsp(spi) from codec name matching to of_node, and it would have the
> same compatible with rt5514(i2c)

Bummer!

I wonder if a relatively inoffensive DT hack would be an appropriate
solution in this case, since the conflicting compatible string is a
somewhat special case and this change only affects the DT and the
driver/glue of a specific device (family).

The hack would consist in adding an additional 'compatible' entry to
the DT entry of the codec, which is ignored by the rt5514 driver, and
only used by the sound glue to identify it:

--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -671,7 +671,7 @@ ap_i2c_mic: &i2c1 {
        i2c-scl-rising-time-ns = <300>;
 
        headsetcodec: rt5514@57 {
-               compatible = "realtek,rt5514";
+               compatible = "realtek,rt5514", "realtek,rt5514-i2c";


And then use "realtek,rt5514-i2c" in dailink_compat.

Mark, would you prefer a hack like this over the list of codec names
or do you have any other suggestions?

Matthias
