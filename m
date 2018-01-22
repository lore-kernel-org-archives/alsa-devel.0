From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Maximum 50 dB gain in ALSA softvol plugin
Date: Mon, 22 Jan 2018 14:47:12 +0100
Message-ID: <alpine.DEB.2.11.1801221435420.12063@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.11.1801121645540.16471@lnxricardw1.se.axis.com>
 <s5ha7xj3ug4.wl-tiwai@suse.de>
 <alpine.DEB.2.11.1801151410060.2359@lnxricardw1.se.axis.com>
 <s5hd12b2q99.wl-tiwai@suse.de>
 <alpine.DEB.2.11.1801151446420.2359@lnxricardw1.se.axis.com>
 <s5h8tcz2pje.wl-tiwai@suse.de>
 <alpine.DEB.2.11.1801151520280.2359@lnxricardw1.se.axis.com>
 <s5hshb718wx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 745CC266B67
 for <alsa-devel@alsa-project.org>; Mon, 22 Jan 2018 14:47:19 +0100 (CET)
In-Reply-To: <s5hshb718wx.wl-tiwai@suse.de>
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


On Mon, 15 Jan 2018, Takashi Iwai wrote:

> OTOH, the amplification in softvol is really dumb, and such a high
> gain like 90dB is doubtful whether it's really useful.  As Jaroslav
> already suggested, we need a better setup to get more meaningful
> results.

Hi Takashi,

I didn't really get a definitive response to my elaboration last week =

regarding the maximum allowable gain value for the softvol plugin.

First of all, regarding the algorithm itself used, as it stands today it =

can handle a maximum of 90.3 dB gain without falling apart (as the gain =

factor is held in a signed integer). Changing the maximum allowable gain =

from 50 dB to 90 dB does not impact the algorithm or existing =

functionality in any way, it just changes the allowable maximum to =

correspond to the technical limit of the current algorithm. The limit is =

not visible to the user anyway until he tries to configure a max_dB that =

is above 50 (and then only in the shape of an error message). So from a =

purely technical viewpoint I cannot understand any opposition.

You mentioned that the amplification is really dumb, I'm not sure what the =

problem is, perhaps you could elaborate, essentially a gain is a =

multiplication with a gain factor, and that's what softvol does.

Another issue is if such a large gain is useful. I would say that is up to =

the user, and of course, if you have a weak signal to start with, with, =

say, only 8 bits of resolution, adding 90 dB of gain is going to mean =

there's a lot of noise bits there, but the signal quality is of course not =

worse than it was to start with, just louder, and that's how any signal =

(digital or analog) behaves when gain is added.

But the bottom line of course is that you are the maintainer. So what =

would you consider a reasonable maximum gain that's more than 50 dB. 70 =

dB?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
