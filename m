From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: WM5102 - Help to make baytrail machine driver work
Date: Thu, 5 May 2016 10:11:22 +0100
Message-ID: <20160505091122.GE1646@localhost.localdomain>
References: <CAJcYhpZU-6_AO_Gye1VttuvOP0Z2=wLuWGCOP7tBWc6DsuLU1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 048A1265D05
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2016 11:11:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAJcYhpZU-6_AO_Gye1VttuvOP0Z2=wLuWGCOP7tBWc6DsuLU1g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paulo Sergio <pstglia@gmail.com>
Cc: alsa-devel@alsa-project.org, Christian Hartmann <cornogle@googlemail.com>, vinod.koul@intel.com, broonie@opensource.wolfsonmicro.com, pierre-louis.bossart@linux.intel.com, mika.westerberg@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, May 04, 2016 at 10:21:21PM -0300, Paulo Sergio wrote:
> Hi list,
> 
> I've been trying to make Lenovo Yoga 2 (Model 1051F) sound work on
> Android-x86/ Linux. [1]
> 
> Based on already discussed info from Christian Hartmann with members (see
> [2] and [3] ) of this list and some efforts (basically patch pxa2xx with
> Mika Westerberg changes, set the correct gpio int values {246 for reset /
> 405 for ldoena and 342 for irq_gpio} and set LDO1 vcc suppliers) we could
> have wm5102 initialized through spi / regmap (arizona code on drivers/mfd)
> and register the DAI's.
> 
> I also ported a machine driver code from a kernel Lenovo made available for
> a similar hardware (Lenovo yoga 2 1050 - uses the same baytrail Z3745 and
> wolfson wm5102 audio) [4]
> 
> Although machine driver is registered, we still don't have sound. Tried
> some mixer settings / routes used on raspberry pi, but none help.
> Application (in this case alsa / Android players) returns a "Device or
> resource busy" when trying to ioctl pcm device:

A quick look through your machine driver looks like the parts
relating the CODEC look ok.

I am not so sure about the AP side routing but for the CODEC,

'HPOUT1L Input 1' AIF1RX1
'HPOUT1R Input 1' AIF1RX2
'HPOUT1 Digital Switch' 1

Should be enough to route some audio out the headphones, assuming
AIF1 is connected to the AP and HPOUT1L is the headphones (it is
very rare for people to not wire things up that way so its quite
a good bet, and your machine driver suggests this is how it is
connected).

If you provide some kernel logs with the LOG_DEVICE in
drivers/base/regmap/regmap.c set to the CODEC spi device, I am
happy to sanity check what is going to the CODEC. Although at the
moment I think your issue looks mostly like getting through the
AP side.

Thanks,
Charles
