From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090
 codec
Date: Thu, 16 Jul 2015 13:47:41 +0200
Message-ID: <1437047261.28351.6.camel@tiscali.nl>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
	 <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
	 <1437033944.27428.11.camel@tiscali.nl>
	 <20150716110032.GU11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150716110032.GU11162@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Xing Zheng <zhengxing@rock-chips.com>, dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On do, 2015-07-16 at 12:00 +0100, Mark Brown wrote:
> You've got platform_device and platform_driver confused I think.

I did? You mean that creating a platform_DRIVER triggers that
MODALIAS=platform:{...] uevent?


Paul Bolle
