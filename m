From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/1] ALSA: hda - add quirk for Thinkpad T430
Date: Fri, 19 Oct 2012 12:54:21 -0700
Message-ID: <20121019195421.GC4787@elie.Belkin>
References: <cover.1350570761.git.joseph.salisbury@canonical.com>
 <fe78ea8daff3d5a41b6e1c78fb527894da6ad71e.1350570761.git.joseph.salisbury@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fe78ea8daff3d5a41b6e1c78fb527894da6ad71e.1350570761.git.joseph.salisbury@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joseph.salisbury@canonical.com
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, perex@perex.cz, tiwai@suse.de, david.henningsson@canonical.com, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

joseph.salisbury@canonical.com wrote:

> This patch adds a quirk to enable headphone jack audio on T430 Thinkp=
ads.
>
> Signed-off-by: Joseph Salisbury <joseph.salisbury@canonical.com>
> Cc: <stable@vger.kernel.org>

Thanks --- this is a little better.

One more nit: it looks like this was reported, tested, and based on a
patch by Stefan Freyr.  Takashi, could you amend the message to
reflect that, or should the patch be resent?

Something like

-- >8 --
=46rom: Stef=C3=A1n Freyr <stefan.freyr@gmail.com>
Subject: ALSA: hda - add dock support for Thinkpad T430

I have a Lenovo ThinkPad T430 and an UltraBase Series 3 docking
station.

Without this patch, if I plug my headphones into the jack on the
computer, everything works fine. The computer speakers mute and the
audio is played in the headphones. However, if I plug into the docking
station headphone jack the computer speakers are muted but there is no
audio in the headphones.

Addresses https://bugs.launchpad.net/bugs/1060372

Signed-off-by: Joseph Salisbury <joseph.salisbury@canonical.com>
Cc: stable@vger.kernel.org
