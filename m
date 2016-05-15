From: Trent Reed <treed0803@gmail.com>
Subject: Why is the bufs argument for snd_pcm_writen not const?
Date: Sat, 14 May 2016 20:05:49 -0700
Message-ID: <CAL6pMWpkgzR+dYdNy5OwH=YsQBMhsXnukPHbDndu8WQ=Q9LUQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 by alsa0.perex.cz (Postfix) with ESMTP id E89322606B4
 for <alsa-devel@alsa-project.org>; Sun, 15 May 2016 05:05:50 +0200 (CEST)
Received: by mail-oi0-f51.google.com with SMTP id x19so224569109oix.2
 for <alsa-devel@alsa-project.org>; Sat, 14 May 2016 20:05:50 -0700 (PDT)
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

Hey All,

Just wondering what the reasoning is behind snd_pcm_writen not having
a constant variable for bufs. To me, this doesn't make sense. Does
snd_pcm_writen make any alterations to bufs? I would expect one of the
following declaration:

// Better, but doesn't promise that the API won't change the channel pointers.
snd_pcm_sframes_t snd_pcm_writen(snd_pcm_t* pcm, const void** bufs,
snd_pcm_uframes_t size);
// Best, promises ALSA won't change channel pointers, wont change
underlying data.
snd_pcm_sframes_t snd_pcm_writen(snd_pcm_t* pcm, const void*const*
bufs, snd_pcm_uframes_t size);

For now, is it safe to assume that snd_pcm_writen() doesn't alter any
of the data in bufs passed into it? Any chance on seeing this patched
or is there some reason for this?

Thanks,
- Trent Reed
