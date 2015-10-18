From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Splitting out controls
Date: Sun, 18 Oct 2015 08:41:42 +0200
Message-ID: <alpine.DEB.2.02.1510180836390.24963@lnxricardw1.se.axis.com>
References: <1444657786.2528.78.camel@loki>
 <20151012205908.GA25971@us.netrek.org> <561CADA8.3040903@canonical.com>
 <1445009730.3536.18.camel@rf-debian.wolfsonmicro.main>
 <s5h1tcug5w2.wl-tiwai@suse.de> <56226F21.3040902@linux.intel.com>
 <s5h6125cwl2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C146261518
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 08:41:45 +0200 (CEST)
In-Reply-To: <s5h6125cwl2.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, David Henningsson <david.henningsson@canonical.com>, James Cameron <quozl@laptop.org>
List-Id: alsa-devel@alsa-project.org


On Sat, 17 Oct 2015, Takashi Iwai wrote:

> I won't say that we can always save the world.  But there is certainly
> a room for improvement for a little bit more safety than now.  At
> least, if hardware manufacturer or system integrator already knows the
> dangerous part, we should provide some easy way to paper over it.

Is there any form of statistics on more precisely what type of failures in =

this area occur in the real world? Speakers have been mentioned (and I =

think were the original issue that started the discussion) and are a clear =

case. One could imagine output stages being overdriven (even with no load) =

in some way, or mismatched signal levels which could cause an opamp to =

fail for instance. But have any such cases been reported? It would seem =

very hard to diagnose for one thing, unless a hardware manufacturer =

explicitly noted it in some documentation (which I suspect would be very =

unlikely for say a motherboard or sound card manufacturer).

My point is really that it might be a good idea to get some idea of the =

potential failure modes before introducing a mechanism to protect us from =

them.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
