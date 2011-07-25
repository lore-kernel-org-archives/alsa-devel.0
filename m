From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Add regmap as a control type
Date: Mon, 25 Jul 2011 10:41:38 +0100
Message-ID: <4E2D3A52.8010909@ti.com>
References: <1311544371-10003-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A4C624481
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jul 2011 11:41:44 +0200 (CEST)
In-Reply-To: <1311544371-10003-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 24/07/11 22:52, Mark Brown wrote:
> Allow drivers to set up their own regmap API structures. This is mainly
> useful with MFDs where the core driver will have set up regmap at the
> minute, though it may make sense to push the existing regmap setup out
> of the core into the drivers.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
Acked-by: Liam Girdwood <lrg@ti.com>
