From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCHv3] ASoC: tpa6130a2: Remove CPVSS and HPVdd
	supplies
Date: Thu, 20 May 2010 10:31:54 +0100
Message-ID: <1274347914.3344.17.camel@odin>
References: <1274254212-31786-1-git-send-email-jhnikula@gmail.com>
	<1274255548-4514-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C537B1038F7
	for <alsa-devel@alsa-project.org>;
	Thu, 20 May 2010 11:31:59 +0200 (CEST)
Received: by wwe15 with SMTP id 15so396503wwe.38
	for <alsa-devel@alsa-project.org>; Thu, 20 May 2010 02:31:58 -0700 (PDT)
In-Reply-To: <1274255548-4514-1-git-send-email-jhnikula@gmail.com>
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
Cc: Ilkka Koskinen <ilkka.koskinen@nokia.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-05-19 at 10:52 +0300, Jarkko Nikula wrote:
> These pins are for decoupling capacitors for the internal charge pumps
> in TPA6130A2 and TPA6140A2 and not for connecting external supply.
> 
> Thanks to Eduardo Valentin <eduardo.valentin@nokia.com> for pointing out the
> issue with TPA6130A2 and Ilkka Koskinen <ilkka.koskinen@nokia.com> with
> TPA6140A2.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> Reviewed-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>

Sorry, missed this one yesterday.

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
