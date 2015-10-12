From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH] ALSA: usb-audio: Fix max packet size
 calculation for USB audio
Date: Mon, 12 Oct 2015 16:19:25 +0200
Message-ID: <alpine.DEB.2.02.1510121612160.30767@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1510092334230.25238@lnxricardw1.se.axis.com>
 <56197D0C.3070902@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id AC5CC261A8E
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 16:19:29 +0200 (CEST)
In-Reply-To: <56197D0C.3070902@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Sat, 10 Oct 2015, Pierre-Louis Bossart wrote:

> > However, I'm working on a quirk for a device which stuffs an extra =

> > four (non sample) bytes into each isochronous packet, and that means =

> > that the maxsize calculation must take this into account. During this =

> > work it became obvious that there was something wrong with the maxsize =

> > calculation, as the resulting packet size when wMaxPacketSize was hit =

> > did not correspond to the packet size which triggered the if statement =

> > to start with.
> =

> That sounds wild and borderline compliant. It's almost as if an encoded =

> format should have been used for this pseudo-PCM with metadata. Are =

> those 4 extra bytes accounted for in what the device endpoint reports? =

> If no, then I fail to understand how the fix would help, you may exceed =

> the max packet size. And this could also screw up the implicit feedback =

> case where the rate is determined by looking at packet sizes.

Ok, to clarify, this patch is not a fix for the device in question. What I =

wrote was that while working with another patch for that device (Zoom =

R16), I discovered this problem with the max packet size calculation. So =

the patch in this thread fixes the packet size calculation, but does not =

address the problem with the Zoom R16. I thought it better to submit the =

packet size calculation fix as a separate patch as it is totally unrelated =

to the R16, and also becuase it might warrant some discussion in its own =

right. (Also it didn't make sense to make a patch to code that seemed to =

need fixing first).

FWIW, the Zoom R16 advertises a max packet size of 108 bytes for the =

capture direction. This is consistent with the 8 byte frame size that the =

device also advertises, taking into consideration the extra 4 byte =

descriptor (108 =3D 8 * 13 + 4).

The Zoom is not class compliant, it advertises itself as being vendor =

specific, so they could really use any format they want. It just so =

happens that it is standard PCM with the extra descriptor quirk.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
