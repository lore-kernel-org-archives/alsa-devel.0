From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/2] ASoC: wm8960: Let wm8960 driver
 configure its bit clock and frame clock
Date: Tue, 4 Apr 2017 09:55:07 +0100
Message-ID: <20170404085507.GW6986@localhost.localdomain>
References: <1420615905-4078-1-git-send-email-zidan.wang@freescale.com>
 <1420615905-4078-2-git-send-email-zidan.wang@freescale.com>
 <20150114192703.GH3043@sirena.org.uk>
 <20150115133439.GA29323@b50113>
 <CAEnQRZD0LuUiULNrv6RJQsr8ZZE+v2-qNC1Za9vXk5+TtB0dOw@mail.gmail.com>
 <20170403133434.GU6986@localhost.localdomain>
 <CAEnQRZA_BzqY5ywkik0-+dCXj1C7ORzjh3Fnt_AM_e=HnaOKMg@mail.gmail.com>
 <20170403135436.GV6986@localhost.localdomain>
 <CAEnQRZDoiygL+rN1sF3JnTARKWsHzjPp-PB2uK1J3dtHBCsy=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id F39D02668F6
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 10:54:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAEnQRZDoiygL+rN1sF3JnTARKWsHzjPp-PB2uK1J3dtHBCsy=A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, tiwai@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, shengjiu.wang@nxp.com, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, viorel.suman@nxp.com, mihai.serban@nxp.com
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 04, 2017 at 10:55:00AM +0300, Daniel Baluta wrote:
> <Removing Zidan from thread because the address no longer exists>
> 
> On Mon, Apr 3, 2017 at 4:54 PM, Charles Keepax
> <ckeepax@opensource.wolfsonmicro.com> wrote:
> > On Mon, Apr 03, 2017 at 04:39:40PM +0300, Daniel Baluta wrote:
> >> On Mon, Apr 3, 2017 at 4:34 PM, Charles Keepax
> >> <ckeepax@opensource.wolfsonmicro.com> wrote:
> > Is the problem here that the PLL part of the code is making the
> > same assumption as the direct part of the code was, that the bclk
> > should be exact?
> 
> Yes.
> 
> 
> After wm8960_configure_sysclk fails to find a LRCLK, we try to use the
> PLL.
> 
> Anyhow, here we don't even reach to check if the PLL can be used because
> there is no solution for the following system:
> 
> freq_out = sysclk * sysclk_divs[i];
> sysclk = lrclk * dac_divs[j];
> sysclk == bclk * bclk_divs[k]
> 
> 
> Perhaps, we can also try here to relax bitclk computation like we did for when
> sysclk was directly derived from mclk.

Exactly that is what I am saying it looks like the PLL part
of the process still assumes it requires bclk to be an exact
frequency if we relax that, the same way we did for the direct
MCLK then we should be good.

Thanks,
Charles
