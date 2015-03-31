From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Speaker burnout
Date: Tue, 31 Mar 2015 13:31:17 +0200
Message-ID: <alpine.DEB.2.02.1503311322220.13892@lnxricardw1.se.axis.com>
References: <1427551386.3092172.246393281.691C33A7@webmail.messagingengine.com>
 <5518F8F3.10304@ladisch.de>
 <1427711234.231499.246955417.6E2E7C65@webmail.messagingengine.com>
 <55192FBC.1070307@ladisch.de>
 <1427726222.1872206.247049189.3E3BB0F7@webmail.messagingengine.com>
 <551A6A15.1070605@canonical.com>
 <1427796392.581386.247465613.43178C71@webmail.messagingengine.com>
 <551A7A4D.203@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id B73232617A5
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 13:31:19 +0200 (CEST)
In-Reply-To: <551A7A4D.203@canonical.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikita N." <nikitan@operamail.com>
List-Id: alsa-devel@alsa-project.org


On Tue, 31 Mar 2015, David Henningsson wrote:

> On 2015-03-31 12:06, Nikita N. wrote:
> >> If you have any concrete examples (alsa-info please!) of speakers that
> >> can be burned out, and you know a maximum speaker volume where this
> > As we said, that is not our bug, we are not audio experts, nor any of us
> > is interested in audio matters.
> =

> Here's my suggestion how to move forward on this:
> =

>   1) Gather consensus that limit the maximum volume on internal speakers =

> is the right way forward. Takashi, Clemens, anyone against that strategy?
> =

>   2) From the person with the hardware, we will need alsa-info ( =

> https://wiki.ubuntu.com/Audio/AlsaInfo ), and also the max volume where =

> this does not happen. Is -6 dB good enough? -12 dB? I don't know - this =

> is something someone with the hardware must tell us, it cannot simply be =

> guessed.
> =

>   3) I or someone else can write a kernel patch that limits the maximum =

> volume of the speakers to the amount deducted from point 2). Considering =

> that we're actually dealing with hardware breakage, this should be sent =

> to stable as well. Then no userspace application can set the volume =

> higher than our limit.

While we could technically limit the output level in a driver, the output =

level at which the speakers get damaged must surely depend not only on the =

codec but also on the particular analog output stage driving the speakers =

(assuming it's not built into the codec), the speakers themselves, as well =

as any other hardware on the board, for instance coupling capacitors, or =

potential overload protection circuitry, most of which are components =

which we cannot identify in the driver.

My point is that unless this is a problem with a very specific hardware, =

there's no way the software can actually know what a "dangerous" level =

would be, and hence we cannot limit it in software. What is a "dangerous" =

level in one setup could be an unusably low level in another setup, where =

both setups look identical from a driver point of view.

I'm thinking that any limits must be dependent on a particular hardware =

setup, which means in order to be successful, we would have to extract =

some sort of model name of the system we're actually running on, to be =

compared against some sort of graylist. With the proliferation of model =

names of PC:s, such a list would be sketchy at best.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
