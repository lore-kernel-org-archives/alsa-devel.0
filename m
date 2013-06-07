From: Chen Guangyu-B42378 <B42378@freescale.com>
Subject: Re: [PATCH] ASoC: WM8962: Set CLKREG_OVD if GP5_FN is
 not its reset value
Date: Fri, 7 Jun 2013 16:29:49 +0000
Message-ID: <E31481825E4C03459FC878EE97CB2EFD02FDA1FB@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1370607258-4750-1-git-send-email-b42378@freescale.com>
 <20130607143905.GT31367@sirena.org.uk>
 <E31481825E4C03459FC878EE97CB2EFD02FDA184@039-SN2MPN1-023.039d.mgd.msft.net>,
 <20130607154620.GV31367@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 by alsa0.perex.cz (Postfix) with ESMTP id A356F265756
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 18:30:19 +0200 (CEST)
In-Reply-To: <20130607154620.GV31367@sirena.org.uk>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 07, 2013, Mark Brown wrote:

> The point is that there's more work needed to recover the device state
> here, you're only doing one of the several things that need to be done
> after the device has been restored.

That's because I'm too scared to put too many code into my single patch :(

Sir, I'm so glad you can fix this issue with such a quick response.
I'll test that patch tomorrow moring (midnight here) and give you a feedback.

Thank you so much.
