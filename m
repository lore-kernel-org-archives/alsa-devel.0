From: Ankhit Vivekananda <ankhit.vivekananda@biscotti.com>
Subject: Use of snd_pcm_format_set_silence
Date: Wed, 20 Jan 2016 15:18:15 -0600
Message-ID: <CACaQK7C04jg3nP-7ijntq+ADEdO41+Ab1VpRDS1vwFXWAPPTHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 01F18260484
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2016 22:18:15 +0100 (CET)
Received: by mail-wm0-f52.google.com with SMTP id n5so50268221wmn.0
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2016 13:18:15 -0800 (PST)
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

Hello,

I have an application where in I need to silence the first few samples of
the buffer that is read from snd_pcm_readi(). In order to do this, I call
the snd_pcm_format_set_silence() providing the same buffer that the
snd_pcm_readi() reads to.

1) By doing this, is there going to be a timing delay due to the use of
snd_pcm_format_set_silence()?
2) Is snd_pcm_format_set_silence() the correct function to achieve this
goal or are there better methods?
Please do let me know.

Thank you,
Ankhit
