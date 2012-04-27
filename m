From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: dapm: Move CODEC<->CODEC params off
	stack
Date: Fri, 27 Apr 2012 10:02:04 +0100
Message-ID: <1335517324.4150.0.camel@odin>
References: <1335471551-12100-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 7008210BE45
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 11:02:14 +0200 (CEST)
Received: by wibhj13 with SMTP id hj13so314973wib.6
	for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2012 02:02:06 -0700 (PDT)
In-Reply-To: <1335471551-12100-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-04-26 at 21:19 +0100, Mark Brown wrote:
> Reduce our stack consumption by moving the params off the stack, they
> are reasonably large and might be an issue on platforms with small stacks.
> 
> Reported-by: Liam Girdwood <lrg@ti.com>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-dapm.c |   32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)

Acked-by: Liam Girdwood <lrg@ti.com>
