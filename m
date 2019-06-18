From: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH] ASoC: Intel: skl: extract common function
Date: Tue, 18 Jun 2019 16:36:30 +0800
Message-ID: <CA+Px+wX+KwV8e9ugoB_pkdvWBJD_A26v4JTNmA0nTC_S8oSs4w@mail.gmail.com>
References: <20190618070503.36310-1-tzungbi@google.com>
 <f3ccd6a2-a9b1-15a6-6b0f-b044a2def5d7@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 695F9F8075C
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 10:36:44 +0200 (CEST)
Received: by mail-ot1-x342.google.com with SMTP id i8so13167810oth.10
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 01:36:43 -0700 (PDT)
In-Reply-To: <f3ccd6a2-a9b1-15a6-6b0f-b044a2def5d7@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Dylan Reid <dgreid@google.com>, Jimmy Cheng-Yi Chiang <cychiang@google.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 18, 2019 at 3:46 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> HDMI support is a mess for sure, but I am not sure this is the right way
> to refactor the code. See e.g. bxt_da7219_max98357a, a single init
> callback was used. you can use dai->id to manage the right offset,
>
> pcm->device = SKL_DPCM_AUDIO_HDMI1_PB + dai->id; or
> pcm->device = dai->id;
>
> instead of hard-coding the values in a parameter.
>
Yeah, I noticed that and I am very confused.

But after following the call sequence, _late_probe() ->
hdac_hdmi_jack_init() -> hdac_hdmi_get_pcm_from_id(), it seems the ID
is merely a unique key to perform linear search in
hdac_hdmi_get_pcm_from_id().  It looks like the follower
snd_hdac_add_chmap_ctls() does not use the ID too seriously.

TBH, I am not very sure either.  But if either way is fine, simpler is
better (i.e. pcm->device = dai->id;).
