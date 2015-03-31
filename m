From: "Nikita N." <nikitan@operamail.com>
Subject: Re: bug
Date: Tue, 31 Mar 2015 01:19:13 -0700
Message-ID: <1427789953.2143209.247430925.7143290B@webmail.messagingengine.com>
References: <1427551386.3092172.246393281.691C33A7@webmail.messagingengine.com>
 <5518F8F3.10304@ladisch.de>
 <1427711234.231499.246955417.6E2E7C65@webmail.messagingengine.com>
 <55192FBC.1070307@ladisch.de>
 <1427726222.1872206.247049189.3E3BB0F7@webmail.messagingengine.com>
 <551A4A2E.8040905@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 9DEE0261293
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 10:19:14 +0200 (CEST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id A793B208AF
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 04:19:10 -0400 (EDT)
In-Reply-To: <551A4A2E.8040905@blennerhassett.gen.nz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>, alsa-devel@alsa-project.org
Cc: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

> And in my opinion, you are blaming the wrong party here.
we are not blaming anybody.
We simply want to avoid any more of Our users to damage their speakers.
Most of users are not omniscient, if they are given a tool capable of
creating damage, at least they deserve a warning from the tool/provider.
If ALSA can't fix/remove that tool, we kindly ask you to point us to the
individual who programmed it, and we will contact him/her directly.
Unless that is not a secret.
If that is a secret and/or we will not receive feedback, then we will
expose clearly to the public that tool as a virus/malware, and inform
the antivirus authorities about it.

> (Yes I can confirm that happens on my laptop with mic gain set to 20dB below maximum).
Thank you very much for your confirmation, so in the meantime we start
as blacklisting that tool from our repos.

-- 
  Nikita N.
  nikitan@operamail.com


On Tue, Mar 31, 2015, at 12:18 AM, Eliot Blennerhassett wrote:
> On 31/03/15 03:37, Nikita N. wrote:
> > We are the devs involved in dCore porting, and that is one of our users
> > report:
> > http://forum.tinycorelinux.net/index.php/topic,18225
> > 
> > We verified that in few of our legacy laptops.
> > It didn't reproduce for every laptop, but indeed in a couple of them,
> > the temperature of the speakers reached extremes levels in few seconds,
> > only unplugging the AC/DC cable saved them.
> 
> This is a hardware problem, quite likely reproducible in any OS that
> gives control of the
> 
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
> 
> As Clemens has pointed out, "the ALSA project" cannot remove the tool,
> as it is not part of the ALSA project.
> However, probably any software that can control all the volumes is
> capable of reproducing the same effect.
> 
> And in my opinion, you are blaming the wrong party here. As various
> posters on your forum thread point out, blame the hardware manufacturer
> or the particular user who has done something crazy and now wants to
> find some other "guilty" party.
> 
> 1: User setting ALL volumes to maximum (?) probably causes feedback from
> microphone to speakers.   (Yes I can confirm that happens on my laptop
> with mic gain set to 20dB below maximum). You can do the same on your
> home stereo and blow your speakers, nobody will have any sympathy.
> 
> 2: The laptop manufacturer has apparently not designed the hardware
> robustly, i.e. the speakers are too puny for the maximum output of the
> audio amplifier.
> 
> 3: There is no way for the soundcard driver to know what the limits are,
> it just exposes the controls for the user to set.
> 
> regards
> 
> Eliot

-- 
http://www.fastmail.com - Or how I learned to stop worrying and
                          love email again
