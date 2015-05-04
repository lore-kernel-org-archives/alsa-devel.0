From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: samsung: wolfson: Improve compile
	test coverage
Date: Mon, 4 May 2015 09:09:34 +0100
Message-ID: <20150504080934.GY3480@opensource.wolfsonmicro.com>
References: <1430676815-10450-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2BCE9260464
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 10:09:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1430676815-10450-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Sun, May 03, 2015 at 08:13:35PM +0200, Lars-Peter Clausen wrote:
> While the the Wolfson machine drivers have a runtime dependency on a
> specific machine there is no compile time dependency. Allow to lets those
> drivers to be selected when COMPILE_TEST is selected to improve the compile
> time test coverage.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
