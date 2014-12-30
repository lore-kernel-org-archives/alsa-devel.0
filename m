From: Zidan Wang <b50113@freescale.com>
Subject: Re: [PATCH v4] ASoC: wm8960: Let wm8960 codec driver
 manage its own MCLK
Date: Tue, 30 Dec 2014 10:29:18 +0800
Message-ID: <20141230022917.GA17807@b50113>
References: <1418103916-31295-1-git-send-email-b50113@freescale.com>
 <20141222181045.GH17800@sirena.org.uk>
 <BN3PR0301MB125132692CD535B9AC1795A98D510@BN3PR0301MB1251.namprd03.prod.outlook.com>
 <20141229160514.GQ17800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0146.outbound.protection.outlook.com [157.56.110.146])
 by alsa0.perex.cz (Postfix) with ESMTP id A5AA8260592
 for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2014 03:28:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20141229160514.GQ17800@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "tiwai@suse.de" <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 29, 2014 at 04:05:14PM +0000, Mark Brown wrote:
> On Mon, Dec 29, 2014 at 10:59:08AM +0000, Zidan Wang wrote:
> > Hi Mark,
> 
> Don't top post and please fix your mailer to word wrap within paragraphs
> and avoid corrupting the mail it's quoting.
> 
> > You are right. When PM is disabled, the codec will not work. But there are also some codecs enable mclk in PM, such as wm8962, cs42xx8.
> > And some codecs enable codec mclk in i2c probe(), startup() and set_bias_level(). It makes me confused.	
> > Can you tell me what's the general idiom to enable mclk. Thanks.
> 
> Like I said in the mail to which you replied:
> 
> > > This isn't going to work if PM is disabled (which is still a valid configuration).  The general idiom for this is that the driver should start up with everything powered up then let runtime idle turn things off if they're not required.  That way if runtime PM is disabled then the system will still work as everything will just stay powered on all the time.

I want put mclk enable to set_bias_level. Do you thinks it make sense?
