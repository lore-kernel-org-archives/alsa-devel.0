From: Sander Jansen <s.jansen@gmail.com>
Subject: snd_pcm_delay issue - How to debug?
Date: Tue, 16 Jul 2013 09:28:40 -0500
Message-ID: <CACj81kE7OVvwPbgNnSOMaU0u0JKdkSFf0ofz40VFoCi4e6ntxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f173.google.com (mail-vc0-f173.google.com
 [209.85.220.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D8A2264F8F
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 16:28:42 +0200 (CEST)
Received: by mail-vc0-f173.google.com with SMTP id ht10so501078vcb.32
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 07:28:41 -0700 (PDT)
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

I'm seeing an issue where snd_pcm_delay is returning bogus values (usually
a lot larger than in actuality)  in that it ultimately affects the progress
timer in my audio player. Both are HDA based audio cards, though one
connects to the HDMI output and while the other connects to analog out.

I'm suspecting I'm seeing a driver bug since I only start noticing the
issue since a few kernel releases ago (though not sure which one started
it).

How can i best debug this issue and find out the cause.

Thanks,

Sander
