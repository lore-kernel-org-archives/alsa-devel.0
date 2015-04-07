From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Speaker burnout
Date: Tue, 07 Apr 2015 09:26:02 +0200
Message-ID: <5523868A.3020502@ladisch.de>
References: <1427551386.3092172.246393281.691C33A7@webmail.messagingengine.com>
 <5518F8F3.10304@ladisch.de>
 <1427711234.231499.246955417.6E2E7C65@webmail.messagingengine.com>
 <55192FBC.1070307@ladisch.de>
 <1427726222.1872206.247049189.3E3BB0F7@webmail.messagingengine.com>
 <551A6A15.1070605@canonical.com>
 <1427796392.581386.247465613.43178C71@webmail.messagingengine.com>
 <551A7A4D.203@canonical.com>
 <55236B93.9070504@blennerhassett.gen.nz>
 <5523828C.8060301@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 1E5C426057D
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2015 09:26:04 +0200 (CEST)
In-Reply-To: <5523828C.8060301@canonical.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, "Nikita N." <nikitan@operamail.com>, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote:
> On 2015-04-07 07:30, Eliot Blennerhassett wrote:
>> The signal when recorded is 1325Hz rail to rail square wave.
>> [...]
>
> If it is possible to burn your speakers out by having the speakers
> outputting some tone caused by feedback, would it not be possible to
> also burn your speakers out by simply having a wave file with the same
> tone and playing it back?

Of course.  The problem is the speakers, not the feedback itself.

When connecting some random speaker to some random amp, it is quite
possible to burn it out:
<https://www.google.com/search?q=tweeter+burn-out>
However, this should not happen inside a closed system where amp and
speakers were designed for each other.

> Or is there something that causes the feedback tone to be of a larger
> amplitude than could ever be produced by the wave file?

In theory, it would be possible to do the mixing in the analog domain.
But there is no way to find out what the HDA codec actually does except
trying it out.


Regards,
Clemens
