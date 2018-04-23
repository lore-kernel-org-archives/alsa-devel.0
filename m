From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/8] arm: renesas: Change platform dependency to
 ARCH_RENESAS
Date: Mon, 23 Apr 2018 09:45:07 +0200
Message-ID: <CAMuHMdUt3ExAD7KEiBhntcOoSWSLMnpNT1Oix4tNRMAM=8g9jQ@mail.gmail.com>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <20180420164811.GC22369@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180420164811.GC22369@sirena.org.uk>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Mark Brown <broonie@kernel.org>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, driverdevel <devel@driverdev.osuosl.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>, Linux Media Mailing List <linux-media@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@verge.net.au>, Dan Williams <dan.j.williams@intel.com>, Jaroslav Kysela <perex@perex.cz>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takas
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Fri, Apr 20, 2018 at 6:48 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Apr 20, 2018 at 03:28:26PM +0200, Geert Uytterhoeven wrote:
>> The first 6 patches can be applied independently by subsystem
>> maintainers.
>> The last two patches depend on the first 6 patches, and are thus marked
>> RFC.
>
> Would it not make sense to try to apply everything en masse rather than
> delaying?  I'm happy to apply the subsystem stuff but if it gets things
> done quicker or more efficiently I'm also happy to have the lot merged
> as one series.

In theory, yes.

However, this touches multiple subsystems, and it's non-critical, so I don't
want to spent the energy to get this done in a synchronized way.
It's way easier to postpone the last (RFC) patches when everything else
has been applied by subsystem maintainers.

So please apply your part, thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
