From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH][ASoC]Add ability to remove rate
 constraints from generic ASoC AC'97 CODEC driver
Date: Sun, 05 Apr 2015 00:16:40 +0200
Message-ID: <552062C8.80103@maciej.szmigiero.name>
References: <54FF7E13.4060801@maciej.szmigiero.name>
 <20150322182744.GB6643@sirena.org.uk>
 <551821A1.5030902@maciej.szmigiero.name>
 <20150330041935.GA1568@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C692260593
 for <alsa-devel@alsa-project.org>; Sun,  5 Apr 2015 00:16:54 +0200 (CEST)
In-Reply-To: <20150330041935.GA1568@sirena.org.uk>
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

W dniu 30.03.2015 06:19, Mark Brown pisze:
> On Sun, Mar 29, 2015 at 06:00:33PM +0200, Maciej S. Szmigiero wrote:
>> W dniu 22.03.2015 19:27, Mark Brown pisze:
> 
>>> Please use subject lines matching the style for the subsystem.  This is
>>> helpful for identifying relevant patches and not getting your messages
>>> deleted unread...
> 
>> I assume "[PATCH] ASoC: driver: subject" format would be right?
> 
> Yes.

Thanks for information.

>>> I'm sorry but this just doesn't explain what this patch is intended to
>>> accomplish.  If we can talk to the AC'97 CODEC at all we can already
>>> identify whatever constraints it has by looking at the ID registers so
>>> it's not clear when or why a platform would need to use this.  It feels
>>> like there is some underlying problem that you're trying to address.
> 
>> This patch itself is supposed to allow using this CODEC driver with
>> CODECs that support other rates that these that were already hard-coded
>> in the driver (8000, 11025, 22050, 44100, 48000).
> 
> You're talking about Linux internal implementation details here but the
> change you are proposing a change to the device tree?  Like I think I
> said in reply to a previous iteration of this patch we can clearly
> enumerate the required information from the hardware already.
> 
>> While it would be possible to simply add ac97 bus enumeration to
>> either fsl_ssi driver or fsl-asoc-card sound card driver it looks to me
>> that even in this case a platform device for codec would need to be
>> registered anyway.
> 
> That's the way the ASoC AC'97 support currently works, yes.
> 
>> If the ac97 bus enumeration is added to fsl_ssi driver then there is
>> also a problem of communicating a name of ac97 platform device
>> to sound card driver so it can then reference it in DAI links
>> that it builds.
> 
> ...
> 
>> And, naturally, this would result in a small code duplication with
>> regard to this generic driver.
> 
> This sounds like something that can easily be put in some generic code
> and either used as a helper library by the drivers or just done directly
> from the framework when it knows it's dealing with an AC'97 bus.
> 
> Alternatively if you're just trying to open up the constraints why not
> just open them up by default and make sure that the AC'97 generic code
> is constraining things appropriately if it's not doing so already?

By 'open them up by default' do you mean removing them altogether 
from ASOC AC'97 generic CODEC to let the AC'97 bus driver constrain
rates on its own or do you mean retaining ability to constraint in
ASOC AC'97 driver, just have it switched off by default?
(that is, what the current patch did, just change the default setting).

If the rate constraints are removed (or disabled) from the ASOC AC'97
generic CODEC driver then it can be used as-is in the (at least) fsl_ssi
driver by registering AC'97 platform device there using index taken from
DT property (cell-index) already defined as required in
Documentation/devicetree/bindings/sound/fsl,ssi.txt.

This way the AC'97 CODECs can be uniquely identified in case there is more
than one in the system.

Sadly, despite this property being marked as required in documentation no
current DT file seems to define it.

Now the question is what is more binding: the documentation which
defines this property as required or DT files which don't define it at all?

Best regards,
Maciej Szmigiero
