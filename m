From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [patch] ASoC: sgtl5000: use after free in
 ldo_regulator_register()
Date: Tue, 08 Mar 2011 18:00:14 +0000
Message-ID: <1299607214.3374.11.camel@odin>
References: <20110308113924.GC3416@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C4446103976
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2011 19:00:18 +0100 (CET)
Received: by wwj40 with SMTP id 40so1127394wwj.20
	for <alsa-devel@alsa-project.org>; Tue, 08 Mar 2011 10:00:18 -0800 (PST)
In-Reply-To: <20110308113924.GC3416@bicker>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, Zeng Zhaoming <b32542@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-03-08 at 14:39 +0300, Dan Carpenter wrote:
> The "ldo" variable was dereferenced after free on the error path.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Acked-by: Liam Girdwood <lrg@ti.com>
