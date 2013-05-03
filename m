From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH 1/1] ALSA: atmel: Remove redundant
 platform_set_drvdata()
Date: Fri, 3 May 2013 09:13:47 +0200
Message-ID: <20130503071347.GA4109@samfundet.no>
References: <1367564188-14674-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassarossa.samfundet.no (cassarossa.samfundet.no [193.35.52.29])
 by alsa0.perex.cz (Postfix) with ESMTP id 02CCA261654
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2013 09:13:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1367564188-14674-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, nicolas.ferre@atmel.com
List-Id: alsa-devel@alsa-project.org

Around Fri 03 May 2013 12:26:28 +0530 or thereabout, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Thanks

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  sound/atmel/abdac.c |    2 --
>  sound/atmel/ac97c.c |    2 --
>  2 files changed, 4 deletions(-)

<snipp diff>

-- 
HcE
