From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: dapm: Fix value setting for
 _ENUM_DOUBLE MUX's second channel
Date: Tue, 30 Aug 2016 09:42:54 +0100
Message-ID: <20160830084254.GX21682@localhost.localdomain>
References: <20160827112801.31010-1-wens@csie.org>
 <20160827112801.31010-3-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 55FFE2669D5
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 10:42:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160827112801.31010-3-wens@csie.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 27, 2016 at 07:27:59PM +0800, Chen-Yu Tsai wrote:
> The value for the second channel in _ENUM_DOUBLE (double channel) MUXs
> is not correctly updated, due to using the wrong bit shift.
> 
> Use the correct bit shift, so both channels toggle together.
> 
> Fixes: 3727b4968453 ("ASoC: dapm: Consolidate MUXs and value MUXs")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
