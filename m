From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v5] ASoC: SSM2602: convert to soc-cache
Date: Tue, 29 Mar 2011 21:27:36 +0100
Message-ID: <1301430456.3402.5.camel@odin>
References: <1301124539-527-2-git-send-email-vapier@gentoo.org>
	<1301260450-6333-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D045E103991
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 22:27:40 +0200 (CEST)
Received: by wyg36 with SMTP id 36so544945wyg.38
	for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2011 13:27:40 -0700 (PDT)
In-Reply-To: <1301260450-6333-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Cliff Cai <cliff.cai@analog.com>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2011-03-27 at 17:14 -0400, Mike Frysinger wrote:
> From: Cliff Cai <cliff.cai@analog.com>
> 
> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
> v5
> 	- use snd_soc_cache_sync
> 
>  sound/soc/codecs/ssm2602.c |  133 ++++++++++++++-----------------------------
>  1 files changed, 43 insertions(+), 90 deletions(-)

Acked-by: Liam Girdwood <lrg@ti.com>
