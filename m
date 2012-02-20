From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: io: Retrieve val_bytes from the
	regmap API
Date: Mon, 20 Feb 2012 09:06:22 +0000
Message-ID: <1329728782.3782.3.camel@odin>
References: <1329518062-6693-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75]) by alsa0.perex.cz (Postfix) with SMTP id 8AE13243CC
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 10:06:25 +0100 (CET)
Received: by mail-we0-f177.google.com with SMTP id a10so4633263wer.8
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 01:06:24 -0800 (PST)
In-Reply-To: <1329518062-6693-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Fri, 2012-02-17 at 14:34 -0800, Mark Brown wrote:
> Allow us to build infrastructure which needs to know the size of a value
> without requiring regmap based drivers to supply this information to both
> ASoC and regmap by asking regmap for the value.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>
