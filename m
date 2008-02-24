From: Deephay <tudoxxx@gmail.com>
Subject: about PCM devices
Date: Sun, 24 Feb 2008 15:08:11 +0800
Message-ID: <9a9df61d0802232308t25b0c3efm7cf95497f240e247@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.189])
	by alsa0.perex.cz (Postfix) with ESMTP id E9AF8103802
	for <alsa-devel@alsa-project.org>; Sun, 24 Feb 2008 08:08:13 +0100 (CET)
Received: by ti-out-0910.google.com with SMTP id u3so598511tia.8
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 23:08:11 -0800 (PST)
Content-Disposition: inline
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

Greetings all,

  I am very new to ALSA developing, some times I found my program get
a "snd_pcm_open with device 'default': Device or resource busy" error
if some other applications was using ALSA at the mean time (for
example virtualbox), but totem player can co-exist with the ALSA-using
application very well, what is the reason?

I tried play a wav file when there is another ALSA-using application
such as totem :

  aplay -D default test.wav

everything went fine, but with "-D hw:0,0", "-D plughw:0,0", the
device will be busy, with "-D hw:0,1" or "-D plughw:0,1", the device
won't be busy but you can hear nothing, the documentation explains:
"The default device is equal to plug plugin with hw plugin as slave.",
so why "-D plughw:0,0" won't work? Thanks very much!


Cheers,
Deephay
