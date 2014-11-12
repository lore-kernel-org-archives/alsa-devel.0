From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH 4/4] ASoC: rt5670: add codec irq support
Date: Wed, 12 Nov 2014 11:56:39 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D70102139E@RTITMBSV03.realtek.com.tw>
References: <1415773681-2394-1-git-send-email-bardliao@realtek.com>
 <20141112114613.GF3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id EADA5265684
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 12:56:43 +0100 (CET)
In-Reply-To: <20141112114613.GF3815@sirena.org.uk>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "mengdong.lin@intel.com" <mengdong.lin@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "yao.jin@intel.com" <yao.jin@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, November 12, 2014 7:46 PM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; lars@metafoo.de;
> Flove; Oder Chiou; mengdong.lin@intel.com; yao.jin@intel.com
> Subject: Re: [PATCH 4/4] ASoC: rt5670: add codec irq support
> 
> On Wed, Nov 12, 2014 at 02:28:01PM +0800, bardliao@realtek.com
> wrote:
> > From: Bard Liao <bardliao@realtek.com>
> >
> > This patch provide the jack function of rt5670. We use a irq pin to
> > notice the jack event. rt5670_irq_detection will determine which
> > status should be reported.
> > We can get gpio information from gpio number or gpiod_dev. That's
> why
> > we define both on platform data.
> 
> I'm missing patches 1-3 of this series.

I just resent these patches.

Thanks.

> 
> ------Please consider the environment before printing this e-mail.
