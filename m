From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/5] ASoC: wm8960: add support for
 big-endian audio samples
Date: Tue, 18 Sep 2012 22:34:05 -0400
Message-ID: <20120919023404.GC8832@opensource.wolfsonmicro.com>
References: <1347657278-25295-1-git-send-email-timur@freescale.com>
 <1347657278-25295-4-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 95C53265129
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 04:34:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347657278-25295-4-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 14, 2012 at 04:14:37PM -0500, Timur Tabi wrote:
> PowerPC ASoC drivers frequently use the _BE variants of the SNDRV_PCM_FORMAT
> macros, so we need to look for those as well.

Applied but...

> +	snd_pcm_format_t format = params_format(params);
>  	int i;
>  
>  	/* bit size */
> -	switch (params_format(params)) {
> +	switch (format) {

...please don't introduce unrelated changes, especially ones you don't
mention in the changelog.
