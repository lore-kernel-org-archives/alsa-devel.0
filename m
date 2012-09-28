From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Delay calculations for USB audio?
Date: Fri, 28 Sep 2012 19:29:09 +0200
Message-ID: <5065DE65.5090004@canonical.com>
References: <5065834E.4010707@canonical.com> <506588A2.4070602@gmail.com>
 <5065907C.8030904@canonical.com> <5065987A.1080703@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E12C2615EA
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2012 19:29:10 +0200 (CEST)
In-Reply-To: <5065987A.1080703@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 09/28/2012 02:30 PM, Clemens Ladisch wrote:
> David Henningsson wrote:
>> On 09/28/2012 01:23 PM, Gabriel M. Beddingfield wrote:
>>> On 09/28/2012 06:00 AM, David Henningsson wrote:
>>>>    * Selecting the outer USB port instead of the inner one. Yes, there
>>>> are two USB ports next to each other, and this only happens on one of
>>>> them. (!))
>>>
>>> The last statement sounds like you're sharing a hub with another device
>>> that has reserved bandwidth.  For example, a USB webcam will often do
>>> this.  Audio will work for a while and then get pre-empted.
>
> For A/V devices, USB bandwidth is reserved in advance; it is not possible
> to have other device interfere (as long as the controller driver is
> written correctly ...).
>
>> Thanks! Indeed, when deactivating bluetooth (in both kernel 3.2 and 3.5)
>> the sound is back to normal
>
> I'd guess that that particular USB port and the bluetooth controller
> share an interrupt.

In this case, actually the bluetooth controller is on the same USB bus, 
so that's why they're sharing the interrupt. And when I click the rfkill 
button, it disappears from the bus, just as if it were an external 
bluetooth adapter that I unplugged.

>> is it actually fixable if we wrote better drivers?
> Apparently, yes.

Okay, so if I get some time to dig deeper into this, where should I 
start looking? Maybe in the bluetooth controller driver, if that's 
what's interfering?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
