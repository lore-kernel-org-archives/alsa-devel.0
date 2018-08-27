From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/3] ASoC: cs4265: SOC_SINGLE register
	value error fix
Date: Mon, 27 Aug 2018 09:30:32 +0100
Message-ID: <20180827083032.GV32322@imbe.wolfsonmicro.main>
References: <20180826225844.13754-1-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id A9753267849
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2018 10:30:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180826225844.13754-1-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 27, 2018 at 08:58:42AM +1000, Matt Flax wrote:
> The cs4265 driver declares the "MMTLR Data Switch" register setting with
> a 0 register value rather then the 0x12 register (CS4265_SPDIF_CTL2).
> This incorrect value causes alsamixer to fault with the output :
> cannot load mixer controls: Input/output error
> 
> This patch corrects the register value. alsamixer now runs.
> 
> Signed-off-by: Matt Flax <flatmax@flatmax.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
