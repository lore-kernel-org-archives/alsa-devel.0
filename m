From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: sgtl5000: enable VAG_POWER for
 LINE_IN
Date: Wed, 1 Aug 2012 10:46:33 +0800
Message-ID: <20120801024630.GA30492@shlinux2.ap.freescale.net>
References: <1343387922-25227-1-git-send-email-b29396@freescale.com>
 <20120728143957.GJ2128@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20120728143957.GJ2128@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 28, 2012 at 10:39:59PM +0800, Shawn Guo wrote:
> On Fri, Jul 27, 2012 at 07:18:42PM +0800, Dong Aisheng wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> > 
> > LINE_IN also needs VAG_POWER on or we may hear noise when directly
> > route LINE_IN to Headphone Mux.
> 
> The following is what I see from sgtl5000 data sheet about VAG_POWER.
> 
>   VAG is the internal voltage reference for the ADC and DAC.
> 
> Are you seeing any info that requires VAG_POWER in route of LINE_IN to
> Headphone Mux?  Or it's only a result from your testing?
> 
No, it's from the test result.
Maybe i should have added a FIXME for this.

> Does it also fix the noise issue you mentioned with normal recording
> (LINE_IN to ADC) before?
> 
ADC also needs VAG power which already fixed by:
commit f0cdcf3 (ASoC: sgtl5000: Enable VAG when DAC/ADC up)
This patch is only for direct LINE_IN to Headphone Mux.

Regards
Dong Aisheng
