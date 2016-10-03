From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: wm9712: Remove
	ac97_read/ac97_write wrappers
Date: Mon, 3 Oct 2016 09:59:12 +0100
Message-ID: <20161003085912.GB1952@localhost.localdomain>
References: <1475256450-30612-1-git-send-email-lars@metafoo.de>
 <1475256450-30612-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FD7F266802
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2016 10:58:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1475256450-30612-2-git-send-email-lars@metafoo.de>
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
Cc: Marek Vasut <marex@denx.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 30, 2016 at 07:27:30PM +0200, Lars-Peter Clausen wrote:
> Since the regmap conversion ac97_read/ac97_write are just simple wrappers
> around snd_soc_read/snd_soc_write. Use those instead directly and remove
> the wrappers. Also use snd_soc_update_bits() were appropriate.
> 
> Tested-by: Marek Vasut <marex@denx.de>
> Acked-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
