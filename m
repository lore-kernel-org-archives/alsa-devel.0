From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: [RFC PATCH] ASoC: pcm512x: Implement the
 set_bclk_ratio interface
Date: Tue, 15 Jan 2019 14:19:12 +0200
Message-ID: <CAHEwa0BuAmVUGoJxQs_DyohrKZ+CTDkZWT1MqUD8miuxsPo2TA@mail.gmail.com>
References: <900a4f74-9312-58d8-a5b3-035305fe184e@gmail.com>
 <4b8ce92c-9239-3a8a-f061-eb114050bd3a@axentia.se>
 <7486f4cb-10c9-26ce-83d8-cb346e33e379@linux.intel.com>
 <0a5918e1-aaf1-2b22-0f2a-4aaa62d1cd3e@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it1-f195.google.com (mail-it1-f195.google.com
 [209.85.166.195])
 by alsa0.perex.cz (Postfix) with ESMTP id C756426742B
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 13:19:25 +0100 (CET)
Received: by mail-it1-f195.google.com with SMTP id p197so4089372itp.0
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 04:19:25 -0800 (PST)
In-Reply-To: <0a5918e1-aaf1-2b22-0f2a-4aaa62d1cd3e@axentia.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Rosin <peda@axentia.se>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 15, 2019 at 10:08 AM Peter Rosin <peda@axentia.se> wrote:
>
> On 2019-01-14 18:36, Pierre-Louis Bossart wrote:
> >
> >> You should perhaps check if (ratio >= 1 && ratio <= 256) prior to
> >> accepting a divider that can't be programmed? But maybe that's enforced
> >> somewhere else? And perhaps the sanity check should be even stricter?
> > Yes it should be stricter with a power of two only. I tried really hard
> > to make this codec work with ratios of 50 (and a 19.2 MHz mclk) on an Up
> > board and it's just not possible, probably not supported by hardware.
>
> Disallowing anything but powers of two just because 50 doesn't work seems
> pretty wild. According to docs I think 48 should work just fine.
>
> Section 8.3.2 Audio Data Interface page 16.
> http://www.ti.com/lit/ds/symlink/pcm5142.pdf
>
> Or?

According to the datasheet[1], you can program any divider between 1
and 256, via register 33 (page 80), but, as Peter points out, in the
description of the audio data interface (page 15), only the values 32,
48, 64, 128, 256 are mentioned as permissible.  So one approach would
be to restrict the values accepted by the callback to this set.  Since
the datasheet is not terribly clear on whether only these are allowed,
and since the ratio is set explicitly in the machine driver, it could
be argued that it would be preferable to allow all values that can be
set in the register, to minimize the risk of needlessly rejecting
valid configurations.

[1] http://www.ti.com/lit/ds/symlink/pcm5121.pdf
