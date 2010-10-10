From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [patch] ASoC: checking kzalloc() for IS_ERR()
	instead of NULL
Date: Sun, 10 Oct 2010 14:36:37 +0100
Message-ID: <1286717797.3429.20.camel@odin>
References: <20101009193131.GA5851@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 40E25244C8
	for <alsa-devel@alsa-project.org>;
	Sun, 10 Oct 2010 15:36:42 +0200 (CEST)
Received: by wyb32 with SMTP id 32so1179810wyb.38
	for <alsa-devel@alsa-project.org>; Sun, 10 Oct 2010 06:36:42 -0700 (PDT)
In-Reply-To: <20101009193131.GA5851@bicker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <error27@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, Ian Lartey <ian@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 2010-10-09 at 21:31 +0200, Dan Carpenter wrote:
> There is a typo here that got copy and pasted to several probe
> functions.  kzalloc() returns NULL on allocation failures and not an
> ERR_PTR.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
