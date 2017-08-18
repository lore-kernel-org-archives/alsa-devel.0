From: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v3 1/9] ASoC: rt5514: Switch to
	snd_soc_register_codec
Date: Fri, 18 Aug 2017 10:48:39 +0800
Message-ID: <59965587.7040409@rock-chips.com>
References: <20170817044417.22069-1-jeffy.chen@rock-chips.com>
 <20170817044417.22069-2-jeffy.chen@rock-chips.com>
 <20170817171120.xvvsmx2fleeqj2s5@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.140])
 by alsa0.perex.cz (Postfix) with ESMTP id B006226648D
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 04:49:02 +0200 (CEST)
In-Reply-To: <20170817171120.xvvsmx2fleeqj2s5@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, heiko@sntech.de, Liam Girdwood <lgirdwood@gmail.com>, briannorris@chromium.org, dianders@chromium.org, linux-kernel@vger.kernel.org, mka@chromium.org, Takashi Iwai <tiwai@suse.com>, Bard Liao <bardliao@realtek.com>, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 08/18/2017 01:11 AM, Mark Brown wrote:
> On Thu, Aug 17, 2017 at 12:44:09PM +0800, Jeffy Chen wrote:
>> Currently we are using devm_snd_soc_register_component, which would
>> use legacy dai name.
>
>> Switch to snd_soc_register_codec to use dai driver name.
>
> This is the wrong direction to be going in, we are trying to move all
> drivers to use component.  Whatever you want to do make components use
> it.
>

i was trying to make dai name use dai driver name:

         /*
          * Back in the old days when we still had component-less DAIs,
          * instead of having a static name, component-less DAIs would
          * inherit the name of the parent device so it is possible to
          * register multiple instances of the DAI. We still need to keep
          * the same naming style even though those DAIs are not
          * component-less anymore.
          */
         if (legacy_dai_naming &&
            (dai_drv->id == 0 || dai_drv->name == NULL)) {
                 dai->name = fmt_single_name(dev, &dai->id);
         } else {
                 dai->name = fmt_multiple_name(dev, dai_drv);


specify an non-zero id for dai driver works too, i'll do it in new 
patches :)
