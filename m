From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH 0/2] ASoC: Fix wm97xx touchscreen driver
Date: Fri, 23 Jan 2015 20:09:30 +0100
Message-ID: <CAOLZvyHdhOusK1GNrEmThqetzqC=qV4XpLP7BT7CE3641fKEnQ@mail.gmail.com>
References: <1422026497-23180-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 by alsa0.perex.cz (Postfix) with ESMTP id F05602654E5
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 20:10:10 +0100 (CET)
Received: by mail-wi0-f170.google.com with SMTP id em10so4876001wid.1
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 11:10:10 -0800 (PST)
In-Reply-To: <1422026497-23180-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 23, 2015 at 4:21 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> The wm97xx touchscreen driver will bind itself to the snd_ac97 device
> registered by CODEC drivers and expects that the device has already been
> reset by the CODEC driver. Previous to commit 6794f709b712 ("ASoC: ac97:
> Drop delayed device registration") the snd_ac97 device was only registered
> after the CODEC driver probe function had finished running, but starting
> with the commit it is registered within snd_soc_new_ac97_codec(). This
> breaks the touchscreen driver as the reset is no longer performed before the
> touchscreen driver probe function runs. This patch series introduces a new
> function snd_soc_alloc_ac97_codec() which allocates the snd_ac97 device, but
> does not yet register it yet. This allows the CODEC drivers to perform the
> reset before the device is registered.
>
> The series is meant to perform a minimum amount of changes while fixing the
> issue to prevent introducing other regressions. I have a few more patches
> that consolidate the reset handling in the drivers and puts it into the core
> in snd_soc_new_ac97_codec() which makes the split in the drivers
> unnecessary, but that's something for next and not for stable.
>
> Manuel can you give this another round of testing?

Works very well.

Tested-by: Manuel Lauss <manuel.lauss@gmail.com>


Thanks Lars!
      Manuel
