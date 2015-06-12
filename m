From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: wm8960: support
	configure	headphone jack detect pin and polarity from device tree
Date: Fri, 12 Jun 2015 13:50:05 +0100
Message-ID: <20150612125005.GI32730@opensource.wolfsonmicro.com>
References: <cover.1434020423.git.zidan.wang@freescale.com>
 <a9b871099c39cd0ef48e2b85ef93294e97ef8c70.1434020423.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9FFA526682C
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 14:50:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <a9b871099c39cd0ef48e2b85ef93294e97ef8c70.1434020423.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 11, 2015 at 07:14:34PM +0800, Zidan Wang wrote:
> The ADCLRC/GPIO1, LINPUT3/JD2 and RINPUT3/JD3 pins can be selected as
> headphone jack detect inputs to automatically disable the speaker output
> and enable the headphone.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> ---

This feels like this is missing some iteraction with DAPM, there
are DAPM widgets that represent both the Speaker and the
Headphone, in the case this feature is in use the power state
DAPM shows may no longer accurately reflects the actual power
state of the device.

That said I have no idea if the registers update on the chip to
reflect this change (my guess is that they don't). I am not
really sure what the correct way to handle this sort of hardware
output switching would be in DAPM.

Thanks,
Charles
