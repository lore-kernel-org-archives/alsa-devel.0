From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Question on arm64 unaligned faults during playback
Date: Tue, 09 Dec 2014 09:19:55 +0100
Message-ID: <5486B0AB.7000109@ladisch.de>
References: <CAM4voa=kiLsiLEzUbo3D+f1go5px78fXBSjSi7kGK4QCdnwPyQ@mail.gmail.com>	<54856621.8090107@ladisch.de>
 <s5hppbumnis.wl-tiwai@suse.de>	<54858868.70708@metafoo.de>	<20141208122549.GF16185@e104818-lin.cambridge.arm.com>
 <CAM4voam0h4e1Z8q3eqNpgMhhfw-zJpfh7fi4iznX_Y0bj98nKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 0EE4A2605B5
 for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2014 09:19:56 +0100 (CET)
In-Reply-To: <CAM4voam0h4e1Z8q3eqNpgMhhfw-zJpfh7fi4iznX_Y0bj98nKA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Abhilash Kesavan <kesavan.abhilash@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, "padma.v@samsung.com" <padma.v@samsung.com>, Takashi Iwai <tiwai@suse.de>, Will Deacon <Will.Deacon@arm.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Abhilash Kesavan wrote:
> Currently, if I continue to use the SRAM allocation driver, two
> options are working:
> 1) ioremap to ioremap_wc in drivers/misc/sram.c.
> 2) copy_from_user to copy_from_user_toio in sound/core/pcm_lib.c
>
> Which would be the preferred option ?

I don't know how to tell the SRAM allocator to hand out WC memory, but
copy_from_user_toio() is what you would put into your .copy callback.


Regards,
Clemens
