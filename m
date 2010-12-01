From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix build failure in soc-core.c
Date: Wed, 01 Dec 2010 09:50:48 +0000
Message-ID: <1291197048.3292.2.camel@odin>
References: <20101201113138.f6146790.sfr@canb.auug.org.au>
	<1291187447-1247-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 55AE41039C9
	for <alsa-devel@alsa-project.org>; Wed,  1 Dec 2010 10:50:54 +0100 (CET)
Received: by wwi18 with SMTP id 18so800536wwi.2
	for <alsa-devel@alsa-project.org>; Wed, 01 Dec 2010 01:50:54 -0800 (PST)
In-Reply-To: <1291187447-1247-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-next@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-12-01 at 09:10 +0200, Jarkko Nikula wrote:
> Commit 2eea392 "ASoC: Add support for optional auxiliary dailess codecs"
> causes a build failure in soc-core.c: soc_probe_aux_dev since code tries to
> access non-existing struct snd_soc_dapm_context and struct snd_soc_card
> members.
> 
> Root cause for this was a double accident. Author sent the RFC patch from
> top of another patch set and the RFC got committed. Fix the build failure
> by removing the code line that depends on that another patch set.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
