From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/7] ASoC: wm8962: remove bitwise
	operations involving	GPIO level value
Date: Tue, 2 Jun 2015 09:41:10 +0100
Message-ID: <20150602084110.GC3449@opensource.wolfsonmicro.com>
References: <1433200031-6748-1-git-send-email-vz@mleia.com>
 <1433200158-6890-6-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1B25926043A
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 10:41:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1433200158-6890-6-git-send-email-vz@mleia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, Takashi Iwai <tiwai@suse.de>, Linus Walleij <linus.walleij@linaro.org>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, linux-gpio@vger.kernel.org, Mark Brown <broonie@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 02, 2015 at 02:09:17AM +0300, Vladimir Zapolskiy wrote:
> The main intention of the change is to remove bitwise operations on
> GPIO level value as a preceding change before updating gpiolib
> callbacks to utilize bool type to represent GPIO level.
> 
> No functional change.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Axel Lin <axel.lin@ingics.com>
> Cc: patches@opensource.wolfsonmicro.com
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
