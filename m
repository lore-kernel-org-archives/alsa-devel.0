From: Daniel Sanz <daniellsanz2@gmail.com>
Subject: Non-blocking snd_pcm_drain?
Date: Sat, 10 Nov 2012 18:08:37 +0100
Message-ID: <CAHU0+dREbMHoAKOHgPpHfEO+kr93d1FmtrrQ6-nXUN3=7MqGxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id DC44B26160F
 for <alsa-devel@alsa-project.org>; Sat, 10 Nov 2012 18:08:37 +0100 (CET)
Received: by mail-qc0-f179.google.com with SMTP id b14so2923073qcs.38
 for <alsa-devel@alsa-project.org>; Sat, 10 Nov 2012 09:08:37 -0800 (PST)
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

Hello, I'm new to the ALSA API and I have a question:

I've developed a small program that plays audio from a buffer using
snd_pcm_writei and snd_pcm_drain but I noticed that the snd_pcm_drain call
blocks until the buffer is completely drained. Is there any way to drain
the buffer without a block? I've tried calling snd_pcm_nonblock(handle, 1)
before the call to snd_pcm_drain but it does not work.

The context is that this is an application that plays a particular WAV
sound repeatedly, so I don't want to wait until the sound is played
completely before it is played again.

What would be the best way to achieve this?

Thanks,
