From: Mike Ood <jh1ood@gmail.com>
Subject: Re: snd-bebob and PrismSound Orpheus fails with
	snd_pcm_hw_params_set_channels
Date: Fri, 24 Apr 2015 19:58:16 +0900
Message-ID: <CAJ0eYfVwkZ0Y=yOBN-z4AV1WAEQijDe54A2wbaP8Bnz-W7-Bbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f43.google.com (mail-vn0-f43.google.com
 [209.85.216.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CE28260573
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 12:58:17 +0200 (CEST)
Received: by vnbf62 with SMTP id f62so3652314vnb.3
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 03:58:16 -0700 (PDT)
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

Clemens wrote:
> Does this device (with this cable) work in Windows or OS X?

Definitely.

Let me now reset my PC so that it will boot from its Windows7 partion.

With Audacity and a vendor supplied control software, my Orpheus
plays 44.1kHz 2-ch sound perfectly.

Also,

>>>> I have been using my PrismSound Orpheus successfully with
juju+ffado+jackd as:

for more than five years, not with the same PC but with the same cable,
during which time I have never experienced a trouble.

And before doing clean install of Ubuntu 15.04 (kernel 3.16) a few days ago,
I confirmed that:

% jackd -R -dfirewire -r44100 -p4096 -n3 &
% aplay -D pcm.jack test.wav
or
% alsaplayer -i text -o jack -d "system:playback_1,system:playback_2"
test.wav

works all right on Ubuntu 14.04 with kernel 3.13.

So I have an impression that this is not a hardware but a software problem,
perhaps specific to snd-bebob..

***

> At the moment, a missing packet results in the driver just stopping the
> stream.  There would be better ways to handle this, but I haven't yet
> found the time to implement this.

Any suggestions will be appreciated. Thank you again for taking your time.

Regards,
Mike Ood
