From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: byt-rt5640: Fix
 snd_soc_dapm_ignore_suspend() calls
Date: Mon, 05 Jan 2015 11:05:23 +0200
Message-ID: <54AA53D3.5030307@linux.intel.com>
References: <1420107825-28506-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 656262608EA
 for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2015 10:07:42 +0100 (CET)
In-Reply-To: <1420107825-28506-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/01/2015 12:23 PM, Lars-Peter Clausen wrote:
> To work properly snd_soc_dapm_ignore_suspend() needs to be called on
> endpoint widgets. In this case those are the board level Speaker and
> Headphone widgets and not the CODEC output widgets that are connected to
> them.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>   sound/soc/intel/byt-rt5640.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)

To both:
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
