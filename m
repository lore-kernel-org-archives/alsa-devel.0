From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Multi-component - Fix tlv320aic23
 hw_write/hw_read functions
Date: Thu, 01 Jul 2010 07:46:30 +0100
Message-ID: <1277966790.12813.84.camel@vega>
References: <4C27C0BB.5020600@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EE94103866
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Jul 2010 08:46:36 +0200 (CEST)
Received: by mail-fx0-f51.google.com with SMTP id 15so941714fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 30 Jun 2010 23:46:36 -0700 (PDT)
In-Reply-To: <4C27C0BB.5020600@bluewatersys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-06-28 at 09:20 +1200, Ryan Mallon wrote:
> Commit 5ce5888769c4a453bb5a852e156ab4ac72822c40 removed the
> initialisations of the codec->hw_write/read functions for the
> tlv320aic23. Fix this by adding the initialisations in tlv320aic23_probe.
> 
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> ---

Thanks, will apply soon.

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
