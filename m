From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Delay calculations for USB audio?
Date: Fri, 28 Sep 2012 13:56:44 +0200
Message-ID: <5065907C.8030904@canonical.com>
References: <5065834E.4010707@canonical.com> <506588A2.4070602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 075FC26172E
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2012 13:56:43 +0200 (CEST)
In-Reply-To: <506588A2.4070602@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/28/2012 01:23 PM, Gabriel M. Beddingfield wrote:
> On 09/28/2012 06:00 AM, David Henningsson wrote:
>> (Oh, and btw, if you have an idea of the crackling/distorted USB audio,
>> let me know. I'm using a standard Logitech USB Headset, using
>> speaker-test -c 2 -D plughw:Headset -t sine -r 48000
>> I can make the problem go away using any of these options:
>>   * Booting a 3.2 kernel - I've tried 3.5, 3.6-rc7 and 3.2
>>   * Choosing the 44100 sample rate instead of the default of 48000
>>   * Selecting the outer USB port instead of the inner one. Yes, there
>> are two USB ports next to each other, and this only happens on one of
>> them. (!))
>
> The last statement sounds like you're sharing a hub with another device
> that has reserved bandwidth.  For example, a USB webcam will often do
> this.  Audio will work for a while and then get pre-empted.
>
> Use 'lsusb -t' to view your USB layout.

Thanks! Indeed, when deactivating bluetooth (in both kernel 3.2 and 3.5) 
the sound is back to normal, so this time I could actually get the 
distortion out of 3.2 as well.

Question is - is this an actual hardware limitation, or is it actually 
fixable if we wrote better drivers?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
