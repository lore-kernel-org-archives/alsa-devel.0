From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dapm: Fix NULL pointer dereference
 when registering card with widgets
Date: Fri, 03 Oct 2014 15:26:24 +0200
Message-ID: <542EA400.30800@metafoo.de>
References: <1412339560-18019-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-027.synserver.de (smtp-out-027.synserver.de
 [212.40.185.27])
 by alsa0.perex.cz (Postfix) with ESMTP id EAD2726046D
 for <alsa-devel@alsa-project.org>; Fri,  3 Oct 2014 15:26:08 +0200 (CEST)
In-Reply-To: <1412339560-18019-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 10/03/2014 02:32 PM, Jarkko Nikula wrote:
> Commit 0bd2ac3dae74 ("ASoC: Remove CODEC pointer from snd_soc_dapm_context")
> introduced regression to snd_soc_dapm_new_controls() when registering a card
> with card->dapm_widgets set. Call chain is:
>
>      snd_soc_register_card()
>      -> snd_soc_instantiate_card()
>         -> snd_soc_dapm_new_controls()
>            -> snd_soc_dapm_new_control()
>
> Null pointer dereference occurs since card->dapm context doesn't have
> associated component. Fix this by setting widget codec pointer
> conditionally.
>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Thanks. Stupid mistake.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
