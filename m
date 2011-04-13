From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Create card DAPM widgets early so
 they can be used in callbacks
Date: Wed, 13 Apr 2011 08:44:11 +0100
Message-ID: <1302680651.3600.16.camel@odin>
References: <1302656242-12832-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B99BE103963
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Apr 2011 09:44:14 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 36so287750wyg.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2011 00:44:14 -0700 (PDT)
In-Reply-To: <1302656242-12832-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-04-12 at 17:57 -0700, Mark Brown wrote:
> This helps with things like setting up the initial state.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-core.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@ti.com>
