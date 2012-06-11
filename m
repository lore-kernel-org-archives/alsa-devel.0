From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/5] ASoC: wm8903: Move pin configuration
 into I2C probe() function
Date: Mon, 11 Jun 2012 11:26:07 -0600
Message-ID: <4FD62A2F.1050204@wwwdotorg.org>
References: <1339211396-31711-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id BD6DD103FBC
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 19:26:12 +0200 (CEST)
In-Reply-To: <1339211396-31711-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 06/08/2012 09:09 PM, Mark Brown wrote:
> Ensure that the device pins are configured as soon as possible by moving
> the pin configration (including MICBIAS) into the I2C probe() function.
> This had been done in the CODEC probe() function when we were relying on
> the ASoC register I/O code.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

The series,

Tested-by: Stephen Warren <swarren@wwwdotorg.org>

(although I had a little trouble applying it; what was it based on?)
