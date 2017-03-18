From: Cheng Sun <chengsun9@gmail.com>
Subject: dmix/dshare: discrepancy between snd_pcm_{status, state,
	delay}
Date: Sat, 18 Mar 2017 12:18:55 +0000
Message-ID: <CAG6t6sP0FbSD-ai4+Q5pFEdCY4rchC5AU89FsmDKy6=STde++A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f51.google.com (mail-it0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E2752666E1
 for <alsa-devel@alsa-project.org>; Sat, 18 Mar 2017 13:19:17 +0100 (CET)
Received: by mail-it0-f51.google.com with SMTP id m27so47636631iti.0
 for <alsa-devel@alsa-project.org>; Sat, 18 Mar 2017 05:19:17 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

Hi all,

I've been tracking down the cause of an indefinite hang in PortAudio
whenever an xrun occurs, and bisected the issue to the following.

After commits faf53c19 (dshare) and 38a2d2ed (dmix), the semantics of
snd_pcm_state and snd_pcm_delay are no longer the same as a query to
snd_pcm_status, and a subsequent snd_pcm_status_get_*.

Note that these two commits remove the lines that set the state field
in the snd_pcm_status_t:

-       status->state = snd_pcm_state(dshare->spcm);

This causes the behaviour where, when a dmix's slave suffers an xrun,
and the dmix's status is queried, snd_pcm_status_get_state returns
RUNNING, and yet snd_pcm_state returns XRUN.

The reason why I am not attaching a patch right now is because I am
confused as to the commit message in faf53c19, which explicitly
states:

    Note: snd_pcm_dshare_delay() is not updated.

Which leads me to think that this change in semantics was perhaps
deliberate (if not documented anywhere). However I'm not sure what the
rationale is, so I'm not clear on the right way to go about fixing it.

If anyone could shed any further light into this, I'd be very grateful.

Cheers,
Cheng
