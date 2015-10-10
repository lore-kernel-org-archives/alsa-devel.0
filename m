From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH v2] ALSA: usb-audio: Fix max packet size
 calculation for USB audio
Date: Sat, 10 Oct 2015 20:12:33 +0200
Message-ID: <alpine.DEB.2.02.1510102010390.27509@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1510100012390.7332@lnxricardw1.se.axis.com>
 <5618D0E1.1000308@ladisch.de>
 <alpine.DEB.2.02.1510101724440.26426@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id D03DC2604DF
 for <alsa-devel@alsa-project.org>; Sat, 10 Oct 2015 20:12:37 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1510101724440.26426@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org


On Sat, 10 Oct 2015, Ricard Wanderlof wrote:

> > That code was intended to round correctly, but it's obviously wrong
> > because the result is not an integer multiple of the frame size.
> =

> If that is the case we need to do something like
> =

> maxsize =3D (((freqn + 0xffff) & 0xffff0000) * frame_size) >> 16

Or, much simpler, I realized later:

maxsize =3D ((freqn + 0xffff) >> 16) * frame_size

i.e. we make the conversion from Q16.16 to integer before multiplying with =

the frame size to automatically get the rounding as intended.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
