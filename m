From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v3] ARM: kirkwood: extend the kirkwood i2s
 driver for DT usage
Date: Tue, 23 Jul 2013 15:30:57 +0200
Message-ID: <51EE8591.7060005@gmail.com>
References: <20130723104615.3696f1a9@armhf>
 <20130723123444.GW9858@sirena.org.uk> <51EE7E1A.3040301@gmail.com>
 <20130723132016.GC9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f54.google.com (mail-bk0-f54.google.com
 [209.85.214.54])
 by alsa0.perex.cz (Postfix) with ESMTP id F1D2426501B
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 15:31:01 +0200 (CEST)
Received: by mail-bk0-f54.google.com with SMTP id it16so2931924bkc.41
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 06:31:01 -0700 (PDT)
In-Reply-To: <20130723132016.GC9858@sirena.org.uk>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Liam Girdwood <lgirdwood@gmail.com>, devicetree-discuss@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On 07/23/13 15:20, Mark Brown wrote:
> On Tue, Jul 23, 2013 at 02:59:06PM +0200, Sebastian Hesselbarth wrote:
>> On 07/23/13 14:34, Mark Brown wrote:
>
>>> As others have pointed out if you need to change the clock get code
>>> there's something wrong here, DT should be handled transparently by the
>>> clock API.
>
>> IMHO the reason why of_clk_get() was/is mis-used in that way is mostly
>> compatibility with legacy platform_data based setup.
>
> I'm sorry, but this doesn't make a great deal of sense to me.  Can you
> be more specific?
 >
>> As Sascha Hauer pointed out, clocks should be distinguished by names
>> (clock-names property) instead of position and then use
>> devm_clk_get(&pdev->dev, "internal") and
>> devm_clk_get(&pdev->dev, "external") respectively.
>
>> This will possibly also require to update platform_data and legacy
>> users of kirkwood-i2s or have different setup functions for non-DT
>> and DT.
>
> Why would this be required?  The driver is already asking for multiple
> clocks...

The driver is asking for multiple *DT based* clocks. Legacy
platform_data has never been updated to reflect that. Mainly because
multiple clocks are only supported on Dove, which has no active non-DT
board in mainline.

>> Also, while ASoC API separates the audio-controller into cpu-side
>> and codec-side parts, the DT should not. IIRC and as Russell repeated
>
> You mean DAI and DMA here?  I already commented on that in my review of
> the DMA binding.

Yes.

>> again, we mentioned to merge kirkwood-i2s.c and kirkwood-dma.c into
>> a single file, didn't we?
>
> That's been discussed several times but nobody's actually done it.

Correct, that is why I repeated that request to Jean-Francois.

Sebastian
