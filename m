From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: ad73311: drop I2C requirement
Date: Sat, 26 Mar 2011 14:12:58 +0000
Message-ID: <1301148778.3455.51.camel@odin>
References: <1301128710-3244-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 70F6D103838
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 15:13:02 +0100 (CET)
Received: by wyg36 with SMTP id 36so1279391wyg.38
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 07:13:02 -0700 (PDT)
In-Reply-To: <1301128710-3244-1-git-send-email-vapier@gentoo.org>
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
Cc: Scott Jiang <scott.jiang@analog.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

On Sat, 2011-03-26 at 04:38 -0400, Mike Frysinger wrote:
> From: Scott Jiang <scott.jiang@analog.com>
> 
> The AD73311 codec does not use I2C, so don't require it in Kconfig.
> 
> Signed-off-by: Scott Jiang <scott.jiang@analog.com>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---

Acked-by: Liam Girdwood <lrg@ti.com>
