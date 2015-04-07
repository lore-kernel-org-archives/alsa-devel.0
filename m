From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Speaker burnout
Date: Tue, 7 Apr 2015 13:29:17 +0200
Message-ID: <alpine.DEB.2.02.1504071323390.967@lnxricardw1.se.axis.com>
References: <1427551386.3092172.246393281.691C33A7@webmail.messagingengine.com>
 <5518F8F3.10304@ladisch.de>
 <1427711234.231499.246955417.6E2E7C65@webmail.messagingengine.com>
 <55192FBC.1070307@ladisch.de>
 <1427726222.1872206.247049189.3E3BB0F7@webmail.messagingengine.com>
 <551A6A15.1070605@canonical.com>
 <1427796392.581386.247465613.43178C71@webmail.messagingengine.com>
 <551A7A4D.203@canonical.com> <55236B93.9070504@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EBA7261600
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2015 13:29:20 +0200 (CEST)
In-Reply-To: <55236B93.9070504@blennerhassett.gen.nz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikita N." <nikitan@operamail.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


On Tue, 7 Apr 2015, Eliot Blennerhassett wrote:

> At this setting, enabling the internal mic feedthrough with mic boost
> set to maximum,  feedback happens when mic playback gain is at -6dB
> (max=3D+12dB).
> The signal when recorded is 1325Hz rail to rail square wave.
> =

> My point is that in this case for normal usage the maximum output is
> fine, I'd even say it is required.  So limiting output would not be a
> good idea.
> Also when using the mic for speech capture (with headphones for output),
> a gain greater than the 'feedback inducing' one is likely to be useful.
> =

> So it is (only?) the pathological case of feeding mic direct to speakers
> that is problematic.
> =

> Given that we can't fix the hardware or wacky user behaviour,
> My suggestion would be to either limit, or hide completely the various
> "Mic Playback" controls that enable direct feed from input to output.
> What is the use case for this anyway? - karaoke?

Can it be used to provide a side tone (telephone system terminology for =

feeding back a portion of the microphone signal to the ear piece in a =

telephone; psychologically it helps avoid the impression that the =

telephone is not connected, so all telephone type equipment have it since =

the birth of telephone technology) in telephone applications?

> Given that this goes against the "expose everything in the hardware",
> maybe have a module option that can unhide these controls if anybody
> actually wants to use them.

This sounds like a useful suggestion to me. Many applications have an =

'advanced' option or button which enables things you normally don't need. =

If the 'mic to playback' function isn't really used normally it would seem =

a reasonable option but I suppose that needs to be researched first =

whether it really is of little use.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
