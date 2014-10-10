From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC machine driver: how to configure supported
 frame rates?
Date: Fri, 10 Oct 2014 20:29:01 +0200
Message-ID: <5438256D.8040605@metafoo.de>
References: <54380559.7030807@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-029.synserver.de (smtp-out-029.synserver.de
 [212.40.185.29])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E4452605FF
 for <alsa-devel@alsa-project.org>; Fri, 10 Oct 2014 20:29:06 +0200 (CEST)
In-Reply-To: <54380559.7030807@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <ssawazki@gmx.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/10/2014 06:12 PM, Sergej Sawazki wrote:
> Dear all,
>
> I'm writing an ALSA SoC machine driver. The codec on my board, as well
> as the cpu do support the following rates: SNDRV_PCM_RATE_8000_192000
>
> However, the codec, as well as the cpu are clock slaves and the clocks
> are fixed. Hence, my board does only support the 96kHz sample rate.
>
> Can someone give me some advice on how to tell ALSA that my board does
> only support the rate SNDRV_PCM_RATE_96000?
> I don't want to modify the codec and the platform driver.
>
> Any help would be highly appreciated.  Thanks!

You can apply additional constraints in the startup callback of the 
snd_soc_ops of DAI link in your board driver.

For example see sound/soc/samsung/h1940_uda1380.c

- Lars
