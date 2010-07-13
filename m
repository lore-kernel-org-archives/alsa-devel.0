From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/6 v3] ASoC: fsi: modify format area
 definition on flags
Date: Tue, 13 Jul 2010 11:50:38 +0100
Message-ID: <1279018238.3125.43.camel@odin>
References: <w3ppqyrkamp.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 221BE24420
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jul 2010 12:50:42 +0200 (CEST)
Received: by wwe15 with SMTP id 15so3691817wwe.2
	for <alsa-devel@alsa-project.org>; Tue, 13 Jul 2010 03:50:41 -0700 (PDT)
In-Reply-To: <w3ppqyrkamp.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-07-13 at 18:13 +0900, Kuninori Morimoto wrote:
> There is no necessity that each bit in this area has the meaning.
> This patch modify it to sequence number
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v2 -> v3
> 
> o don't use << 0 shift
> 
> 2/6 - 6/6 doesn't depend on 1/6 patch
> 

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
