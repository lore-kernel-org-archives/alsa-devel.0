From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: wm9705: Convert to regmap
Date: Fri, 21 Oct 2016 13:52:30 +0100
Message-ID: <20161021125230.GN3207@localhost.localdomain>
References: <1477038428-4480-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D4D12671D3
 for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2016 14:52:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1477038428-4480-1-git-send-email-lars@metafoo.de>
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

On Fri, Oct 21, 2016 at 10:27:07AM +0200, Lars-Peter Clausen wrote:
> Currently the wm9712 driver still uses custom snd_soc_codec_driver IO
> callbacks. This has been deprecated for a while, so convert the wm9705
> driver to use regmap for its IO.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> Untested, but same changes as for all the other AC97 drivers, so hopefully
> it will just work.
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
