From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 1/3] ASoC: Intel: sst: Simplify
 is_byt_cr()
Date: Wed, 2 Jan 2019 14:44:33 -0600
Message-ID: <17ff00a4-efcf-56b8-33bc-e2b20df787f3@linux.intel.com>
References: <20190102193904.50123-1-stephan@gerhold.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 4104D26782E
 for <alsa-devel@alsa-project.org>; Wed,  2 Jan 2019 21:44:35 +0100 (CET)
In-Reply-To: <20190102193904.50123-1-stephan@gerhold.net>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephan Gerhold <stephan@gerhold.net>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


On 1/2/19 1:39 PM, Stephan Gerhold wrote:
> is_byt_cr() and its usage can be simplified by returning the bool
> directly, instead of through a pointer. This works because the
> return value is just treated as bytcr = false and is not used
> otherwise.
>
> This patch also removes the extra check of
> IS_ENABLED(CONFIG_IOSF_MBI) in favor of checking
> iosf_mbi_available() directly. The header already takes care
> of returning false if the config option is not enabled.
>
> No functional change.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Nice cleanup!

All 3 patches

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The next step will be to move this helper to a common library at some 
point, we'll need it for SOF as well.
