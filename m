From: "Nikita N." <nikitan@operamail.com>
Subject: Re: Speaker burnout
Date: Tue, 31 Mar 2015 03:06:32 -0700
Message-ID: <1427796392.581386.247465613.43178C71@webmail.messagingengine.com>
References: <1427551386.3092172.246393281.691C33A7@webmail.messagingengine.com>
 <5518F8F3.10304@ladisch.de>
 <1427711234.231499.246955417.6E2E7C65@webmail.messagingengine.com>
 <55192FBC.1070307@ladisch.de>
 <1427726222.1872206.247049189.3E3BB0F7@webmail.messagingengine.com>
 <551A6A15.1070605@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 853192614F4
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 12:06:33 +0200 (CEST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id BF57420AEC
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 06:06:29 -0400 (EDT)
In-Reply-To: <551A6A15.1070605@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> If you have any concrete examples (alsa-info please!) of speakers that 
> can be burned out, and you know a maximum speaker volume where this 
As we said, that is not our bug, we are not audio experts, nor any of us
is interested in audio matters.
Nevertheless, we all embrace the Debian/Ubuntu philosophy and Manifesto,
to help in creating a better world, in our small.
For this reason, we feel like we can't just ignore this issue, so
something has to be done to fix it - by who has the proper expertise.
"Ubuntu" is an ancient African word, meaning "humanity to others". The
Ubuntu distribution brings the spirit of Ubuntu to the software world.
We don't bring "humanity to others", programming or distributing any
software which can damage the hardware.


On Tue, Mar 31, 2015, at 02:34 AM, David Henningsson wrote:
> 
> 
> On 2015-03-30 16:37, Nikita N. wrote:
> > We are the devs involved in dCore porting, and that is one of our users
> > report:
> > http://forum.tinycorelinux.net/index.php/topic,18225
> >
> > We verified that in few of our legacy laptops.
> > It didn't reproduce for every laptop, but indeed in a couple of them,
> > the temperature of the speakers reached extremes levels in few seconds,
> > only unplugging the AC/DC cable saved them.
> > This is a serious problem in our opinion, and we would hate to see our
> > dCore reputation spoiled.
> > We hate to admit, but it is *NOT* our bug, and would hate to see this
> > bug reverse engineered into a virus/malware (on Linux, or other OS) and
> > see ourselves blamed for it.
> > So we would like to keep the incident quiet, and we are going to remove
> > that thread from our forum.
> > On the other side, we would expect any action from ALSA project in
> > removing that tool and/or exposing the real individual/s guilty of
> > writing that tool.
> >
> > Thank you for your attentions and looking forward your feedback.
> 
> My opinion is that; it would have been better if the laptop had hardware 
> protection against these kinds of failures, but now that it apparently 
> has not, it should be fixed at the second best level, i e, kernel
> drivers.
> 
> Preferrably by not exposing (at least not by default) the highest levels 
> of speaker output.
> 
> If you have any concrete examples (alsa-info please!) of speakers that 
> can be burned out, and you know a maximum speaker volume where this 
> never happens, I think we should artifically lower the max volume to 
> this level so that no mixer application can set the speaker volume 
> higher than that.
> 
> -- 
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic

-- 
http://www.fastmail.com - The professional email service
