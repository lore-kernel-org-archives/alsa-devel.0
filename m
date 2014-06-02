From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: Failed to set cache compression type
Date: Mon, 02 Jun 2014 17:02:50 +0300
Message-ID: <538C840A.2000307@linux.intel.com>
References: <CAOMZO5Cj=qrrH_nWhCM4-63GPqfgpL1k=Q53z8cDDk3_TpUzBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E0DA32652E7
 for <alsa-devel@alsa-project.org>; Mon,  2 Jun 2014 16:03:21 +0200 (CEST)
In-Reply-To: <CAOMZO5Cj=qrrH_nWhCM4-63GPqfgpL1k=Q53z8cDDk3_TpUzBA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

On 06/02/2014 04:43 PM, Fabio Estevam wrote:
> Hi,
>
> I am booting linux-next 20140602 on a mx6qsabresd and I get the following probe
> error:
>
> wm8962 0-001a: customer id 0 revision D
> wm8962 0-001a: ASoC: Failed to set cache compression type: -22
> imx-wm8962 sound: snd_soc_register_card failed (-22)
> imx-wm8962: probe of sound failed with error -22
>
> What is the proper way to fix it?
>
I was looking at this too and it was introduced by the commit 
b59dce53ef61 ("ASoC: cache: Fix possible ZERO_SIZE_PTR pointer 
dereferencing error.").

If I understood commit 657254714ad2 ("ASoC: io: Remove support for ASoC 
cache in conjunction with regmap") right should we remove remaining 
soc-cache use? All codec drivers seems to include regmap.h although some 
of them are still calling soc_cache_sync().

-- 
Jarkko
