From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Drop unused state parameter from
 CODEC suspend callback
Date: Fri, 2 Dec 2011 10:32:18 +0000
Message-ID: <20111202103217.GB8245@opensource.wolfsonmicro.com>
References: <1322817508-23150-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5B72B246C1
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 11:32:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1322817508-23150-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 02, 2011 at 10:18:28AM +0100, Lars-Peter Clausen wrote:
> The existence of this parameter is purely historical. None of the CODEC drivers
> uses it and we always pass in the same value anyway, so it should be safe to
> remove it.

Applied, thanks.
