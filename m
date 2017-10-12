From: Diniz Bortolotto <diniz.bortolotto@gmail.com>
Subject: Pulseaudio say me to report a issue.
Date: Thu, 12 Oct 2017 00:44:45 -0300
Message-ID: <CAEbqFbWyrvJmztW18tsjEtSuq6bKrtxBah=xVsx-_c5NNth3_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id B0E87266E73
 for <alsa-devel@alsa-project.org>; Thu, 12 Oct 2017 05:44:46 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id u138so3233259wmu.0
 for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2017 20:44:46 -0700 (PDT)
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

Hi buddies!

My name is Diniz and I'm new here in alsa-devel list.
I just entered in the list because pulseaudio reported a error in my syslog.

I'm running a Slackware 64bits current machine and receive the messages
below:

pulseaudio[1938]: [alsa-sink-ALC887-VD Analog] alsa-sink.c: ALSA woke us up
to write new data to the device, but there was actually nothing to write.

pulseaudio[1938]: [alsa-sink-ALC887-VD Analog] alsa-sink.c: Most likely
this is a bug in the ALSA driver "snd_hda_intel". Please report this issue
to the ALSA developers.
pulseaudio[1938]: [alsa-sink-ALC887-VD Analog] alsa-sink.c: We were woken
up with POLLOUT set -- however a subsequent snd_pcm_avail() returned 0 or
another value < min_avail.

I don't know if that is a big deal. Sorry if it is not.
I only wanna help. Sorry my poor english. :-)

Best Regards,

Diniz Bortolotto
