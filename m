From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Speaker burnout
Date: Tue, 31 Mar 2015 12:43:25 +0200
Message-ID: <551A7A4D.203@canonical.com>
References: <1427551386.3092172.246393281.691C33A7@webmail.messagingengine.com>
 <5518F8F3.10304@ladisch.de>
 <1427711234.231499.246955417.6E2E7C65@webmail.messagingengine.com>
 <55192FBC.1070307@ladisch.de>
 <1427726222.1872206.247049189.3E3BB0F7@webmail.messagingengine.com>
 <551A6A15.1070605@canonical.com>
 <1427796392.581386.247465613.43178C71@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BB362614F4
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 12:43:26 +0200 (CEST)
In-Reply-To: <1427796392.581386.247465613.43178C71@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Nikita N." <nikitan@operamail.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org



On 2015-03-31 12:06, Nikita N. wrote:
>> If you have any concrete examples (alsa-info please!) of speakers that
>> can be burned out, and you know a maximum speaker volume where this
> As we said, that is not our bug, we are not audio experts, nor any of us
> is interested in audio matters.

Here's my suggestion how to move forward on this:

  1) Gather consensus that limit the maximum volume on internal speakers 
is the right way forward. Takashi, Clemens, anyone against that strategy?

  2) From the person with the hardware, we will need alsa-info ( 
https://wiki.ubuntu.com/Audio/AlsaInfo ), and also the max volume where 
this does not happen. Is -6 dB good enough? -12 dB? I don't know - this 
is something someone with the hardware must tell us, it cannot simply be 
guessed.

  3) I or someone else can write a kernel patch that limits the maximum 
volume of the speakers to the amount deducted from point 2). Considering 
that we're actually dealing with hardware breakage, this should be sent 
to stable as well. Then no userspace application can set the volume 
higher than our limit.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
