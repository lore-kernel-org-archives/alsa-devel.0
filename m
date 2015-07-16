From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090
 codec
Date: Thu, 16 Jul 2015 18:08:35 +0200
Message-ID: <1437062915.21215.7.camel@tiscali.nl>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
		   <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
		  <1437033944.27428.11.camel@tiscali.nl> <55A79394.5090905@rock-chips.com>
		 <1437047374.28351.8.camel@tiscali.nl> <55A79C8B.7020402@rock-chips.com>
	 <1437056383.28351.23.camel@tiscali.nl> <55A7CCDE.9010701@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55A7CCDE.9010701@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: zhengxing <zhengxing@rock-chips.com>, dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Gerry,

On do, 2015-07-16 at 23:25 +0800, Jiang Liu wrote:
> May be that is hidden in some device tree files.
> MODULE_ALIAS() is used by a driver to announce that it supports
> such types of devices. And bus enumerator will create those
> devices by probing hardware or parsing some configuration files.

Then someone could simply point me to the device tree file where that
"platform:" alias comes from. (Note that I, of course, do check the tree
for the substrings involved before tossing questions like these onto
lkml.)

Besides, as far as I can tell, for device tree support the magic
actually hides in
    MODULE_DEVICE_TABLE(of, rockchip_max98090_of_match);

Which, I think, implies that any MODULE_ALIAS("platform:[...]") is
pointless for systems booting with device tree support.

Thanks,


Paul Bolle
