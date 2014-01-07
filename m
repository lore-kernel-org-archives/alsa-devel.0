From: Johan Esvelt <johan.esvelt@bluedelta.nl>
Subject: exceprionally large value
Date: Tue, 07 Jan 2014 20:27:32 +0100
Message-ID: <1389122852.3405.6.camel@charles.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f45.google.com (mail-ee0-f45.google.com [74.125.83.45])
 by alsa0.perex.cz (Postfix) with ESMTP id C6CD82610A7
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 20:27:33 +0100 (CET)
Received: by mail-ee0-f45.google.com with SMTP id d49so260296eek.18
 for <alsa-devel@alsa-project.org>; Tue, 07 Jan 2014 11:27:33 -0800 (PST)
Received: from [192.168.11.150] (a82-161-42-179.adsl.xs4all.nl.
 [82.161.42.179])
 by mx.google.com with ESMTPSA id h3sm182811060eem.15.2014.01.07.11.27.32
 for <alsa-devel@alsa-project.org>
 (version=SSLv3 cipher=RC4-SHA bits=128/128);
 Tue, 07 Jan 2014 11:27:33 -0800 (PST)
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


Hi,

My PC crashed and these are the last 3 lines in /var/log/messages:

-------------------------8<----------------------

Jan  7 19:11:48 charles pulseaudio[2646]: alsa-util.c: snd_pcm_avail()
returned a value that is exceptionally large: 416448 bytes (2360 ms).
Jan  7 19:11:48 charles pulseaudio[2646]: alsa-util.c: Most likely this
is a bug in the ALSA driver 'snd_emu10k1'. Please report this issue to
the ALSA developers.
Jan  7 19:11:48 charles pulseaudio[2646]: alJan  7 19:20:03 charles
kernel: imklog 5.8.10, log source = /proc/kmsg started.

-------------------------------8<-----------------

I am running Centos 6.5:

Linux version 2.6.32-358.18.1.el6.x86_64
(mockbuild@c6b10.bsys.dev.centos.org) (gcc version 4.4.7 20120313 (Red
Hat 4.4.7-3) (GCC) ) #1 SMP Wed Aug 28 17:19:38 UTC 2013

What can I do to prevent this from happening again?

Best regards,


Johan Esvelt
