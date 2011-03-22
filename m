From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Support !REGULATOR build for sgtl5000
Date: Tue, 22 Mar 2011 18:16:15 +0000
Message-ID: <1300817775.3356.14.camel@odin>
References: <1300796539-18519-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 0AAF124444
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 19:16:19 +0100 (CET)
Received: by wyj26 with SMTP id 26so6701779wyj.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 11:16:19 -0700 (PDT)
In-Reply-To: <1300796539-18519-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Zeng Zhaoming <b32542@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-03-22 at 12:22 +0000, Mark Brown wrote:
> The regulator is optional depending on board design.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/sgtl5000.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@ti.com>
