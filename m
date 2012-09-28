From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Delay calculations for USB audio?
Date: Fri, 28 Sep 2012 14:30:50 +0200
Message-ID: <5065987A.1080703@ladisch.de>
References: <5065834E.4010707@canonical.com> <506588A2.4070602@gmail.com>
 <5065907C.8030904@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id EF3DE264F22
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2012 14:30:52 +0200 (CEST)
In-Reply-To: <5065907C.8030904@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org, "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote:
> On 09/28/2012 01:23 PM, Gabriel M. Beddingfield wrote:
>> On 09/28/2012 06:00 AM, David Henningsson wrote:
>>>   * Selecting the outer USB port instead of the inner one. Yes, there
>>> are two USB ports next to each other, and this only happens on one of
>>> them. (!))
>>
>> The last statement sounds like you're sharing a hub with another device
>> that has reserved bandwidth.  For example, a USB webcam will often do
>> this.  Audio will work for a while and then get pre-empted.

For A/V devices, USB bandwidth is reserved in advance; it is not possible
to have other device interfere (as long as the controller driver is
written correctly ...).

> Thanks! Indeed, when deactivating bluetooth (in both kernel 3.2 and 3.5)
> the sound is back to normal

I'd guess that that particular USB port and the bluetooth controller
share an interrupt.

> is it actually fixable if we wrote better drivers?

Apparently, yes.


Regards,
Clemens
