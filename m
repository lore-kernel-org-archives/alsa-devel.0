From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Subject: Re: [PATCH v5] ASoC: TSCS42xx: Add support for Tempo
 Semiconductor's TSCS42xx audio CODEC
Date: Sun, 17 Dec 2017 13:23:21 -0600
Message-ID: <20171217192320.hpdgx5ncgmaefhd7@localhost.localdomain>
References: <20171211195403.3irxp7g3n326ub3g@localhost.localdomain>
 <20171212163254.GL16323@sirena.org.uk>
 <20171212213114.n5pcgy6q6m3qu5s4@localhost.localdomain>
 <20171214093244.udrjwgfvpxpc3jq7@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 by alsa0.perex.cz (Postfix) with ESMTP id D63E6266E15
 for <alsa-devel@alsa-project.org>; Sun, 17 Dec 2017 20:23:32 +0100 (CET)
Received: by mail-oi0-f67.google.com with SMTP id x20so9309597oix.12
 for <alsa-devel@alsa-project.org>; Sun, 17 Dec 2017 11:23:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171214093244.udrjwgfvpxpc3jq7@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 14, 2017 at 09:32:44AM +0000, Charles Keepax wrote:

> Not sure what you mean here but setting up CODEC registers
> directly from the machine driver is probably not ideal. You
> should probably be looking into regmap_register_patch this lets
> you apply a bunch of register settings to the chip every time you
> do a regmap_cache_sync. This is useful for situations like the
> chip has terrible register defaults you want to correct.

I ended up using your suggestion with regmap_register_patch in v6. I
experimented a bit with handling all the interface configurations and it
ultimately became too complex since we would need to handle cases where
there could be one synchronous interface or two asynchronous interfaces that
only have capture or playback. Typically we have only seen uses where
there is one synchronous interface where adc and dac run at the same
rate and on other parts we have sample rate converters that allow capture
and playback to run at different rates. The default value here was
infact not very sane since it is the least used, so the patch method was
very useful in this case. Thanks for the input.
