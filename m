From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH 1/2] snd-maestro3: Make hardware volume
 buttons an input device (rev2)
Date: Fri, 7 May 2010 00:10:02 +0300
Message-ID: <20100506211002.GG6861@sci.fi>
References: <1272014803-10706-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from filtteri2.pp.htv.fi (filtteri2.pp.htv.fi [213.243.153.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E0EC10380A
	for <alsa-devel@alsa-project.org>;
	Thu,  6 May 2010 23:10:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1272014803-10706-1-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 23, 2010 at 05:26:42AM -0400, Hans de Goede wrote:
> While working on the sound suspend / resume problems with my laptop
> I noticed that the hardware volume handling code in essence just detects
> key presses, and then does some hardcoded modification of the master volu=
me
> based on which key is pressed.
> =

> This made me think that clearly the right thing to do here is just report
> these keypresses to userspace and let userspace decide what to with them.
> =

> This patch adds a Kconfig option which when enabled reports the volume
> buttons as keypresses using an input device. When enabled this option
> also gets rid of the ugly direct ac97 writes from the tasklet, the ac97lo=
ck
> and the need for using a tasklet in general.
> =

> As an added bonus the keys now work identical to volume keys on a (usb)
> keyboard with multimedia keys, providing visual feedback of the volume
> level change, and a better range of the volume control (with a properly
> configured desktop environment).
> =

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Tested-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>

Both SND_MAESTRO3_INPUT=3Dy and SND_MAESTRO3_INPUT=3Dn work fine on my HP
OmniBook 500.

There is one small issue though. I get a spurious key event when I load
the driver. Probably the omnibook GPIO magic causes a spurious event
which then causes the interrupt since the driver doesn't clear the
interrupts before enabling them. I'll send a patch for that.

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
