From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/9] ASoC: add Blackfin build options to
	Kconfig and Makefile of sound soc framework
Date: Fri, 5 Sep 2008 13:38:21 +0100
Message-ID: <20080905123820.GF12383@sirena.org.uk>
References: <1220610102-7716-1-git-send-email-cooloney@kernel.org>
	<1220610102-7716-2-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A90AC245F2
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 14:38:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1220610102-7716-2-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>
Cc: Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 05, 2008 at 06:21:34PM +0800, Bryan Wu wrote:

>  source "sound/soc/davinci/Kconfig"
>  source "sound/soc/omap/Kconfig"
> -
> +source "sound/soc/blackfin/Kconfig"
>  # Supported codecs
>  source "sound/soc/codecs/Kconfig"

Please don't remove the blank line here.  I'll fix this up locally.
Other than that

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
