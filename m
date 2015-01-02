From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v8 0/2] ASoC: tda998x: add a codec to the
	HDMI transmitter
Date: Fri, 2 Jan 2015 12:09:45 +0200
Message-ID: <54A66E69.8020506@ti.com>
References: <cover.1414053169.git.moinejf@free.fr>
 <20141229165246.GZ17800@sirena.org.uk> <54A19151.3090506@ti.com>
 <20141230170001.GO17800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id AF1A2260483
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 11:09:51 +0100 (CET)
In-Reply-To: <20141230170001.GO17800@sirena.org.uk>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, Andrew Jackson <Andrew.Jackson@arm.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Dave Airlie <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12/30/2014 07:00 PM, Mark Brown wrote:
> On Mon, Dec 29, 2014 at 07:37:21PM +0200, Jyri Sarha wrote:
>> On 12/29/2014 06:52 PM, Mark Brown wrote:
>
>>> So, I'm not seeing *any* interest here from any other HDMI users.  This
>>> is a continuing theme with HDMI patches and is really very concerning,
>>> everyone appears to be working in their own bubbles coming up with their
>>> own things and ignoring everyone else's work - what little review I'm
>
>> I have not seen any significant new development since v7 of these patches.
>> My comments for v6 were mostly[1] addressed and I can live with these
>> changes, even develop this approach further if it gets merged.
>
> OK, so this sort of feedback is really useful - even a qualified
> Reviwed-by is useful.  Total silence could mean anything.
>
>> However, as a general note I see a need for a generic ASoC hdmi codec
>> abstraction and I don't think this is generic enough. More of the audio
>> specific implementation and HDMI standard specific things should be pushed
>> away from the hdmi encoder driver (tda998x in this case) to the generic ASoC
>> side hdmi codec driver (or library).
>
> This is something I'm expecting, yes - what I don't have is a clear
> enough picture of how consistent the different hardware is in how it
> models these things.
>

After taking another look the patchesthere is not much functionality 
that could be moved away from tda998x. It is just that the ASoC side 
(and tda998x) could do more in terms of HDMI standard, but that is fine 
because all that stuff can be added later if/when needed. However, 
instantiating snd_soc_dai_driver etc. in DRM side makes a nasty 
dependency between DRM and ASoC. All that stuff could be in ASoC side 
and simple enum/bitfield parameters defining i2s/spdif selection could 
be passed between DRM and ASoC side.


>> [1] I personally do not like the hdmi_get_cdev() approach. I would rather go
>> with only a library for registering from ASoC codec component under the HDMI
>> encoder device or a completely separate device with only a reference to the
>> HDMI encoder.
>
> It does seem somewhat complicated, yes.  I don't know if matches idioms
> for DRM somehow?
>

Me neither. A more straight forward option would be adding an "audio 
header" to the beginning of hdmi encoders drvdata. However, it would be 
tempting to add a pointer for drvdata to snd_soc_dai_driver to add audio 
specific driver data to any device that provides a DAI in addition to 
other functionality. It could even simplify drivers for some audio only 
devices with multiple DAIs.

Best regards,
Jyri
