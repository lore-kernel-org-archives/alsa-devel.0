From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add driver for rt5631
Date: Wed, 21 Sep 2011 15:55:18 +0100
Message-ID: <20110921145517.GB6245@opensource.wolfsonmicro.com>
References: <1315365395-19945-1-git-send-email-johnnyhsu@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6DD3E2414F
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 16:55:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1315365395-19945-1-git-send-email-johnnyhsu@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: johnnyhsu@realtek.com
Cc: alsa-devel@alsa-project.org, flove@realtek.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 07, 2011 at 11:16:35AM +0800, johnnyhsu@realtek.com wrote:
> From d291cbcdd5c1faebd4c37b4564b33c322df51987 Mon Sep 17 00:00:00 2001
> From: Johnny Hsu <johnnyhsu@realtek.com>
> Date: Wed, 7 Sep 2011 11:05:19 +0800
> Subject: [PATCH] ASoC: Add driver for rt5631

Applied, thanks.  It'd be really helpful if where things aren't clear
you could reply to code reviews - now that it's clear what the index
register stuff is doing I suspect the sysfs stuff would be OK though it
ought to go in debugfs not sysfs.
