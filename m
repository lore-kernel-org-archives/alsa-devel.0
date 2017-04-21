From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: Re: [PATCH] ASoC: dwc: disallow building
 designware_pcm as a module
Date: Fri, 21 Apr 2017 11:34:00 +0100
Message-ID: <376c5933-9321-5399-74c7-6fd4943fab3d@synopsys.com>
References: <20170418105954.23368-1-lkundrak@v3.sk>
 <20170418151834.c7e5fivmgn73sbwd@sirena.org.uk>
 <1492532010.28092.12.camel@v3.sk>
 <20170418171519.csiftftd434psyn5@sirena.org.uk>
 <2e39b000-bf25-6447-b53b-047401041f4e@synopsys.com>
 <1492618461.28092.18.camel@v3.sk>
 <03a3fbbb-7221-f4ee-5b1b-8fff518ea82c@synopsys.com>
 <20170420194646.qcpu7w3acjyfmeu5@sirena.org.uk>
 <s5h37d2su8h.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.synopsys.com (smtprelay2.synopsys.com
 [198.182.60.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E29A02669BD
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 12:34:08 +0200 (CEST)
In-Reply-To: <s5h37d2su8h.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, Lubomir Rintel <lkundrak@v3.sk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

Hi,


On 20-04-2017 21:24, Takashi Iwai wrote:
> So, I think Lubomir's change is right.  But the patch subject and
> description should be rephrased.
>
> One thing I don't like is the rename of the file.  But in this
> particular case, it's unavoidable unless we rename the module name.
>

Maybe rename to "dwc-i2s.c" and "dwc-pcm.c" (as the folder is
called "dwc") and let the module still be called "designware-i2s"?

> BTW, we should drop the superfluous EXPORT_SYMBOL*(), too.
>
>
>

Lubomir, could you please remove the EXPORT_SYMBOL, change the
commit message and resend?

Best regards,
Jose Miguel Abreu
