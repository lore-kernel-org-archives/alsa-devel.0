From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090
 codec
Date: Thu, 16 Jul 2015 16:15:16 +0200
Message-ID: <1437056116.28351.19.camel@tiscali.nl>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
	 <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
	 <1437033944.27428.11.camel@tiscali.nl>
	 <20150716110032.GU11162@sirena.org.uk>
	 <1437047261.28351.6.camel@tiscali.nl> <20150716125529.GG4039@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150716125529.GG4039@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Xing Zheng <zhengxing@rock-chips.com>, dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On do, 2015-07-16 at 13:55 +0100, Mark Brown wrote:
> No, in that case you've not understood what the MODULE_ALIAS is
> for.  It's there so that userspace knows which module to load if it 
> gets
> a device with no driver, it goes in the driver not in the code
> registering the device.

That's exactly how I understood MODULE_ALIAS() to work.

And it works, in short, because a platform device fires a
"MODALIAS=platform:[...]" uevent when it's created. And userspace uses
that uevent to load the module carrying that alias.

Let's put it this was. If one does
    sudo find /sys -perm -o=r -name uevent -exec grep -H MODALIAS=platform: {} \;

or
    sudo find /sys -perm -o=r -name modalias -exec grep -H platform: {} \;

(both lists should be similar)

on the systems this patch is targeting, will
   platform:rockchip-snd-max98090

then show up?

Thanks,


Paul Bolle
