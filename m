From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH 2/3] ASoC: rt298: clear IRQ at the
	beginning of rt298_irq
Date: Wed, 24 Feb 2016 02:59:23 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D701119238@RTITMBSV03.realtek.com.tw>
References: <1455613956-14287-1-git-send-email-bardliao@realtek.com>
 <1455613956-14287-2-git-send-email-bardliao@realtek.com>
 <20160217132011.GQ7544@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 51FB82606A9
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 03:59:31 +0100 (CET)
In-Reply-To: <20160217132011.GQ7544@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "ramesh.babu@intel.com" <ramesh.babu@intel.com>, John Lin <john.lin@realtek.com>, "senthilnathanx.veppur@intel.com" <senthilnathanx.veppur@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, February 17, 2016 9:20 PM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org;
> lars@metafoo.de; Flove; Oder Chiou; John Lin; ramesh.babu@intel.com;
> senthilnathanx.veppur@intel.com
> Subject: Re: [PATCH 2/3] ASoC: rt298: clear IRQ at the beginning of
> rt298_irq
> 
> On Tue, Feb 16, 2016 at 05:12:35PM +0800, Bard Liao wrote:
> 
> > The IRQ pin will go from high to low when the irq bit is clear.
> > To let the IRQ pin go low as early as possible, move the clear irq bit
> > function to the beginning of irq handler.
> 
> Why is this a benefit?  We're going to mask the interrupt as long as the
> interrupt handler is running anyway.

Thanks for your reminding. There is actually no benefit on the patch.
Can you ignore this patch and apply other two patches?
Or I should send the patches again?

> 
> ------Please consider the environment before printing this e-mail.
