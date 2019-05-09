From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC : cs4265 : readable register too low
Date: Thu, 9 May 2019 11:45:14 +0100
Message-ID: <20190509104514.GB45394@ediswmail.ad.cirrus.com>
References: <20190508063313.18099-1-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3258EF8073C
 for <alsa-devel@alsa-project.org>; Thu,  9 May 2019 12:45:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190508063313.18099-1-flatmax@flatmax.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 08, 2019 at 04:33:13PM +1000, Matt Flax wrote:
> The cs4265_readable_register function stopped short of the maximum
> register.
> 
> An example bug is taken from :
> https://github.com/Audio-Injector/Ultra/issues/25
> 
> Where alsactl store fails with :
> Cannot read control '2,0,0,C Data Buffer,0': Input/output error
> 
> This patch fixes the bug by setting the cs4265 to have readable
> registers up to the maximum hardware register CS4265_MAX_REGISTER.
> 
> Signed-off-by: Matt Flax <flatmax@flatmax.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
