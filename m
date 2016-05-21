From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 1/1] ASoC: pxa: Fix module autoload for
	platform drivers
Date: Sat, 21 May 2016 10:37:14 +0200
Message-ID: <8760u7iz7p.fsf@belgarion.home>
References: <1462548454-28597-1-git-send-email-andrea.adami@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr
 [80.12.242.123])
 by alsa0.perex.cz (Postfix) with ESMTP id E82772606E3
 for <alsa-devel@alsa-project.org>; Sat, 21 May 2016 10:37:17 +0200 (CEST)
In-Reply-To: <1462548454-28597-1-git-send-email-andrea.adami@gmail.com>
 (Andrea Adami's message of "Fri, 6 May 2016 17:27:34 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrea Adami <andrea.adami@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Andrea Adami <andrea.adami@gmail.com> writes:

> These platform drivers are lacking MODULE_ALIAS so module autoloading
> doesn't work. Tested on corgi and poodle with kernel 4.4.
>
> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
Yes, why not.

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
