From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] arizona: anc: Correct setting of
	FCx_MIC_MODE_SEL
Date: Mon, 14 Aug 2017 15:47:05 +0100
Message-ID: <20170814144705.og6evab2dftqz3jf@localhost.localdomain>
References: <20170814144557.6875-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 77BEE26737E
 for <alsa-devel@alsa-project.org>; Mon, 14 Aug 2017 16:47:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170814144557.6875-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, sapthagiri.baratam@incubesol.com
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 14, 2017 at 03:45:57PM +0100, Charles Keepax wrote:
> From: Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>
> 
> The mask rather than the shift is accidentally passed to the
> SOC_ENUM_SINGLE macro which results in the wrong bits being set for this
> control, change to using the shift to correct this.
> 
> Signed-off-by: Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---

Apologies ignore this version CCed Giri's old email address.

Thanks,
Charles
