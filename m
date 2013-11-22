From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8991: Use a supply to manage input
	power
Date: Fri, 22 Nov 2013 11:50:29 +0000
Message-ID: <20131122115029.GA25130@opensource.wolfsonmicro.com>
References: <1385119023-19335-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A32BC261631
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 12:50:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1385119023-19335-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 22, 2013 at 11:17:03AM +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Instead of using a fake register and events to manage input power use a
> supply to do the job, saving code and preparing for regmap conversion of
> the driver.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
