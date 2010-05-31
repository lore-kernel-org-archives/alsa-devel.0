From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [patch 0/6] kirkwood openrd client audio support -
 v4
Date: Mon, 31 May 2010 11:15:39 +0100
Message-ID: <1275300939.3174.6.camel@odin>
References: <20100527125737.524554667@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A6CF10385E
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 12:15:45 +0200 (CEST)
Received: by wyb32 with SMTP id 32so303026wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 31 May 2010 03:15:44 -0700 (PDT)
In-Reply-To: <20100527125737.524554667@mandriva.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: apatard@mandriva.com
Cc: alsa-devel@alsa-project.org, nico@fluxnic.net, broonie@opensource.wolfsonmicro.com, saeed@marvell.com, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-05-27 at 14:57 +0200, apatard@mandriva.com wrote:
> Hi,
> 
> This patchset is an other try to get merged openrd audio support mainline.
> The main change is going back to using kirkwood instead of orion, as the 
> only orion having i2s is not merged mainline (if I got it right).
> I've also fixed the lastests comments on the cs42l51 codec patch.
> 
> Arnaud
> 
> Changes :
> - changed back from orion to kirkwood
> - removed cs42l51 adc input register initialisation
> - moved the DAPM event macro to soc-dapm
> - fixed cs42l51_set_dai_fmt() master/slave check
> - removed cs42l51 startup message
> - use snd_soc_update_bits() in cs42l51_pdn_event()

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
