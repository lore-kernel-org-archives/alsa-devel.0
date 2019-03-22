From: Paulo Fidalgo <paulo.fidalgo.pt@gmail.com>
Subject: Dell XPS 9360 continuous hissing sound
Date: Fri, 22 Mar 2019 11:40:22 +0000
Message-ID: <CAKbjie7OEVyB4vq4L01p2ov3Vo3Mw+3edLQxwT2eVhzaj-Cu0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 88C6DF8078F
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2019 12:40:34 +0100 (CET)
Received: by mail-qk1-x72d.google.com with SMTP id k130so992158qke.3
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2019 04:40:34 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: tiwai@suse.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

After a bug report on Fedora
(https://bugzilla.redhat.com/show_bug.cgi?id=1677353)

----
When I start t he computer I hears a continuous background noise. The
problem is also described here:
https://wiki.archlinux.org/index.php/Dell_XPS_13_(9360)#Continuous_hissing_sound_with_headphones

I need to issue the command `amixer -c 0 cset 'numid=10' 1` to solve
the problem, but every time I reboot the computer I need to run it
again.
This has been happening for quite some time, but I've been post-poning
the bug report.

Current kernel: 4.20.7-200.fc29.x86_64

Alsa information:
http://www.alsa-project.org/db/?f=df4834c53335709abb521c767e7b1da2f4371744
----
They advise me to contact you, to see if we can get a solution on this.

Note: The computer also does not recognise (switch to) when I plug an headset.

If you need more information, I'm eager to help diagnose and help to
solve this, but I have no Kernel programming skills, other than that
count on me.

Kind regards,

Paulo Fidalgo
