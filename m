From: narayanan best <narayananbest@gmail.com>
Subject: sound disappears or noise heard after long run
Date: Tue, 22 Apr 2014 11:40:20 +0530
Message-ID: <CADMz-rvOXL8jVUtny0Dcjh-QMFp-NNGvXUx6_smJTJxmtZpW5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 401DD261A2F
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 08:10:22 +0200 (CEST)
Received: by mail-ie0-f179.google.com with SMTP id lx4so4840457iec.10
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 23:10:21 -0700 (PDT)
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
I am facing issue with alsa similar to the issue reported here
http://mailman.alsa-project.org/pipermail/alsa-devel/2007-June/001726.html

This is seen with latest alsa library and driver. Alsa is configured at
44100 (alsa.conf) and application plays at the rate of 48000. When the
pointers cross the boundary value
(after 6-7hrs), a continuous noise (jack hammer noise) or silence is heard.
Issuing SIGSTOP and SIGCONT recovers the application and it starts playing
normally.

Pulseaudio is not running in our setup.

It could be problem with calculation in the rate plugin.
Let me know if you need further details.
