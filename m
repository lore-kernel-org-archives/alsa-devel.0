From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ALSA: ASoC: Fix comment in cs4270 codec
 driver
Date: Wed, 25 May 2011 10:55:20 +0100
Message-ID: <4DDCD208.8050802@ti.com>
References: <1306309992-3624-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BCA4103824
	for <alsa-devel@alsa-project.org>;
	Wed, 25 May 2011 11:55:24 +0200 (CEST)
In-Reply-To: <1306309992-3624-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 25/05/11 08:53, Daniel Mack wrote:
> The comment does not reflect reality anymore since the multi-component
> monster patch landed. Things are matched by names now, and not by
> exporting and referencing a struct. Fix it to avoid confusion.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> ---
>  sound/soc/codecs/cs4270.c |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@ti.com>
