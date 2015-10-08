From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] ASoC: rt5645: Remove __initdata annotation
 from dmi_platform_intel_broadwell
Date: Thu, 08 Oct 2015 17:29:00 +0300
Message-ID: <56167DAC.1040701@linux.intel.com>
References: <1444314182-10301-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 71D222666B9
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2015 16:29:04 +0200 (CEST)
In-Reply-To: <1444314182-10301-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 10/08/2015 05:23 PM, Jarkko Nikula wrote:
> Fix the "Section mismatch" warning when this driver is built as module by
> removing the __initdata annotation from dmi_platform_intel_broadwell[].
>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>   sound/soc/codecs/rt5645.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
Please ignore this. I noticed just after sending this that list had 
already a patch for this.

-- 
Jarkko
