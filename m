From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v5 2/3] ASoC: Add multiple CPU DAI support
	for PCM ops
Date: Wed, 23 May 2018 10:22:48 +0100
Message-ID: <20180523092248.GB20410@imbe.wolfsonmicro.main>
References: <1526985623-2606-1-git-send-email-shreyas.nc@intel.com>
 <1526985623-2606-3-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 692C3266F88
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 11:23:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1526985623-2606-3-git-send-email-shreyas.nc@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shreyas NC <shreyas.nc@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Vinod Koul <vkoul@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 22, 2018 at 04:10:22PM +0530, Shreyas NC wrote:
> Add support in PCM operations to invoke multiple cpu dais as we do
> for multiple codec dais. Also the symmetry calculations are updated to
> reflect multiple cpu dais.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
> ---

For the non-DPCM parts:

Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
