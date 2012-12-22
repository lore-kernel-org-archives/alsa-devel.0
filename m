From: Vincent Vinel <v.vinel@gmail.com>
Subject: [alsa-lib, dmix] Support for S24_3BE
Date: Sat, 22 Dec 2012 01:43:13 +0100
Message-ID: <CAByx4pqmn+-uFGCgR_fWP=qy6pWWz363eUpXHjS9JMB-b8EG3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f53.google.com (mail-vb0-f53.google.com
 [209.85.212.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B4B12616FB
 for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2012 01:43:14 +0100 (CET)
Received: by mail-vb0-f53.google.com with SMTP id b23so5651568vbz.26
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2012 16:43:13 -0800 (PST)
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

The bugtracker seems to be down, so I'm posting here instead.

I was trying to use software mixing with my Native Instruments USB
soundcard (snd-usb-caiaq), but all attemps to use the dmix pcm ended
up with the rather unhelpful error :
ALSA lib pcm_dmix.c:1311:(_snd_pcm_dmix_open) Unsupported format
When using the hw pcm, however, aplay was kind enough to display the
list of available formats, which in my case was limited to S24_3BE.
A quick check confirmed that dmix doesn't support that format, which
happens to be the only format available for NI USB soundcards (as
defined in snd-usb-caiaq).

Is it worth writing a patch for 24bit big-endian support in dmix ?
External soundcards like these ones are usually used for realtime
effects processing and low-latency audio, things for which dmix
proably isn't suited anyway.

-- 
Vincent Vinel
