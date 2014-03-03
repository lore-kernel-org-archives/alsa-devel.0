From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm{5102, 5110,
	8997}: Replace codec->control_data	with arizona->regmap
Date: Mon, 3 Mar 2014 09:08:13 +0000
Message-ID: <20140303090813.GF8570@opensource.wolfsonmicro.com>
References: <1393677932-17336-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 12739265141
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 10:08:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1393677932-17336-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 01, 2014 at 01:45:32PM +0100, Lars-Peter Clausen wrote:
> With the ongoing component-ization of the ASoC framework and the continuing
> migration to using regmap for IO the control_data field of the snd_soc_codec
> struct will eventually be removed. Prepare the wm5192, wm5110 and wm8997
> drivers for this by using arizona->regmap instead of accessing the CODEC's
> control_data field.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
