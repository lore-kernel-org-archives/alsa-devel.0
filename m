From: Ploumistos Alexandros <ch02499@cc.uoi.gr>
Subject: Analog sound (ALC262) lost on linux (any distro and
	kernel) on a dual boot system
Date: Thu, 23 Oct 2014 15:01:24 +0300
Message-ID: <1414065684.5448ee14f02dd@webmail.uoi.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from phoenix.noc.uoi.gr (phoenix.noc.uoi.gr [195.130.120.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F647260443
 for <alsa-devel@alsa-project.org>; Thu, 23 Oct 2014 14:01:30 +0200 (CEST)
Received: from phoenix.noc.uoi.gr (localhost [127.0.0.1])
 by phoenix.noc.uoi.gr (8.13.1/8.13.1/SuSE Linux 0.7) with ESMTP id
 s9NC1Pnp008253
 for <alsa-devel@alsa-project.org>; Thu, 23 Oct 2014 15:01:28 +0300
Received: (from wwwrun@localhost)
 by phoenix.noc.uoi.gr (8.13.1/8.13.1/Submit) id s9NC1PZC008250
 for alsa-devel@alsa-project.org; Thu, 23 Oct 2014 15:01:25 +0300
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

A while back I had installed Ubuntu on a friend's laptop -a Sony Vaio VGN-FW21M-
alongside windows Vista. Everything worked fine for a few years, until at some
point last year linux went mute, while in windows both the analog and the
digital outputs continued working. She couldn't remember doing something "out
of the ordinary", but she was sure it was not after an update. Several months
later, she upgraded to windows 7 but that didn't change anything. When I got my
hands on the laptop, I checked for muted controls and other usual suspects,
deprecated quirks (there were none) and all inputs and outputs of the system.
HDMI audio works fine and so does the internal mic. Speakers, headphones and
the external mic input do not work, even though pulse audio volume meter acts
as if there were actually sounds being played. I followed all of Ubuntu's
troubleshooting procedures, I removed and reinstalled alsa and pulse, I purged
all configuration files, I created a new user and I even installed the latest
alsa-packages from the "ALSA daily build snapshots" repository and nothing
worked. I also tried booting into windows, setting all volume levels to the max
and disabled power saving on all sound and multimedia devices. Next, I tried
retasking the jacks one by one to no avail.

I remembered that I had performed the installation with an Ubuntu 11.10 live CD,
so I booted the computer off of that, but this time I got no sound. I tried with
all the live CDs of a multitude of distros I had lying around, with kernels
ranging from 2.6.35 to 3.16.6 and none of them worked, so I figured the issue
must have something to do with windows. Is it possible that windows somehow
started locking the audio chip on shutdown? If that is the case, can it be
deduced from the logs and more importantly, can it be fixed?

I am attaching the output of alsa-info and lspci as well as kernel logs.

Thank you for your time.
