From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ASoC: improve RT5514 dependencies
Date: Tue, 5 Sep 2017 11:03:04 +0200
Message-ID: <CAK8P3a1PgN=XmAuKrFGT50f4otXzRsPqjYM3bjjKU3DgY7wWLg@mail.gmail.com>
References: <20170731083217.4142512-1-arnd@arndb.de>
 <s5hh8xt0xwy.wl-tiwai@suse.de>
 <20170801142117.oc3owynj74g5bmyi@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170801142117.oc3owynj74g5bmyi@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Ryder Lee <ryder.lee@mediatek.com>, Hsin-yu Chao <hychao@google.com>, Xing Zheng <zhengxing@rock-chips.com>, "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, Takashi Iwai <tiwai@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Sugar Zhang <sugar.zhang@rock-chips.com>, Harsha Priya N <harshapriya.n@intel.com>, "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, Naveen M <naveen.m@intel.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Vinod Koul <vinod.koul@intel.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Heiko Stuebner <heiko@sntech.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 1, 2017 at 4:21 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jul 31, 2017 at 11:15:57AM +0200, Takashi Iwai wrote:
>
>> IMO, flipping the dependency looks saner to me.  The SPI function call
>> is a kind of add-on, after all.
>
> Yes, that's definitely the intention of the code.

I just ran into the same problem again on randconfig testing, after
the bug had been
gone before my vacation:

    sound/soc/codecs/rt5514.o: In function `rt5514_dsp_voice_wake_up_put':
    rt5514.c:(.text+0x2068): undefined reference to `rt5514_spi_burst_write'
    rt5514.c:(.text+0x20c8): undefined reference to `rt5514_spi_burst_write'

Is anyone looking into this? My original patch
(https://patchwork.kernel.org/patch/9871255/) still fixes it but needs a
minor change to apply now. When I last looked into changing
the dependency in the code, I couldn't quite figure out how to
do it there.

         Arnd
