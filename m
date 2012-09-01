From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH] ASoC: dapm: Ensure bypass paths are
	suspended and resumed
Date: Sat, 1 Sep 2012 15:21:47 +0100
Message-ID: <CABS+qY0tKuq92PUmZ-Op2S_t2DJFRv6OH1JmFis-wyf5uB7sTA@mail.gmail.com>
References: <1346460069-27418-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog109.obsmtp.com (na3sys009aog109.obsmtp.com
 [74.125.149.201])
 by alsa0.perex.cz (Postfix) with ESMTP id D878E26028E
 for <alsa-devel@alsa-project.org>; Sat,  1 Sep 2012 16:21:50 +0200 (CEST)
Received: by lags15 with SMTP id s15so2411188lag.38
 for <alsa-devel@alsa-project.org>; Sat, 01 Sep 2012 07:21:47 -0700 (PDT)
In-Reply-To: <1346460069-27418-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 1 September 2012 01:41, Mark Brown
<broonie@opensource.wolfsonmicro.com>wrote:

> Since bypass paths aren't part of DAPM streams and we may not have any
> DAPM streams there may not be anything that triggers a DAPM sync for
> them. Mark all input and output widgets as dirty and then sync to do so
> at the end of suspend and resume.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>

Acked-by: Liam Girdwood <lrg@ti.com>
