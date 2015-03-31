From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Speaker burnout
Date: Tue, 31 Mar 2015 11:34:13 +0200
Message-ID: <551A6A15.1070605@canonical.com>
References: <1427551386.3092172.246393281.691C33A7@webmail.messagingengine.com>
 <5518F8F3.10304@ladisch.de>
 <1427711234.231499.246955417.6E2E7C65@webmail.messagingengine.com>
 <55192FBC.1070307@ladisch.de>
 <1427726222.1872206.247049189.3E3BB0F7@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 5849D260646
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 11:34:14 +0200 (CEST)
In-Reply-To: <1427726222.1872206.247049189.3E3BB0F7@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Nikita N." <nikitan@operamail.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2015-03-30 16:37, Nikita N. wrote:
> We are the devs involved in dCore porting, and that is one of our users
> report:
> http://forum.tinycorelinux.net/index.php/topic,18225
>
> We verified that in few of our legacy laptops.
> It didn't reproduce for every laptop, but indeed in a couple of them,
> the temperature of the speakers reached extremes levels in few seconds,
> only unplugging the AC/DC cable saved them.
> This is a serious problem in our opinion, and we would hate to see our
> dCore reputation spoiled.
> We hate to admit, but it is *NOT* our bug, and would hate to see this
> bug reverse engineered into a virus/malware (on Linux, or other OS) and
> see ourselves blamed for it.
> So we would like to keep the incident quiet, and we are going to remove
> that thread from our forum.
> On the other side, we would expect any action from ALSA project in
> removing that tool and/or exposing the real individual/s guilty of
> writing that tool.
>
> Thank you for your attentions and looking forward your feedback.

My opinion is that; it would have been better if the laptop had hardware 
protection against these kinds of failures, but now that it apparently 
has not, it should be fixed at the second best level, i e, kernel drivers.

Preferrably by not exposing (at least not by default) the highest levels 
of speaker output.

If you have any concrete examples (alsa-info please!) of speakers that 
can be burned out, and you know a maximum speaker volume where this 
never happens, I think we should artifically lower the max volume to 
this level so that no mixer application can set the speaker volume 
higher than that.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
