From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Maximum 50 dB gain in ALSA softvol plugin
Date: Mon, 15 Jan 2018 14:14:13 +0100
Message-ID: <alpine.DEB.2.11.1801151410060.2359@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.11.1801121645540.16471@lnxricardw1.se.axis.com>
 <s5ha7xj3ug4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 013B3267574
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 14:14:21 +0100 (CET)
In-Reply-To: <s5ha7xj3ug4.wl-tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Fri, 12 Jan 2018, Takashi Iwai wrote:

> > The ALSA softvol plugin has a maximum gain of 50 dB (MAX_DB_UPPER_LIMIT=
 is =

> > fixed to 50 in pcm/pcm_softvol.c). Is there some technical reason for t=
his =

> > limit? These days when >16 bit audio is becoming common, it's not =

> > unreasonable to have large gain figures, and that is in fact a usecase =
I =

> > have right now.
> > =

> > I'm looking through the CONVERT_AREA and MULTI_DIV_foo macros to see if =

> > there's something there that degenerates when the gain factor becomes t=
oo =

> > large, but I'd thought I'd ask too rather than just do reverse =

> > engineering.
> =

> There is no more reason than "some reasonable limit".

Ok, my suggestion would be set MAX_DB_UPPER_LIMIT to 90 dB. 90 dB comes =

out as 31622, which still is manageable when shifted up by VOL_SCALE_SHIFT =

(=3D 16), fitting in a 32-bit int. Thus it works in MULTI_DIV_short() too, =

where it is multiplied with the 16-bit sample value yielding an int.

I'll try it out and prepare a patch.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
