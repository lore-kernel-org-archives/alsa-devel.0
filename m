From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [patch] ASoC: soc: snprintf() doesn't return
	negative
Date: Mon, 11 Oct 2010 11:07:47 +0100
Message-ID: <1286791667.3306.0.camel@odin>
References: <20101011035416.GD5851@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F38D1038ED
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Oct 2010 12:07:50 +0200 (CEST)
Received: by wwb28 with SMTP id 28so2829904wwb.20
	for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2010 03:07:50 -0700 (PDT)
In-Reply-To: <20101011035416.GD5851@bicker>
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
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-10-11 at 05:54 +0200, Dan Carpenter wrote:
> In user space snprintf() returns negative on errors but the kernel
> version only returns positives.  It could potentially return sizes
> larger than the size of the buffer so we should check for that.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
