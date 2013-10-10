From: =?UTF-8?Q?Petri_J=C3=A4rvisalo?= <petri.jarvisalo@gmail.com>
Subject: Fast Track Ultra 8r...
Date: Thu, 10 Oct 2013 17:25:33 +0300
Message-ID: <CAAsyid1UrqG=7zEL2QMz=q4NEKb6A3n8Wp5E4b3LPkr_GF3Q3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id B2F772615D1
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 16:25:34 +0200 (CEST)
Received: by mail-ie0-f169.google.com with SMTP id tp5so5289256ieb.14
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 07:25:33 -0700 (PDT)
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

I'm new here and somewhat understand how to script php and python ... and
very unskilled with linux... anyway i noticed that the default alsa mixer
values for fast track ultra 8r are way off the optimal when the sound card
is first time plugged in.

What I expected was clear stereo/surround sound, what i got was distorted
mono sound with reverb! Far away from optimal settings!

So, I stated to seek knowledge on web, and finally stumbled upon a homepage
that had some info about the Linux support.

What i found out was that the sound card has internal routing system, zero
latency and a effect processor.Also i found out that the routing works by
controlling the input/output levels at alsa mixer.

The problem, by default all alsa mixer values are assigned to 100%, this
means the internal routing is routing everything to everything distorting
the sound, and making the output mono!

The website I found had suggestion and a bash script to correct the
internal routing:
http://heikki.ketoharju.info/2013/03/linux-and-fasttrackultra/#comment-989

alas, the main article is a good read too :)

Well the script did not work for me, so i changed the settings manually to
my alsa mixer, which took quite some time, and it works like a charm.

Anyway my best wish would be to get a fix for this sound card, so it would
"just work" when plugged in.

Thanks for any info on how i could get this "patch" to be widely available
so others could benefit it too.

Best regards,
Petri
