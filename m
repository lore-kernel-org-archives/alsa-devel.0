From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Subject: Re: potential speaker burnout
Date: Tue, 31 Mar 2015 21:41:05 +1300
Message-ID: <551A5DA1.2070603@blennerhassett.gen.nz>
References: <1427551386.3092172.246393281.691C33A7@webmail.messagingengine.com>
 <5518F8F3.10304@ladisch.de>
 <1427711234.231499.246955417.6E2E7C65@webmail.messagingengine.com>
 <55192FBC.1070307@ladisch.de>
 <1427726222.1872206.247049189.3E3BB0F7@webmail.messagingengine.com>
 <551A4A2E.8040905@blennerhassett.gen.nz>
 <1427789953.2143209.247430925.7143290B@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from omr.mail.isx.net.nz (omr.mail.isx.net.nz [111.65.230.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 32F282612AC
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 10:41:12 +0200 (CEST)
In-Reply-To: <1427789953.2143209.247430925.7143290B@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Nikita N." <nikitan@operamail.com>, alsa-devel@alsa-project.org
Cc: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 31/03/15 21:19, Nikita N. wrote:
>> And in my opinion, you are blaming the wrong party here.
> we are not blaming anybody.

You talk about finding the person who is "guilty"

>> (Yes I can confirm that happens on my laptop with mic gain set to 20dB below maximum).

> Thank you very much for your confirmation, so in the meantime we start
> as blacklisting that tool from our repos.

I agree it would be upsetting to have your laptop speakers go up in smoke.

But I reiterate, it is not the alsamixergui tool. ANY tool that is
capable of adjusting the underlying controls of the soundcard is capable
of reproducing the effect.  I.e. commandline "amixer", terminal
"alsamixer', possibly others...

You would be better to blacklist the problematic laptop hardware, not
these control apps.

The one thing maybe worth thinking about is whether there is any useful
purpose for the control that enables direct feed from microphone to
speakers?  This is something that is provided by the underlying sound
driver, and would need to be "fixed" there.
I.e. your distro would have to patch drivers before building the kernel.
