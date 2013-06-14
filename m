From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: WM8962: Enable start-up and normal
 bias after reset in runtime resume
Date: Fri, 14 Jun 2013 19:36:01 +0800
Message-ID: <20130614113600.GA12103@MrMyself>
References: <1371199940-29803-1-git-send-email-b42378@freescale.com>
 <20130614095917.GG1403@sirena.org.uk>
 <20130614100838.GC9206@MrMyself>
 <20130614105118.GI1403@sirena.org.uk>
 <20130614110742.GD9206@MrMyself>
 <20130614112110.GL1403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 by alsa0.perex.cz (Postfix) with ESMTP id 41A552652F6
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 13:44:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130614112110.GL1403@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 14, 2013 at 12:21:10PM +0100, Mark Brown wrote:
> If the DC servo is timing out that'll be a problem with the clocking...
> the FLL is partially analogue so if you're using the FLL that makes
> sense.  Looking at the code we're also bringing the bias down in the
> suspend path so it needs to be powered up in the resume path for
> symmetry if nothing else.

Thank you for helping me understand the case. And just sent the v2.

Hope you can apply it.
Nicolin Chen
