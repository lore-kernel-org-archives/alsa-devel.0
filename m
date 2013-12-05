From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: fsl: imx-wm8962: Do FLL
 configuration in hw_params() and hw_kree()
Date: Thu, 5 Dec 2013 19:07:28 +0800
Message-ID: <20131205110727.GA14744@MrMyself>
References: <1386176048-6960-1-git-send-email-b42378@freescale.com>
 <20131204190211.GD29268@sirena.org.uk>
 <20131205025630.GG8609@MrMyself>
 <20131205111508.GM29268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C5EC26086E
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2013 12:25:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131205111508.GM29268@sirena.org.uk>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 05, 2013 at 11:15:08AM +0000, Mark Brown wrote:
> On Thu, Dec 05, 2013 at 10:56:31AM +0800, Nicolin Chen wrote:
> 
> > As far as I can understand, the point that all the outputs needs the device
> > to be clocked is undeniably true, but the external MCLK should be sufficient
> > to source the SYSCLK of WM8962. Does the bypass mode also need to set FLL
> > to get an accurate frequency?
> 
> The device is going to need a clock that's in spec to make sure that the
> device performs in spec, if the device is clocked from a 32kHz clock
> (which is quite a common configuration and one that's supported by the
> machine driver since it gets the clock from DT) that's definitely not
> going to be the case and I'd not expect it to work at all sensibly.

Thank you for the explain. I understand now.

Then I think it would be plausible if I could refine this patch to
allow both set_bias_level() and hw_params/free() to control the FLL
while making them not break each other but coexist, right?

Thank you,
Nicolin Chen
