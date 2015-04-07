From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: RME MADIFX mainline inclusion
Date: Tue, 07 Apr 2015 13:05:56 +0200
Message-ID: <5523BA14.3050904@drcomp.erfurt.thur.de>
References: <5522B34B.3090404@drcomp.erfurt.thur.de>
 <s5hd23g9rx4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [188.40.101.23])
 by alsa0.perex.cz (Postfix) with ESMTP id 030B826050C
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2015 13:05:59 +0200 (CEST)
In-Reply-To: <s5hd23g9rx4.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: holindho@saunalahti.fi, alsa-devel@alsa-project.org, nonus@gmx.net, marcinp@uw.edu, Michael.Hentschel@eei.uni-erlangen.de, holeungsing@gmail.com, Moritz.Fiser@joanneum.at, mtzuking@netvigator.com, zmoelnig@umlaeute.mur.at
List-Id: alsa-devel@alsa-project.org

On 04/07/15 12:03, Takashi Iwai wrote:

>> Code is here:
>>
>>      https://github.com/adiknoth/madifx/commits/tokernel
>>
[..]
>> In its current state, can I send you three patches (Kconfig, madifx.h,
>> madifx.c) that add said driver to sound/pci/rme9652?
> Well, I really want some testers whether the merged code actually
> works.

The standalone code (above driver) works, I know a couple of people
using it.

Let me CC a few I've found - maybe they can test a merged version or at
least testify that what they're using atm actually works.

I'd then just go ahead and create a patchset, so they can patch it in
and test it locally.


Cheers
