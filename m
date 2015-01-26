From: sqweek <sqweek@gmail.com>
Subject: No stream timing info with alsa pulse plugin?
Date: Mon, 26 Jan 2015 23:10:18 +0800
Message-ID: <CAM104AVeYoNhWB8A24rwy1XnkkG+nyRYNiMV3AmJCHze4TbjjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f175.google.com (mail-we0-f175.google.com
 [74.125.82.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 1279F2605F2
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 16:10:19 +0100 (CET)
Received: by mail-we0-f175.google.com with SMTP id p10so9602636wes.6
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 07:10:18 -0800 (PST)
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

Hi guys,

I discovered on my machine that alsa_snd_pcm_status_get_tstamp (and
also get_htstamp) stop working when my asoundrc invokes the pulse
plugin.

That is, normally they work fine but once the sound is going via pulse
the returned time stamp is always zero. I'm trying to understand why
that is.

I couldn't really find any discussion of the pulse plugin on the
archives so I'm not entirely sure I've found the right list; I was
directed here via the pulseaudio bugzilla[1].

[1] https://bugs.freedesktop.org/show_bug.cgi?id=88503

Thanks for any assistance!
-sqweek
