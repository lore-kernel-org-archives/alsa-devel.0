From: "H. C. Dornelas" <hcdorn@gmail.com>
Subject: es8316 multiple issues
Date: Mon, 19 Aug 2019 06:01:11 +0000
Message-ID: <CAOFDp9PgOYQbx=YXxS3k8jX+jq0hTDus9JJwFh=SpezzCzzqwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62766F800AA
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2019 08:01:19 +0200 (CEST)
Received: by mail-lf1-x136.google.com with SMTP id a30so471124lfk.12
 for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2019 23:01:19 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi.
Using only ALSA on my Positivo 2 em 1 Q432A (motherboard CHT12CP, es8316 sound
card, kernel 5.2.9), speakers only work with headphones plugged in.
Using Pulseaudio, speakers work without headphones, but many other
problems remain:
no microphones work; speakers are muted every boot and anytime headphones are
unplugged, have no volume control and are only a mute/unmute switch; there are
more than 160 controls in alsamixer's bytcht-es8316 card, most having no effect
on sound output; and I still couldn't test hdmi audio. Here's the
alsa-info file:
http://alsa-project.org/db/?f=ee6dd9bdcf11a192fcccba9ab1b7abb2f3999b5d
UCM files might solve these issues, but I have no experience with those, so any
help would be dearly appreciated.
If any other info is needed, just tell me and I'll add it.
Thank you very much.
