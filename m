From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: fix pxa2xx-i2s clk_get call
Date: Sat, 30 Aug 2008 22:51:38 +0100
Message-ID: <20080830215137.GA28645@sirena.org.uk>
References: <1220129102-20140-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CF3EF247E7
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Aug 2008 23:51:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1220129102-20140-1-git-send-email-dbaryshkov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 31, 2008 at 12:45:02AM +0400, Dmitry Baryshkov wrote:
> pxa2xx-isa: probe actual device and use it for clk_get call
> thus fixing error during startup hook

i2s, not isa.  Other than that

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

and IIRC Liam acked it already as well.
