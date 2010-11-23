From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv4 17/18] ASoC: Samsung: Generalize Kconfig
	symbols
Date: Tue, 23 Nov 2010 14:12:56 +0000
Message-ID: <20101123141255.GH18960@rakim.wolfsonmicro.main>
References: <1290407690-28917-1-git-send-email-jassisinghbrar@gmail.com>
	<1290407842-29591-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7D3E2103923
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 15:13:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1290407842-29591-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 22, 2010 at 03:37:22PM +0900, Jassi Brar wrote:

>         SND_SOC_SMDK_SPDIF -> ASOC_SAMSUNG_SMDK_SPDIF
>         SND_SOC_SMDK_WM8580 -> ASOC_SAMSUNG_SMDK_WM8580
>         SND_SOC_SMDK_WM9713 -> ASOC_SAMSUNG_SMDK_WM9713
>         SND_SOC_GONI_AQUILA_WM8994 -> ASOC_GONI_AQUILA_WM8994

Hrm.  These ones I'm not entirely happy about - we're pretty
consistently using SND_SOC_ rather than ASOC_ throughout the subsystem
so changing to ASOC_ feels like churn.  Is there any great reason for
the rename?  I don't mind the addition of SAMSUNG_ one way or the other,
it's just the subsystem prefix.

I've applied this just now as the rename patch depends on it.
