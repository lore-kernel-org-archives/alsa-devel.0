From: "Nikita N." <nikitan@operamail.com>
Subject: Re: bug
Date: Tue, 31 Mar 2015 01:56:01 -0700
Message-ID: <1427792161.2150884.247436393.3D8D2571@webmail.messagingengine.com>
References: <1427551386.3092172.246393281.691C33A7@webmail.messagingengine.com>
 <5518F8F3.10304@ladisch.de>
 <1427711234.231499.246955417.6E2E7C65@webmail.messagingengine.com>
 <55192FBC.1070307@ladisch.de>
 <1427726222.1872206.247049189.3E3BB0F7@webmail.messagingengine.com>
 <alpine.DEB.2.02.1503311008160.13892@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 00996260621
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 10:56:02 +0200 (CEST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 8CCE9206B3
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 04:55:58 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.02.1503311008160.13892@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

> First of all, I can't say I'm representing the ALSA project or anyone els=
e =

> in this matter, so the following is just my personal opinion.
As we already wrote, we are not blaming you or ALSA.

> particular mixer application such as alsamixergui, but should be able to =

> happen with any mixer application, given the appropriate settings.
That is indeed what we are afraid, if anybody will have the brilliant
idea to reverse engineer that tool to a more damaging level in a
virus/malware , and make its effect unstoppable. =


> Secondly, if you believe that alsamixergui specifically is missbehaving, =

> why don't you just take it out of your distribution (dCore)?
as we wrote, we are going to do this.

> Given the proliferation of cheap PC hardware this is not surprising
as you say, given the proliferation of cheap PC hardware, a
proliferation of such virus/malware could upset not only our users.

> it is hardly a software problem.
I personally don't agree with that.
As we wrote, not everybody is omniscient, I personally was not aware of
this issue, before was pointed out.
Without warnings, even a Teddy Bear can be dangerous.

> alsamixergui is not created by the ALSA =

> project, so this mailing list is the wrong place to look if none other =

> than for that particular reason.
Sure, we would be very grateful if you could point that out, so we can
contact the individual who programmed this tool
Unless it's not a secret or there is smtng to hide.
 =

-- =

  Nikita N.
  nikitan@operamail.com


On Tue, Mar 31, 2015, at 01:24 AM, Ricard Wanderlof wrote:
> =

> On Mon, 30 Mar 2015, Nikita N. wrote:
> =

> > We are the devs involved in dCore porting, and that is one of our users
> > report:
> > http://forum.tinycorelinux.net/index.php/topic,18225
> > =

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
> =

> First of all, I can't say I'm representing the ALSA project or anyone
> else =

> in this matter, so the following is just my personal opinion. Furthermore =

> I have no real experience with the mixer application under discussion =

> (alsamixergui), but on the face of it it just looks like any mixer =

> application.
> =

> From the thread linked above, it seems that if someone maxes out all =

> controls in the mixer, this results in a high-pitched whine in the =

> speakers, which on certain laptops seem to cause the destruction of =

> something in the machine (likely the speakers themselves). It is further =

> speculated in the thread that what might be happening is acoustic
> feedback =

> from the speakers to the microphone, which would make sense given the =

> results, but would seem strange from a system design point of view.
> =

> First of all, it would seem that this wouldn't be dependent on a =

> particular mixer application such as alsamixergui, but should be able to =

> happen with any mixer application, given the appropriate settings.
> =

> Secondly, if you believe that alsamixergui specifically is missbehaving, =

> why don't you just take it out of your distribution (dCore)?
> =

> Thirdly, and perhaps most importantly, this seems to be a hardware =

> problem. If the drive capability of the laptops's output stage is too
> much =

> for the speakers, then there is a serious design flaw in the hardware. =

> Given the proliferation of cheap PC hardware this is not surprising, but =

> it is hardly a software problem.
> =

> And finally, as Clemens said, alsamixergui is not created by the ALSA =

> project, so this mailing list is the wrong place to look if none other =

> than for that particular reason.
> =

> /Ricard
> -- =

> Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
> Axis Communications AB, Lund, Sweden            www.axis.com
> Phone +46 46 272 2016                           Fax +46 46 13 61 30

-- =

http://www.fastmail.com - Or how I learned to stop worrying and
                          love email again
