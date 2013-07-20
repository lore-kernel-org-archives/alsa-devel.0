From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: twl6040: Use power efficient
	workqueue
Date: Sat, 20 Jul 2013 11:12:29 +0200
Message-ID: <51EA547D.9030709@ti.com>
References: <1374183911-6814-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id EA06B26036A
 for <alsa-devel@alsa-project.org>; Sat, 20 Jul 2013 11:12:20 +0200 (CEST)
In-Reply-To: <1374183911-6814-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 07/18/2013 11:45 PM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> The accessory detect debounce work is not performance sensitive so let
> the scheduler run it wherever is most efficient rather than in a per CPU
> workqueue by using the system power efficient workqueue.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
