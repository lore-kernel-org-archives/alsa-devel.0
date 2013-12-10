From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH V2] ASoC: add RT286 CODEC driver
Date: Tue, 10 Dec 2013 10:46:19 +0800
Message-ID: <1121E117AD4ECE49880A389A396215BB939A8268C6@rtitmbs7.realtek.com.tw>
References: <1386164488-32227-1-git-send-email-bardliao@realtek.com>
 <201312100141.rBA1fv6q001271@rtits1.realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 198CE26510F
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 03:46:26 +0100 (CET)
In-Reply-To: <201312100141.rBA1fv6q001271@rtits1.realtek.com>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Leon Romanovsky [mailto:leon@leon.nu]
> Sent: Wednesday, December 04, 2013 10:37 PM
> To: Bard Liao
> Cc: Mark Brown; Liam Girdwood; Oder Chiou; alsa-devel@alsa-project.org;
> Flove
> Subject: Re: [alsa-devel] [PATCH V2] ASoC: add RT286 CODEC driver
> 
> On Wed, Dec 4, 2013 at 3:41 PM,  <bardliao@realtek.com> wrote:
> > From: Bard Liao <bardliao@realtek.com>
> >
> > This patch adds the ALC286 codec driver.
> >
> > Signed-off-by: Bard Liao <bardliao@realtek.com>
> >
> 
> Please add change log while you are sending verX patch.

Please see the change log as below.
* Add platform data to determine if combo jack and/or IRQ is using or not.
* Implement rt286_hw_read/write in regmap.
* Configure codec in runtime instead of in probe.
* Other minor changes (coding style, remove version control, remove empty functions, share code ...)

Should I send another patch with these change log?

> 
> 
> > +
> > +static unsigned int rt286_reg_cache[TOTAL_NODE_ID + 1] = {
> You don't need TOTAL_NODE_ID + 1 in array declaration.

Without "TOTAL_NODE_ID + 1", I should always set [NODE_ID_MIXER_IN2] = 0x0000, right?
Ie. Assign the latest array item a value.

> 
> > +       [NODE_ID_DAC_OUT1] = 0x7f7f,
> > +       [NODE_ID_DAC_OUT2] = 0x7f7f,
> > +       [NODE_ID_SPDIF] = 0x0000,
> > +       [NODE_ID_ADC_IN1] = 0x4343,
> > +       [NODE_ID_ADC_IN2] = 0x4343,
> > +       [NODE_ID_MIC1] = 0x0000,
> > +       [NODE_ID_MIXER_IN] = 0x000b,
> > +       [NODE_ID_MIXER_OUT1] = 0x0002,
> > +       [NODE_ID_MIXER_OUT2] = 0x0000,
> > +       [NODE_ID_SPK_OUT] = 0x0000,
> > +       [NODE_ID_HP_OUT] = 0x0000,
> > +       [NODE_ID_MIXER_IN1] = 0x0000,
> > +       [NODE_ID_MIXER_IN2] = 0x0000,
> > +};

Thanks.
