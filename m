From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tpa6130a2: Remove CPVSS supply
Date: Tue, 18 May 2010 13:32:03 -0700
Message-ID: <20100518203203.GA15951@opensource.wolfsonmicro.com>
References: <1274211085-20261-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 52879249DB
	for <alsa-devel@alsa-project.org>;
	Tue, 18 May 2010 22:31:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1274211085-20261-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Ilkka Koskinen <ilkka.koskinen@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, May 18, 2010 at 10:31:25PM +0300, Jarkko Nikula wrote:
> I believe there is no need for the CPVSS supply as this pin is for
> decoupling capacitor for the internal charge pump.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Ilkka Koskinen <ilkka.koskinen@nokia.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
