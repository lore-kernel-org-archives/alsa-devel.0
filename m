From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/2] ASoC: Specify target bias state
 directly as a bias state
Date: Mon, 6 Jun 2011 20:35:01 +0100
Message-ID: <4DED2BE5.7050205@ti.com>
References: <1307367706-1325-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 188E4243AA
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 21:35:08 +0200 (CEST)
In-Reply-To: <1307367706-1325-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On 06/06/11 14:41, Mark Brown wrote:
> Rather than a simple flag to say if we want the DAPM context to be at full
> power specify the target bias state. This should have no current effect
> but is a bit more direct and so makes it easier to change our decisions
> about the which bias state to go into in future.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Both

Acked-by: Liam Girdwood <lrg@ti.com>
