From: Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH 4/5] ASoC: max98088: Add master clock
	handling
Date: Wed, 26 Sep 2018 14:30:09 +0200
Message-ID: <20180926123009.yvwiupg56eu4llbb@pengutronix.de>
References: <20180925142352.24106-1-m.felsch@pengutronix.de>
 <20180925142352.24106-5-m.felsch@pengutronix.de>
 <20180925171742.GR20825@sirena.org.uk>
 <20180926100030.tzn6hx6qqbjseopw@pengutronix.de>
 <20180926122249.GV20825@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AC732678BA
 for <alsa-devel@alsa-project.org>; Wed, 26 Sep 2018 14:30:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180926122249.GV20825@sirena.org.uk>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, robh+dt@kernel.org, kernel@pengutronix.de, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Tushar Behera <tushar.behera@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 18-09-26 13:22, Mark Brown wrote:
> On Wed, Sep 26, 2018 at 12:00:30PM +0200, Marco Felsch wrote:
> 
> > One question, should it optional or not? If not I will fix it to return
> > the clk_get error else I will drop it. It shouldn't be optional In my
> > point of view, since it is needed by the chip.
> 
> Optional seems safer, requiring the clock isn't going to work so well on
> ACPI systems.

Okay, I will integrate it in my v2.
