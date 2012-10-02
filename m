From: Sander Jansen <s.jansen@gmail.com>
Subject: hdmi output (switching sample format/rates)
Date: Tue, 2 Oct 2012 11:25:12 -0500
Message-ID: <CACj81kGTmA7HT7OHX8eP8F3DP+-quDwfkgy_wSKzrbzjXiD9Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 429B2261627
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2012 18:25:18 +0200 (CEST)
Received: by iebc10 with SMTP id c10so14139636ieb.38
 for <alsa-devel@alsa-project.org>; Tue, 02 Oct 2012 09:25:12 -0700 (PDT)
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

In my audio application when I sometimes  need to switch to a
different sample format and/or rate, I usually leave the audio device
open and merely reconfigure the device to the new parameters. This
works with all the regular pcm devices, but it fails when I use the
"hdmi" device. It seemed to just silently fail and no audio output is
heard. As far as I know, no error condition is triggered (but I'll
admit, my knowledge of the alsa api is rather limited).

My question, Is this a bug or is it supposed to work this way and if
so are there ways to detect whether a devices needs to be reopened or
not.

Thanks,

Sander
