From: Daniel Mack <daniel@zonque.org>
Subject: Re: Behringer Uphoria UMC204 usb audio capture only
 pops and clicks
Date: Mon, 21 Apr 2014 15:25:47 +0200
Message-ID: <53551C5B.5010002@zonque.org>
References: <CAEYsuVOBOGMwqhzx8ZROJ8+vbmfD6Ty=fnAtzccMqkFUGKPM4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 80A05261B01
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 15:25:49 +0200 (CEST)
In-Reply-To: <CAEYsuVOBOGMwqhzx8ZROJ8+vbmfD6Ty=fnAtzccMqkFUGKPM4A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Reyes <dsreyes1014@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/21/2014 05:12 AM, Andrew Reyes wrote:
> Should I be posting somewhere else. If so can someone let me know where?

Please don't start a new thread every time you post but reply to an
existing thread. Given the traffic on this list, the conversation is not
easy to follow otherwise.

Regarding your issue - the descriptors look sane AFAICS. Please have a
look at /proc/asound/card/xxx/stream* (where xxx is the index of your
USB soundcard), and report the actual streaming frequency when playing
at rates higher than 44.1khz.

You can also monitor the values automatically, like so:

(while sleep 0.123; do grep 'Momentary freq' /proc/asound/xxx/stream0;
done) | uniq


Also, how to you play the audio? Try with aplay, and try to tweak the
values in the --buffer-size parameters.


Daniel
