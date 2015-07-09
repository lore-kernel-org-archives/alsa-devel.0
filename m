From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC PATCH 2/4] ALSA: core: add .notify callback
 for pcm ops
Date: Thu, 9 Jul 2015 15:25:58 +0800
Message-ID: <CAN8cciYNQNXNzLgfFt=eXy4BVvYJaYfPPdwaCPUOJmuZO38LkQ@mail.gmail.com>
References: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1436350236-17509-3-git-send-email-pierre-louis.bossart@linux.intel.com>
 <s5hlheqhghu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f171.google.com (mail-ob0-f171.google.com
 [209.85.214.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A5F3260504
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 09:26:00 +0200 (CEST)
Received: by obbkm3 with SMTP id km3so166378396obb.1
 for <alsa-devel@alsa-project.org>; Thu, 09 Jul 2015 00:25:59 -0700 (PDT)
In-Reply-To: <s5hlheqhghu.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

> >
> > When appl_ptr is updated let low-level driver know.
> >
> > This is only enabled when the NO_REWIND hardware flag is used,
> > so that the low-level driver/hardware to opportunistically pre-fetch
> > data.
> >
> > FIXME: should we rely on .ack for this?
> > Signed-off-by: Pierre-Louis Bossart <
pierre-louis.bossart@linux.intel.com>
>
> Hmm, OK, so the forward is allowed but with workarounds...
> But then why rewind won't work in a similar way?  DSP might be able to
> cancel some of inflight data.
>
> In other words, I see no reason to strict notify callback only for
> no_rewinds.  This is an optional ops in anyway.
>
> Also, I find the name "notify" a bit too ambiguous.  In this case,
> it's notifying the applptr change.  So, a name related with the
> function would be more understandable.
>
>

If driver specify no rewind flag, should alsa lib

1) return error when application call snd_pcm_rewind() and
snd_pcm_forward() ?
2) return zero when call snd_pcm_rewindable() and snd_pcm_forwardable()

How can the application recover when hw_ptr is behind appl_ptr when stop
threshold is set to boundary ?

Do you mean compressed audio stream don't support rewind and forward ?
