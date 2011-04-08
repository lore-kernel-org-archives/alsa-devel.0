From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Force all DAPM contexts into the
 same bias state
Date: Fri, 08 Apr 2011 18:31:14 +0100
Message-ID: <1302283874.3315.116.camel@odin>
References: <1302223494-27267-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E0F010382C
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Apr 2011 19:31:20 +0200 (CEST)
Received: by wwf26 with SMTP id 26so3601331wwf.20
	for <alsa-devel@alsa-project.org>; Fri, 08 Apr 2011 10:31:19 -0700 (PDT)
In-Reply-To: <1302223494-27267-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, 0001-ASoC-Force-all-DAPM-contexts-into-the-same-bias-stat.patch@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-04-08 at 09:44 +0900, Mark Brown wrote:
> Currently we allow all DAPM contexts to determine their own bias level.
> While this should in general work in most situations and will deliver the
> lowest possible power it causes problems for our integration with the
> card bias level as we're calling the card bias level functions for each
> DAPM context even though they're card wide but don't say which CODEC
> we're calling for. Mitigate against this by forcing everything to be in
> the same state.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>
