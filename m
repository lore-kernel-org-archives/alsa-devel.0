From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Disable DAPM for click avoidance ?
Date: Fri, 24 Nov 2017 10:43:48 +0100
Message-ID: <alpine.DEB.2.11.1711241028370.27895@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.11.1711221315370.27895@lnxricardw1.se.axis.com>
 <20171122161315.vpahz77si5xgkmct@sirena.org.uk>
 <alpine.DEB.2.11.1711231024510.27895@lnxricardw1.se.axis.com>
 <20171123110403.cut6okmjxiithxsj@sirena.org.uk>
 <alpine.DEB.2.11.1711231512490.27895@lnxricardw1.se.axis.com>
 <20171123173427.p3vtifkpqjziifjr@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id B9742266DE5
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 10:43:55 +0100 (CET)
In-Reply-To: <20171123173427.p3vtifkpqjziifjr@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Thu, 23 Nov 2017, Mark Brown wrote:

> > In my case the codec is only a couple of years old, so I'd say it =

> > qualifies as 'modern'. There's a table in the data sheet describing the =

> =

> Wow, people are still designing new VMID based CODECs - what is this one?

In this case it's the AK4637. From the data sheet it looks to be from =

2015.

I know there are codecs that do not need their inputs/outputs (internally) =

biased to a VMID, but have a 0V bias level using an internal charge-pump =

design to generate the required internal negative voltages, if that is =

what you're thinking of. One disadvantage from a cost perspective is the =

external capacitors needed for the charge pump to operate, and the design =

in which this one is used is extermely cost optimized.

> > During which time period is the digital mute enabled? From the first =

> > stream startup until everything is up and running?
> =

> It should be enabled at all times that we're not actively playing
> anything.  =


Ok. So it really would be the last callback made (with mute =3D off) to the =

codec driver once everything else has been set up then?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
