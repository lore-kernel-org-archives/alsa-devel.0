From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2] ASoC: STA32x: filter coefficients,
	bug fix
Date: Thu, 14 Jul 2011 00:25:04 +0900
Message-ID: <20110713152502.GB8889@opensource.wolfsonmicro.com>
References: <1310396484-23371-1-git-send-email-js@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 843A924340
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 17:25:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1310396484-23371-1-git-send-email-js@sig21.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Johannes Stezenbach <js@sig21.net>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 11, 2011 at 05:01:22PM +0200, Johannes Stezenbach wrote:

> here are two patches for the ST STA32x ASoC codec driver.
> The first one adds SNDRV_CTL_ELEM_TYPE_BYTES controls
> for access to the biquad filter coefficients.  I haven't found
> any other driver using SNDRV_CTL_ELEM_TYPE_BYTES in this way,
> but it works nicely.  The coefficients can be set with

Applied, thanks.  _BYTES is actually the plan for general coefficient
work in the future so should be fine.
