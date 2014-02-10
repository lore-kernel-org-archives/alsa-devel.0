From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 0/7] Audio support for Armada 370 DB
Date: Mon, 10 Feb 2014 15:21:41 +0100
Message-ID: <20140210152141.1391fb67@skate>
References: <1391102051-5319-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 884372619D6
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2014 15:22:08 +0100 (CET)
In-Reply-To: <1391102051-5319-1-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello,

Any comments on the patch series? I'd like these to be included in
3.15, and so far I've only received one simple comment from Jason
Cooper regarding the defconfig changes, but no other comments.

Thanks a lot!

Thomas

On Thu, 30 Jan 2014 18:14:04 +0100, Thomas Petazzoni wrote:
> Hello,
> 
> This series of patches enable audio support on the Marvell Armada 370
> Development Board. Since both the I2S controller on the SoC side and
> the I2C audio codec are already supported by the kernel, the amount of
> work is fairly limited.
> 
> Also, since the DT bindings that allows to replace the ASoC board
> driver are still being ironed out, I'm proposing to add an old-style
> ASoC board driver for now.
> 
> This set of patches only provide support for the analog output and
> input, I am waiting for the optical cable to arrive to get the digital
> input and output to work.
> 
> Patches 1 to 3 are to be taken by the ASoC maintainer, while patches 4
> to 7 are to be taken by the mvebu maintainers.
> 
> Note that the audio support for Armada 370 also needs a fix to the
> CS42L51, which is being discussed with the author of the change that
> apparently introduced the problem (see discussion at
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/071916.html).
> 
> Thanks,
> 
> Thomas
> 
> Thomas Petazzoni (7):
>   sound: codec: add Device Tree binding to cs42l51
>   sound: soc: enable Kirkwood driver for mvebu platforms
>   sound: soc: add ASoC board driver for Armada 370 DB
>   ARM: mvebu: add audio I2S controller to Armada 370 Device Tree
>   ARM: mvebu: add I2C0 muxing option for Armada 370 SoC
>   ARM: mvebu: add audio support to Armada 370 DB
>   ARM: mvebu: enable audio options in mvebu_defconfig
> 
>  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
>  .../devicetree/bindings/sound/mvebu-audio.txt      |   1 +
>  arch/arm/boot/dts/armada-370-db.dts                |  46 +++++++
>  arch/arm/boot/dts/armada-370.dtsi                  |  29 +++++
>  arch/arm/configs/mvebu_defconfig                   |   5 +
>  sound/soc/codecs/cs42l51.c                         |   7 +
>  sound/soc/kirkwood/Kconfig                         |  10 +-
>  sound/soc/kirkwood/Makefile                        |   2 +
>  sound/soc/kirkwood/armada-370-db.c                 | 144 +++++++++++++++++++++
>  sound/soc/kirkwood/kirkwood-i2s.c                  |   1 +
>  10 files changed, 245 insertions(+), 1 deletion(-)
>  create mode 100644 sound/soc/kirkwood/armada-370-db.c
> 



-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
