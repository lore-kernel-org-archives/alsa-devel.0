From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/8] [media] v4l: rcar_fdp1: Change
	platform dependency to ARCH_RENESAS
Date: Mon, 23 Apr 2018 10:08:55 +0200
Message-ID: <CAMuHMdUv6Gb6D0qAnDMRYhS8Uzriv1rALXpuzuMm6ndGk24GNg@mail.gmail.com>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <1524230914-10175-4-git-send-email-geert+renesas@glider.be>
 <3039853.rivznOVBTv@avalon> <1700954.Qkp7xggMnX@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f65.google.com (mail-vk0-f65.google.com
 [209.85.213.65])
 by alsa0.perex.cz (Postfix) with ESMTP id F10C726762E
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 10:08:56 +0200 (CEST)
Received: by mail-vk0-f65.google.com with SMTP id b16so8834396vka.5
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 01:08:56 -0700 (PDT)
In-Reply-To: <1700954.Qkp7xggMnX@avalon>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, driverdevel <devel@driverdev.osuosl.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>, Linux Media Mailing List <linux-media@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-
List-Id: alsa-devel@alsa-project.org

Hi Laurent,

On Sun, Apr 22, 2018 at 10:46 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Saturday, 21 April 2018 11:07:11 EEST Laurent Pinchart wrote:
>> On Friday, 20 April 2018 16:28:29 EEST Geert Uytterhoeven wrote:
>> > The Renesas Fine Display Processor driver is used on Renesas R-Car SoCs
>> > only.  Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce
>> > ARCH_RENESAS") is ARCH_RENESAS a more appropriate platform dependency
>> > than the legacy ARCH_SHMOBILE, hence use the former.
>> >
>> > This will allow to drop ARCH_SHMOBILE on ARM and ARM64 in the near
>> > future.
>> >
>> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>
>> How would you like to get this merged ?
>
> Unless you would like to merge the whole series in one go, I'll take this in
> my tree as I have a conflicting patch I would like to submit for v4.18.

Please take it in your tree, thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
