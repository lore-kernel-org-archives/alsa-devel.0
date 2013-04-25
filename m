From: =?UTF-8?Q?Daniel_Sch=C3=BCrmann?= <daschuer@mixxx.org>
Subject: code improvements in /sound/usb/mixer.c
Date: Thu, 25 Apr 2013 08:23:28 +0200
Message-ID: <CABVYHNjROB-5707rOx+PjKR-geZrVdmv4NAAyJihQG-1myG77g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 14D93265D6C
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2013 08:23:29 +0200 (CEST)
Received: by mail-ie0-f169.google.com with SMTP id ar20so3193385iec.14
 for <alsa-devel@alsa-project.org>; Wed, 24 Apr 2013 23:23:29 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi Takashi, Hi alsa-devel.

in my last mail I had supposed scaling issues with mixer.c, but finally it
turns out that was just a debugging problem of myself.
I was struggled how types are handled in the code. I have some ideas for
improvement but I am not sure if it its worth the work since nothing is
broken.

1. get rid of convert_bytes_value(cval, value_set):
This function return any type in a integer container, which is confusing.

2. use type casts in convert_signed_value():
gcc knows perfecly how to convert types.

3. merge convert_signed_value() and snd_usb_combine_bytes() to get rid of
the intermediate integer variant.

---

I am currently working on a patch that introduces a get_ctl_value_range_v2.
I want to get rid of the three single queries for min max and rate.
Also here, nothing broken. Is it worth to do the work?


Kind regards

Daniel
