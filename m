From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dapm: Ensure kcontrol list is
	initialised
Date: Tue, 13 Aug 2013 10:56:08 +0200
Message-ID: <5209F4A8.2090504@metafoo.de>
References: <1376349671-27655-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id D04A72650F9
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 10:56:21 +0200 (CEST)
In-Reply-To: <1376349671-27655-1-git-send-email-broonie@kernel.org>
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

On 08/13/2013 01:21 AM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
>
> Ensure that the recently added path kcontrol list is initialised otherwise
> we may crash trying to delete routes that don't have kcontrols.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.
