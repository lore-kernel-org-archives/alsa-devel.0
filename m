From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Add imx6sx platform support
Date: Thu, 3 Apr 2014 11:11:18 +0800
Message-ID: <20140403031116.GA31246@MrMyself>
References: <1396352049-23554-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140402195208.GM14763@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 0967C265535
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 05:26:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140402195208.GM14763@sirena.org.uk>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, timur@tabi.org, Li.Xiubo@freescale.com, rob@landley.net, galak@codeaurora.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 02, 2014 at 08:52:08PM +0100, Mark Brown wrote:
> On Tue, Apr 01, 2014 at 07:34:09PM +0800, Nicolin Chen wrote:
> > The next coming i.MX6 Solo X SoC also contains SAI module while we use
> > imp_pcm_init() for i.MX platform.
> 
> I've applied this, though obviously it'd be better if we had dmaengine
> support for this SoC so that it was just a compatible string update and
> didn't require any code.

Hmm...actually imx_pcm_init() is just a shell calling dmaengine while it
has its own config and flags. So we still need to extinguish these two
elements for them even if using devm_snd_dmaengine_pcm_register() eventually.

But the idea to merge them into one entry should be great for 3rd platform
or even further one. And a patch for imx-pcm-dma and all callers of it
would be needed then.

Thank you,
Nicolin
