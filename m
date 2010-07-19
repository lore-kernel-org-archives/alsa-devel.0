From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2]ASoC: multi-component - Fix S5P	compile
	error
Date: Mon, 19 Jul 2010 14:04:40 +0100
Message-ID: <20100719130439.GB7002@sirena.org.uk>
References: <4C4448FD.5010600@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E58F224479
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 15:04:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C4448FD.5010600@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 19, 2010 at 09:45:49PM +0900, Chanwoo Choi wrote:
> This patch fix compile error on using I2S and WM8994 common code.

This looks to be two completely separate issues and should have been
sent as two separate patches, especially this one:

> -#if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413)
> +#if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413) \
> +	|| defined(CONFIG_CPU_S5PV210)
>  #define S3C_IIS_V2_SUPPORTED

This is implmenting support for a new CPU, not fixing compile errors,
and so the commit message is very misleading.
