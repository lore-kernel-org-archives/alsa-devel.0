From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: alsalib and snd_pcm_hw_params_set_rate_minmax
Date: Thu, 15 Mar 2018 12:45:45 +0200
Message-ID: <8f76589f-d64f-e6c2-db4a-57319e68ec3d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f47.google.com (mail-lf0-f47.google.com
 [209.85.215.47])
 by alsa0.perex.cz (Postfix) with ESMTP id CDFBF267274
 for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2018 11:45:48 +0100 (CET)
Received: by mail-lf0-f47.google.com with SMTP id q69-v6so9383668lfi.10
 for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2018 03:45:48 -0700 (PDT)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

Is it possible for user-space to reduce configuration space
with snd_pcm_hw_params_set_rate_minmax and then change it
with another snd_pcm_hw_params_set_rate_minmax with values
out of the reduced config?

For example, the initial min/max is 44100/48000 and I set 44100
first, e.g.

snd_pcm_hw_params_set_rate_minmax(handle, hw_params, 44100, 0, 44100, 0)

and then want

snd_pcm_hw_params_set_rate_minmax(handle, hw_params, 48000, 0, 48000, 0)

Obviously, the last call fails as we have already a reduced
space of [44100; 44100].

Is there a way I can still set the range to [48000; 48000]?

Thank you,
Oleksandr

P.S. This is in context of work done for [1]

[1] https://www.spinics.net/lists/alsa-devel/msg75382.html
