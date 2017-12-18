From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH for-4.15] ASoC: rt5514: don't assume rt5514
 component was "attached"
Date: Mon, 18 Dec 2017 09:42:36 -0800
Message-ID: <20171218174235.GA113663@google.com>
References: <20171216011230.107527-1-briannorris@chromium.org>
 <20171216031738.GA220575@google.com>
 <CAFv8Nw+qiWedqZeVsPn17WiSyc_zwOP3bEnxn2Wc-oQ3ntgq2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f68.google.com (mail-it0-f68.google.com
 [209.85.214.68])
 by alsa0.perex.cz (Postfix) with ESMTP id E795A267544
 for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2017 18:42:41 +0100 (CET)
Received: by mail-it0-f68.google.com with SMTP id t1so29153219ite.5
 for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2017 09:42:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAFv8Nw+qiWedqZeVsPn17WiSyc_zwOP3bEnxn2Wc-oQ3ntgq2g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cheng-yi Chiang <cychiang@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Matthias Kaehlcke <mka@chromium.org>
List-Id: alsa-devel@alsa-project.org

Hi!

(By the way, your mail is HTML and likely will get rejected by many
mailing lists and/or people reading these mailing lists.)

On Mon, Dec 18, 2017 at 12:23:18PM +0800, Cheng-yi Chiang wrote:
>    Hi Brian,
>      Oder has posted the same fix : [1]https://patchwork.kernel.org/
>    patch/10066257/ and it has been applied.

OK cool. Obviously I'm biased, but I prefer mine, as it has less
needless whitespace, and is appropriately documented ;) But it should be
a fine replacement.

>    Perhaps you can cherry-pick it to v4.15 ?

I have no say in that; that would be up to Mark, I think. It's most
certainly a regression in 4.15-rc1, so IMO it should be given a proper
'Fixes: e9c50aa6bd39 ("ASoC: rt5514-spi: check irq status to schedule
data copy in resume function")' tag and sent for 4.15, not 4.16.

Brian
