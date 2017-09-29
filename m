From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v3] ASoC: dapm: Avoid creating kcontrol for
	params
Date: Fri, 29 Sep 2017 10:09:38 +0100
Message-ID: <20170929090938.7hiem3daebiaodqh@localhost.localdomain>
References: <1506660759-61727-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 26ED12668F0
 for <alsa-devel@alsa-project.org>; Fri, 29 Sep 2017 11:09:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1506660759-61727-1-git-send-email-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yesanishhere@gmail.com
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 28, 2017 at 09:52:39PM -0700, yesanishhere@gmail.com wrote:
> From: anish kumar <yesanishhere@gmail.com>
> 
> Currently in codec to codec dai link if there are multiple
> params defined then dapm can use created kcontrol to
> decide which param to apply at runtime.
> 
> However, in case there is only single param configuration
> then there is no point in creating the kcontrol and also there
> is no point in allocating memory for kcontrol.
> 
> In the snd_soc_dapm_new_pcm function, there is memory
> allocation happening for kcontrol which is later used
> or not used based on num_param. It is better to not
> allocate memory when there is only a single configuration.
> This change is to remedy that anomaly.
> 
> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
