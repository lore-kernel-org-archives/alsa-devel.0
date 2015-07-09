From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Fix kcontrol widget name
	memory management
Date: Thu, 9 Jul 2015 09:06:12 +0100
Message-ID: <20150709080612.GL16517@opensource.wolfsonmicro.com>
References: <1436385599-12403-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4812F260504
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 10:11:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1436385599-12403-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 08, 2015 at 09:59:59PM +0200, Lars-Peter Clausen wrote:
> The name field of the widget template is only used inside
> snd_soc_dapm_new_control_unlocked() which allocates a copy for the actual
> widget. This means we need to free the name allocated for the template in
> dapm_kcontrol_data_alloc() and not the name of the actual widget in
> dapm_kcontrol_free(). Otherwise we get a double free on the widget name and
> a memory leak on the template name.
> 
> Fixes: 773da9b358bf ("ASoC: dapm: Append "Autodisable" to autodisable widget names")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

Oops, thanks for fixing that up.

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
