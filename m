From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC v2 10/13] sound/core: add DRM ELD helper
Date: Fri, 8 May 2015 16:37:29 +0300
Message-ID: <554CBC19.6000701@ti.com>
References: <20150402092050.GH24899@n2100.arm.linux.org.uk>
 <E1YdbKA-00085Q-LL@rmk-PC.arm.linux.org.uk>
 <34627ba55428fd0dd821d99a5326e451@kapsi.fi>
 <20150508132701.GJ2067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 16249265D2B
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2015 15:37:35 +0200 (CEST)
In-Reply-To: <20150508132701.GJ2067@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Jyri Sarha <jyri.sarha@iki.fi>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Yakir Yang <ykk@rock-chips.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 05/08/15 16:27, Russell King - ARM Linux wrote:
> On Fri, May 08, 2015 at 04:16:08PM +0300, Jyri Sarha wrote:
>> On 2015-04-02 12:22, Russell King wrote:
...
>> For what I can see, you are setting the cross dependency between
>> the sample rate and channels incorrectly.
>
> There is a dependency between sample rate and channels.
>
>> You should look for the
>> currently tested channel count directly from hw params.
>
> I'm not so sure that's right after looking at snd_ac97_pcm_double_rate_rules().
> That's pretty much the same problem - AC'97 codecs can operate at a
> sample rate of either the bus frame frequency or twice the bus frame
> frequency.
>

Maybe digging the channels from intervals works too, I have just never
used that myself. The param_channels() works too and it is slightly simpler.
