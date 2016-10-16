From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 5/7] ASoC: pxa2xx-ac97: Remove unused DAI
	ID defines
Date: Sun, 16 Oct 2016 20:57:35 +0200
Message-ID: <87funw5dgg.fsf@belgarion.home>
References: <1476552777-1849-1-git-send-email-lars@metafoo.de>
 <1476552777-1849-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr
 [80.12.242.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F86F261560
 for <alsa-devel@alsa-project.org>; Sun, 16 Oct 2016 20:57:38 +0200 (CEST)
In-Reply-To: <1476552777-1849-5-git-send-email-lars@metafoo.de> (Lars-Peter
 Clausen's message of "Sat, 15 Oct 2016 19:32:55 +0200")
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Lars-Peter Clausen <lars@metafoo.de> writes:

> The DAI ID defines are back from the time when DAIs were referenced by a
> numerical ID. These days a string is used for matching instead and the
> defines are unused. The last user of these defines was removed in commit
> f0fba2ad1b6b ("ASoC: multi-component - ASoC Multi-Component Support"). So
> remove the defines as well.
>
> This also means the pxa2xx-ac97.h file no longer has any content and can be
> removed.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
For pxa related files:
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

And with mioa701_wm9713.c:
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
