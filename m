From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: wm5102: Move driver to use
 SND_SOC_BYTES_TLV
Date: Thu, 19 Nov 2015 14:22:55 +0000
Message-ID: <20151119142255.GG18889@ck-lbox>
References: <1447853952-6414-1-git-send-email-vinod.koul@intel.com>
 <1447853952-6414-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 96AB0266040
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2015 15:38:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1447853952-6414-3-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 18, 2015 at 07:09:11PM +0530, Vinod Koul wrote:
> WM5102 driver was using SND_SOC_BYTES_EXT. Since we want to
> remove this, convert it to use SND_SOC_BYTES_TLV
> 
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Cc: patches@opensource.wolfsonmicro.com
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Looks good to me, I think the TLV byte control stuff has been
merged in tinyalsa now so no problems there.

Thanks,
Charles
