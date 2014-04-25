From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 1/4] ASoC: tlv320dac3: Use
	devm_regulator_bulk_get()
Date: Fri, 25 Apr 2014 08:39:13 +0300
Message-ID: <5359F501.6030800@linux.intel.com>
References: <1398389226-18569-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8213A26534C
 for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2014 07:39:17 +0200 (CEST)
In-Reply-To: <1398389226-18569-1-git-send-email-festevam@gmail.com>
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
>   sound/soc/codecs/tlv320dac33.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
Small typo in patch title: tlv320dac3 instead of tlv320dac33.

-- 
Jarkko
