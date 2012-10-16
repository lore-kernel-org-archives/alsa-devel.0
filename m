From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 2/2] ASoC: atmel-ssc: use module_platform_driver macro
Date: Tue, 16 Oct 2012 10:49:47 +0200
Message-ID: <20121016084947.GD12801@game.jcrosoft.org>
References: <1350359819-2461-1-git-send-email-voice.shen@atmel.com>
 <1350359819-2461-2-git-send-email-voice.shen@atmel.com>
 <507D15C2.7000606@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <507D15C2.7000606@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Wolfram Sang <w.sang@pengutronix.de>, linux-sound@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 10:07 Tue 16 Oct     , Nicolas Ferre wrote:
> On 10/16/2012 05:56 AM, Bo Shen :
> > This patch removes some code duplication by using module_platform_driver
> > 
> > Signed-off-by: Bo Shen <voice.shen@atmel.com>
> 
> Very good simplification but...
> 
> > ---
> >  drivers/misc/atmel-ssc.c |   18 ++++--------------
> >  1 file changed, 4 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
> > index 23dcb76..ac00f83 100644
> > --- a/drivers/misc/atmel-ssc.c
> > +++ b/drivers/misc/atmel-ssc.c
> > @@ -68,7 +68,7 @@ void ssc_free(struct ssc_device *ssc)
> >  }
> >  EXPORT_SYMBOL(ssc_free);
> >  
> > -static int __init ssc_probe(struct platform_device *pdev)
> > +static int ssc_probe(struct platform_device *pdev)
> 
> Here you remove the __init altogether, maybe converting to __devinit is
> the proper replacement for this? I do not know myself but if anybody knows?
yes __devinit is mandatory

Best Regards,
J.
