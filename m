From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_pcm_set_params faild on set_buffer_time_near
	and set_period_time_near
Date: Thu, 23 Jul 2015 15:19:56 +0800
Message-ID: <CAN8cciYbrxgP6TvC36kPzgaTrFJ00oxXfDu2zxPyGA9UW837SA@mail.gmail.com>
References: <55AE0831.2010206@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f47.google.com (mail-oi0-f47.google.com
 [209.85.218.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E5F626044D
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 09:19:57 +0200 (CEST)
Received: by oihq81 with SMTP id q81so159872724oih.2
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 00:19:56 -0700 (PDT)
In-Reply-To: <55AE0831.2010206@streamunlimited.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Martin Geier <martin.geier@streamunlimited.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> I tried to configure alsa device with snd_pcm_set_params function,
requested
> parameters was:
> channel 2, rate: 22050, soft_resample: 1, latency: 50000

The function snd_pcm_set_params does not always succed especially you are
using 22050Hz which is 20ms increment

Which soc driver ? It is quite difficult to find the soutce by chip name

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/soc
