From: Gabriel Johnson <johnsoga@gmail.com>
Subject: audio mixing
Date: Wed, 6 May 2009 08:56:15 -0500
Message-ID: <bb6204720905060656r61bcf069l4d41a2740eb6b816@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by alsa0.perex.cz (Postfix) with ESMTP id AB141246EE
	for <alsa-devel@alsa-project.org>;
	Wed,  6 May 2009 15:56:16 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so88059wfg.23
	for <alsa-devel@alsa-project.org>; Wed, 06 May 2009 06:56:15 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am using alsa libs to mix audio alerts in my application.  I am
using the aplay code as an example.  I am playing two audio files, one
that is 5sec and one that is a beep, from two different threads.  The
thread that plays the beep loops and plays it every second.  I am
playing the two audio files through the same snd_pcm_t handle.  When
the 5sec audio file finishes I then the pcm gets into an xrun state.
Instead of using the same handle for all audio should I just associate
one handle per audio file?  Is there something else I can do to make
the pcm handle more stable when playing multiple audio files?
