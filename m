From: Andrew Reyes <dsreyes1014@gmail.com>
Subject: Re: Behringer Uphoria UMC204 usb audio capture only
 pops and clicks
Date: Mon, 21 Apr 2014 09:10:27 -0500
Message-ID: <CAEYsuVP1pr87v0y5SuKL87bCRr5RpfgLiSfjsZb4mis1yE_w1g@mail.gmail.com>
References: <CAEYsuVOBOGMwqhzx8ZROJ8+vbmfD6Ty=fnAtzccMqkFUGKPM4A@mail.gmail.com>
 <53551C5B.5010002@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f172.google.com (mail-qc0-f172.google.com
 [209.85.216.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 69D54261A97
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 16:10:28 +0200 (CEST)
Received: by mail-qc0-f172.google.com with SMTP id i8so4083129qcq.31
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 07:10:27 -0700 (PDT)
In-Reply-To: <53551C5B.5010002@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

How do I reply to an existing thread? I'm not clear on that. Sorry about
that. I was under the impression I had to reply by using the same subject
description.


On Mon, Apr 21, 2014 at 8:25 AM, Daniel Mack <daniel@zonque.org> wrote:

> On 04/21/2014 05:12 AM, Andrew Reyes wrote:
> > Should I be posting somewhere else. If so can someone let me know where?
>
> Please don't start a new thread every time you post but reply to an
> existing thread. Given the traffic on this list, the conversation is not
> easy to follow otherwise.
>
> Regarding your issue - the descriptors look sane AFAICS. Please have a
> look at /proc/asound/card/xxx/stream* (where xxx is the index of your
> USB soundcard), and report the actual streaming frequency when playing
> at rates higher than 44.1khz.
>
> You can also monitor the values automatically, like so:
>
> (while sleep 0.123; do grep 'Momentary freq' /proc/asound/xxx/stream0;
> done) | uniq
>
>
> Also, how to you play the audio? Try with aplay, and try to tweak the
> values in the --buffer-size parameters.
>
>
> Daniel
>
>
