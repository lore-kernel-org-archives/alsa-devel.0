From: Eric Rannaud <eric.rannaud@gmail.com>
Subject: amixer sset volume: Left/Right race
Date: Tue, 28 Nov 2017 20:42:49 -0800
Message-ID: <CA+zRj8UcQVZi5hf863nrEQuyw7ZaEnbHenvzN1Evud_Lx2b=Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f171.google.com (mail-ot0-f171.google.com
 [74.125.82.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 01B80266B02
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 05:42:51 +0100 (CET)
Received: by mail-ot0-f171.google.com with SMTP id s4so1997707ote.4
 for <alsa-devel@alsa-project.org>; Tue, 28 Nov 2017 20:42:51 -0800 (PST)
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

In my ~/.xbindkeysrc I have

"amixer set Master 1000+"
  XF86AudioRaiseVolume
"amixer set Master 1000-"
  XF86AudioLowerVolume

When I hold the "volume up" key on my keyboard, the left and right
channel volumes quickly get out of sync.

This is reproducible with this shell loop:

   for i in $(seq 20); do amixer sset Master 1000+ & done

But not with this loop:

   for i in $(seq 20); do amixer sset Master 1000+; done

It appears that xbindkeys invokes multiple amixer concurrently, like
the first shell loop, and that amixer/ALSA is somehow setting the
channel volumes one at a time, presumably in an unprotected
read-modify-update critical section. I'm not familiar with how this
works, and where the blame might lay.

However, pamixer
(https://github.com/cdemoulins/pamixer/blob/master/pulseaudio.cc) uses
/usr/include/pulse/pulseaudio.h and
pa_context_set_sink_volume_by_index() directly and does not have this
problem.

  for i in $(seq 20); do pamixer --increase 1 & done

Thanks.


P.S. The "Bug Tracker" link on the left of
http://alsa-project.org/main/index.php/Main_Page is broken.
