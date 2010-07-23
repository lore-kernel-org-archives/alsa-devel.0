From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: multi-component - Fix Core AC97
	set	device name
Date: Fri, 23 Jul 2010 10:08:38 +0100
Message-ID: <20100723090837.GB12006@sirena.org.uk>
References: <1279846231-29820-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C440103818
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jul 2010 11:08:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1279846231-29820-1-git-send-email-sw.youn@samsung.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Seungwhan Youn <claude.youn@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 23, 2010 at 09:50:31AM +0900, Seungwhan Youn wrote:
> AC97 driver needs to make kobject with id which from codec.
> But in multi-component, this id was removed, so this patch
> fix this same as 'sound/pci/ac97/ac97_codec.c'.
> 
> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
