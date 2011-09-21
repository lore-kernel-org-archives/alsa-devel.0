From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Re: Re: [PATCH 07/17] ASoC: twl6040: Lower the initial gains
Date: Wed, 21 Sep 2011 13:39:31 +0100
Message-ID: <20110921123931.GD4374@opensource.wolfsonmicro.com>
References: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
 <2033664.fWQvF2IA53@barack>
 <20110919114031.GI23727@opensource.wolfsonmicro.com>
 <2240573.6cRWXtKJB6@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2240573.6cRWXtKJB6@barack>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: Samuel Ortiz <samuel.ortiz@intel.com>, Dmitry Torokhov <dtor@mail.ru>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 21, 2011 at 12:22:26PM +0300, P=E9ter Ujfalusi wrote:

> The implementation in twl6040 looks similar to the one in the wm8350 =
in=20
> regards to the ramp code, and caching of the user configured gains.

Yes, it was copied from there.

> If you take a look at the wm8350 driver it is also changing the L/R O=
UT 1/2=20
> registers at probe time.
> I don't see any difference in the two.

The key problem here is that you sent a change saying "change the
default volume" with no other context in either the changelog or the
code.  If you've got code that's actively managing the volume register
while presenting a nice view to the application layer so that the
register value isn't directly seen in the way it is for standard ASoC
controls that's a very different thing to standard code.  I'm not going
to remember the details of everything in every CODEC driver.

> We do have other scenarios covered, but this initialization was missi=
ng. This=20
> resulted that the _first_ playback has pop noise, but all subsequent =
playbacks=20
> were fine, since we had the runtime fix for this.

So what you're doing here is really a bug fix for the ramping code.
