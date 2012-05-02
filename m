From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/2] ASoC: core: Allow DAIs to specify a
	base address
Date: Wed, 02 May 2012 15:06:37 +0100
Message-ID: <1335967597.4722.0.camel@odin>
References: <1335899068-22645-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog122.obsmtp.com (na3sys009aog122.obsmtp.com
	[74.125.149.147])
	by alsa0.perex.cz (Postfix) with ESMTP id C519624150
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2012 16:06:44 +0200 (CEST)
Received: by wibhm17 with SMTP id hm17so3894717wib.0
	for <alsa-devel@alsa-project.org>; Wed, 02 May 2012 07:06:40 -0700 (PDT)
In-Reply-To: <1335899068-22645-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Tue, 2012-05-01 at 20:04 +0100, Mark Brown wrote:
> Devices with many DAIs are becoming more and more common, and generally
> the more modern devices have consistent register layouts between DAIs.
> Rather than have drivers open code lookups based on the DAI ID or cause
> uglification in UI by having register addresses for IDs provide a base
> address field they can use.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Both

Acked-by: Liam Girdwood <lrg@ti.com>
