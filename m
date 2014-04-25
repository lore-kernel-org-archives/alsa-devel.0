From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 2/4] ASoC: tlv320dac3: Use
	devm_regulator_bulk_get()
Date: Fri, 25 Apr 2014 08:39:20 +0300
Message-ID: <5359F508.3050608@linux.intel.com>
References: <1398389226-18569-1-git-send-email-festevam@gmail.com>
 <1398389226-18569-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E0A4265351
 for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2014 07:39:24 +0200 (CEST)
In-Reply-To: <1398389226-18569-2-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/25/2014 04:27 AM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Using devm_regulator_bulk_get() can make the code cleaner and smaller as we
> do not need to call regulator_bulk_free() in the error and remove paths.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>   sound/soc/codecs/c.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
> index 763b265..5ada616 100644
> --- a/sound/soc/codecs/wm8731.c
> +++ b/sound/soc/codecs/wm8731.c
>
Patch title, c.c (?) and wm8731.c doesn't match.

-- 
Jarkko
