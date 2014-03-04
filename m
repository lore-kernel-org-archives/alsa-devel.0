From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: da732x: Replace hw_read usage with
	snd_soc_read()
Date: Tue, 4 Mar 2014 09:50:48 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03376BAD4C42@SW-EX-MBX01.diasemi.com>
References: <1393919993-7326-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.117])
 by alsa0.perex.cz (Postfix) with ESMTP id C4D70265749
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 10:50:50 +0100 (CET)
In-Reply-To: <1393919993-7326-1-git-send-email-broonie@kernel.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 04 Mar 2014 09:08:07 +0000, Mark Brown wrote:
 
> From: Mark Brown <broonie@linaro.org>
> 
> Pre-merge code was using direct hw_read() calls as an out of framework
> way of doing volatile register I/O when not using regmap. This has never
> functioned correctly in mainline due to the regmap conversion, the
> hw_read() implementation still does caching. In order to facilitate
> removal of the subsystem level I/O code convert to use snd_soc_read(),
> there should be no functional impact.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
