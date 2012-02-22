From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: pandora: switch clock back to internal on stop
Date: Wed, 22 Feb 2012 09:54:00 +0200
Message-ID: <4F449F18.4060107@bitmer.com>
References: <1329604795-24509-1-git-send-email-notasas@gmail.com> <20120219063005.GA4517@opensource.wolfsonmicro.com> <CANOLnOO=UMKJ1CKXKzP5LC_rttxWYRo2yMe9M7PtSL7eV1+GxA@mail.gmail.com> <4F4217EC.7080806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4F4217EC.7080806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, linux-omap@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 02/20/2012 11:52 AM, Peter Ujfalusi wrote:
> I have patch on top of the mcbsp merge series which allows users
> (developers) to switch between McBSP2 master/slave configuration on
> Beagle. It will have two PCM:
> 0 is the current configuration (twl4030 master, mcbsp2 slave)
> 1 is the same as with pandora (twl4030 slave, mcbsp2 master - CLKS pin
> is the source for the SRG).
> 
Side note: Don't forget the FCLK as a SRG source for McBSP master case.
It's quite useful when bringing up and testing new hw.

-- 
jarkko
