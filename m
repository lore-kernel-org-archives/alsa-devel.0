From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: tegra: Add platform driver for
	rt5677 audio codec
Date: Mon, 29 Dec 2014 05:25:59 -0800
Message-ID: <CAOMFOmW5BL4HpzC9Q32Q48s90Mnd0cqM5np8gH5RxZEXCAEEdw@mail.gmail.com>
References: <1419362942-26192-1-git-send-email-anatol.pomozov@gmail.com>
 <20141226163826.GD17800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f181.google.com (mail-lb0-f181.google.com
 [209.85.217.181])
 by alsa0.perex.cz (Postfix) with ESMTP id EF905261AB0
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 14:25:59 +0100 (CET)
Received: by mail-lb0-f181.google.com with SMTP id l4so10695866lbv.40
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 05:25:59 -0800 (PST)
In-Reply-To: <20141226163826.GD17800@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, Bard Liao <bardliao@realtek.com>, Laurent Dahan <ldahan@nvidia.com>, Dylan Reid <dgreid@google.com>
List-Id: alsa-devel@alsa-project.org

Hi

On Fri, Dec 26, 2014 at 8:38 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Dec 23, 2014 at 11:29:01AM -0800, Anatol Pomozov wrote:
>
>> +static int tegra_rt5677_probe(struct platform_device *pdev)
>> +{
>> +     struct device_node *np = pdev->dev.of_node;
>> +     struct snd_soc_card *card = &snd_soc_tegra_rt5677;
>> +     struct tegra_rt5677 *machine;
>> +     int ret;
>> +
>> +#if defined(CONFIG_MODULES) && defined(MODULE)
>> +     request_module("snd_soc_tegra30_i2s");
>> +#endif
>
> What's this all about then?

Sorry, my question was not clear. I meant is it ok to put this
request_module() to upstream code? If not then just remove it before
merging my patch.
