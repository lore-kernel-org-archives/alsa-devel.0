From: Liam Girdwood <lrg@kernel.org>
Subject: Re: [PATCH] regulator: Make core more chatty about
 some errors
Date: Fri, 22 Jul 2011 11:47:21 +0100
Message-ID: <1311331647.3312.8.camel@odin>
References: <1310437237-16459-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D47D41037EC
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jul 2011 12:47:34 +0200 (CEST)
Received: by wyh21 with SMTP id 21so1526941wyh.38
	for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2011 03:47:34 -0700 (PDT)
In-Reply-To: <1310437237-16459-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-07-12 at 11:20 +0900, Mark Brown wrote:
> Prevent some head scratching by making the core log about some rare but
> possible errors with invalid voltage ranges and modes being set.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  drivers/regulator/core.c |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)
> 

Applied.

Thanks

Liam
