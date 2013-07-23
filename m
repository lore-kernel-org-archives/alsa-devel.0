From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ASoC: Remove unused dapm_get_snd_card()
 and dapm_get_soc_card()
Date: Tue, 23 Jul 2013 13:49:42 +0100
Message-ID: <1374583782.2475.26.camel@loki>
References: <1374570745-32224-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FA80262626
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 14:49:45 +0200 (CEST)
In-Reply-To: <1374570745-32224-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2013-07-23 at 11:12 +0200, Lars-Peter Clausen wrote:
> These two functions were added two years ago in commit 4805608 ("ASoC: dapm -
> Add methods to retrieve snd_card and soc_card from dapm context.") but have
> remained unused so far. Considering that the dapm context actually has a direct
> pointer to the card the functions also seem to be unnecessary. E.g. the
> expressions 'dapm_get_soc_card(dapm)' and 'dapm->card' yield the same result.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

Peter may have a user for these, but maybe not ?

Liam
