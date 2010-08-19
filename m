From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Multi-component: Use a more adequate
 name for the CX20442 codec DAI
Date: Thu, 19 Aug 2010 15:24:22 +0100
Message-ID: <1282227862.3074.457.camel@odin>
References: <201008191515.51877.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DF3324403
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Aug 2010 16:24:22 +0200 (CEST)
Received: by eyd9 with SMTP id 9so1254365eyd.38
	for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2010 07:24:21 -0700 (PDT)
In-Reply-To: <201008191515.51877.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-08-19 at 15:15 +0200, Janusz Krzysztofik wrote:
> In the process of unification of codec DAI names while implementing 
> multi-component, the CX20442 codec DAI has been renamed to "cx20442-hifi". 
> This new name seems not adequate for a 8kHz voice codec.
> 
> Use a better name, "cx20442-voice", as suggested by Liam Girdwood.
> 
> Created against git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git 
> commit 5dcba5d6741d4533e0ef696507f93f2a4c738efb dated 12 Aug 2010.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
