From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v3 1/3] ASoC: Add initial support for
 multiple CPU DAIs
Date: Mon, 30 Apr 2018 17:22:52 +0100
Message-ID: <20180430162252.mzgfcu5hzah3qftk@localhost.localdomain>
References: <1524131359-24387-1-git-send-email-vinod.koul@intel.com>
 <1524131359-24387-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 66650267412
 for <alsa-devel@alsa-project.org>; Mon, 30 Apr 2018 18:22:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1524131359-24387-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 19, 2018 at 03:19:17PM +0530, Vinod Koul wrote:
> From: Shreyas NC <shreyas.nc@intel.com>
> 
> For usecases where a stream consists of multiple BE CPU DAIs,
> DAI Link should support the same.
> 
> This patch adds initial support for multiple CPU DAIs in ASoC for
> card instantiation, suspend and resume functions.
> 
> This support is added only for BE DAI Links. Support for FE and
> Codec-Codec Links is not added.
> 
> Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
