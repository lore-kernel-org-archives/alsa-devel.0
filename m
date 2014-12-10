From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] ALSA: sound/atmel/ac97c.c: Add device
 tree support
Date: Wed, 10 Dec 2014 21:04:54 +0100
Message-ID: <5488A766.5070206@metafoo.de>
References: <1418241578-17049-1-git-send-email-alexanders83@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 61D7B260426
 for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2014 21:05:00 +0100 (CET)
In-Reply-To: <1418241578-17049-1-git-send-email-alexanders83@web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Stein <alexanders83@web.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

On 12/10/2014 08:59 PM, Alexander Stein wrote:
> This adds device tree support for the AC97 controller. It uses the
> soc-ac97link bindings, but actually only ac97-reset is used.
>
> Signed-off-by: Alexander Stein <alexanders83@web.de>
> ---
> Changes in v2:
> * It now uses the soc-ac97link bindings (partly) instead of defining its own.
>    This should ease the transition to ASoC once a new driver has been written.

Partly? How do they differ? And why do they differ? The devicetree should 
describe the hardware, which I guess is the same in both cases.

- Lars
