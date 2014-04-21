From: Daniel Mack <daniel@zonque.org>
Subject: Re: Behringer Uphoria UMC204 usb audio capture only
 pops and clicks
Date: Mon, 21 Apr 2014 18:11:11 +0200
Message-ID: <5355431F.3000501@zonque.org>
References: <CAEYsuVOBOGMwqhzx8ZROJ8+vbmfD6Ty=fnAtzccMqkFUGKPM4A@mail.gmail.com>	<53551C5B.5010002@zonque.org>	<CAEYsuVP1pr87v0y5SuKL87bCRr5RpfgLiSfjsZb4mis1yE_w1g@mail.gmail.com>
 <CAEYsuVML1ZFGGP35KB=3im_JTgNSCoNfPg1aMnzT6mjR=u1cJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id B658326087E
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 18:11:12 +0200 (CEST)
In-Reply-To: <CAEYsuVML1ZFGGP35KB=3im_JTgNSCoNfPg1aMnzT6mjR=u1cJA@mail.gmail.com>
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

(please do not top-post)

On 04/21/2014 04:17 PM, Andrew Reyes wrote:
> And this is the pastebin link for the stream info set at 48khz:
> http://pastebin.com/ysw6j5uA

Ok, so the actual frequency is close enough to the nominal one. Please
also do the tests wit aplay to see whether your issue can be recovered
by chosing larger buffer sizes. Do you see any messages in dmesg when
these 'clicks and pop' occur?

Also, please try this one:

  (while sleep 0.123; do grep 'Momentary freq' /proc/asound/xxx/stream0;
done) | uniq

Thanks,
Daniel
