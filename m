From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: SAMSUNG: Match spdif
	source	clock id and asoc platform device
Date: Fri, 3 Dec 2010 11:44:17 +0000
Message-ID: <20101203114416.GG3182@sirena.org.uk>
References: <1291368453-30905-1-git-send-email-sw.youn@samsung.com>
	<1291369067-31429-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9AE9A24418
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 12:44:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291369067-31429-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <sw.youn@samsung.com>
Cc: alsa-devel@alsa-project.org, jassi.brar@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 03, 2010 at 06:37:47PM +0900, Seungwhan Youn wrote:
> This patch modify to match ids between source clock id and asoc platform
> device that spdif driver can find sclk_audio0 with device id.

Something's seriously wrong if you need to do this...

> -	smdk_snd_spdif_device = platform_device_alloc("soc-audio", -1);
> +	smdk_snd_spdif_device = platform_device_alloc("soc-audio", 0);

...the soc-audio device is a virtual device so should have no clocks
associated with it.  The driver should not be using the platform device
as an argument for clk_get() in the first place.
