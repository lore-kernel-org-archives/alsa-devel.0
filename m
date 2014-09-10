From: Qiao Zhou <zhouqiao@marvell.com>
Subject: Re: [PATCH v2] ASoC: soc-pcm: fix dpcm_path_get error
	handling
Date: Wed, 10 Sep 2014 18:38:03 +0800
Message-ID: <54102A0B.60903@marvell.com>
References: <1410342847-19295-1-git-send-email-zhouqiao@marvell.com>
 <1410342847-19295-2-git-send-email-zhouqiao@marvell.com>
 <20140910103333.GS2601@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 129A32625EF
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 12:38:07 +0200 (CEST)
In-Reply-To: <20140910103333.GS2601@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "vinod.koul@intel.com" <vinod.koul@intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 09/10/2014 06:33 PM, Mark Brown wrote:
> On Wed, Sep 10, 2014 at 05:54:07PM +0800, Qiao Zhou wrote:
>> dpcm_path_get may return -ENOMEM when allocating memory for list
>> fails. We should not keep processing path or start up dpcm dai in
>> this case.
>
> Applied, thanks.  Please don't send cover letters for single patches -
> it's just more mail.  If anything needs saying it should either go in
> the changelog or after the ---.
>
Mark,

Thanks for the tips. I'll keep it in mind.

-- 

Best Regards
Qiao
