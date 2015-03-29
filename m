From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH][ASoC]Add ability to remove rate
 constraints from generic ASoC AC'97 CODEC driver
Date: Sun, 29 Mar 2015 18:00:33 +0200
Message-ID: <551821A1.5030902@maciej.szmigiero.name>
References: <54FF7E13.4060801@maciej.szmigiero.name>
 <20150322182744.GB6643@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DD9526049A
 for <alsa-devel@alsa-project.org>; Sun, 29 Mar 2015 18:00:45 +0200 (CEST)
In-Reply-To: <20150322182744.GB6643@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, Wolfram Sang <wsa@the-dreams.de>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Thanks for looking into the patch.

W dniu 22.03.2015 19:27, Mark Brown pisze:
> On Wed, Mar 11, 2015 at 12:28:19AM +0100, Maciej S. Szmigiero wrote:
>> Add ability to remove rate constraints from generic ASoC AC'97 CODEC
>> driver via passed platform data, make it selectable in config.
> 
> Please use subject lines matching the style for the subsystem.  This is
> helpful for identifying relevant patches and not getting your messages
> deleted unread...

I assume "[PATCH] ASoC: driver: subject" format would be right?

>> This way this driver can be used for platforms which don't need
>> specialized AC'97 CODEC drivers while at the same avoiding
>> code duplication from implementing equivalent functionality in
>> a controller driver.
> 
> I'm sorry but this just doesn't explain what this patch is intended to
> accomplish.  If we can talk to the AC'97 CODEC at all we can already
> identify whatever constraints it has by looking at the ID registers so
> it's not clear when or why a platform would need to use this.  It feels
> like there is some underlying problem that you're trying to address.

This patch itself is supposed to allow using this CODEC driver with
CODECs that support other rates that these that were already hard-coded
in the driver (8000, 11025, 22050, 44100, 48000).

In general sense what I want to accomplish is to add sound support for
UDOO board to the mainline kernel.
It uses i.MX6 SSI core as controller with VT1613 AC'97 codec.

While it would be possible to simply add ac97 bus enumeration to
either fsl_ssi driver or fsl-asoc-card sound card driver it looks to me
that even in this case a platform device for codec would need to be
registered anyway.

This is because as far I see ASoC CODEC DAIs in links are identified
either by OF node or name of their platform device.
I've already tried to accomplish all of this via adding OF node of
AC'97 codec but such patch was rejected.

If the ac97 bus enumeration is added to fsl_ssi driver then there is
also a problem of communicating a name of ac97 platform device
to sound card driver so it can then reference it in DAI links
that it builds.
If such name would be hardcoded then there would be a possibility to
use only one such CODEC in the system
(this SoC theoretically allows up to three).

And, naturally, this would result in a small code duplication with
regard to this generic driver.

Best regards,
Maciej Szmigiero
