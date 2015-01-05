From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 3/7] ASoC: intel: Remove unnecessary
	snd_pcm_lib_preallocate_free_for_all()
Date: Mon, 05 Jan 2015 11:28:40 +0200
Message-ID: <54AA5948.9010108@linux.intel.com>
References: <1420203373-1844-1-git-send-email-lars@metafoo.de>
 <1420203373-1844-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DB432608B4
 for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2015 10:28:44 +0100 (CET)
In-Reply-To: <1420203373-1844-3-git-send-email-lars@metafoo.de>
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
Cc: Manuel Lauss <manuel.lauss@googlemail.com>, alsa-devel@alsa-project.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On 01/02/2015 02:56 PM, Lars-Peter Clausen wrote:
> The ALSA core takes care that all preallocated memory is freed when the PCM
> itself is freed. There is no need to do this manually in the driver.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>   sound/soc/intel/sst-baytrail-pcm.c      | 6 ------
>   sound/soc/intel/sst-haswell-pcm.c       | 6 ------
>   sound/soc/intel/sst-mfld-platform-pcm.c | 7 -------
>   3 files changed, 19 deletions(-)

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
