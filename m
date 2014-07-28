From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: ASoC: Device tree binding to dummy codec
Date: Mon, 28 Jul 2014 12:47:09 -0400
Message-ID: <CAKON4Ow6AfdunEq54f7U7YLrAhmiYeuAfHaAWq+ktoE1bYYGDQ@mail.gmail.com>
References: <CAKON4Oynu5HE-jDETrNRBY3dYtwuh6XmOgyDOQuc4jmCzmNhNg@mail.gmail.com>
 <53D5ECA7.5090106@metafoo.de>
 <20140728112055.GM17528@sirena.org.uk>
 <CAKON4OzXfq+gDLdzs0VYh+X+4RBU=2Nds45P7+kBd+02eY+zHA@mail.gmail.com>
 <CAKON4Owhhw6WvJBvZC6KYpS+rtvbPymAqEb1+4iZ=e6OokGeng@mail.gmail.com>
 <20140728162715.GZ17528@sirena.org.uk>
 <CAKON4OzrDeEbjzAgpB7f3NYcXGegUnF2+Hb1QZeZYKwztctkvg@mail.gmail.com>
 <20140728163645.GA17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f174.google.com (mail-lb0-f174.google.com
 [209.85.217.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 55D77265125
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 18:47:10 +0200 (CEST)
Received: by mail-lb0-f174.google.com with SMTP id c11so6037442lbj.33
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 09:47:09 -0700 (PDT)
In-Reply-To: <20140728163645.GA17528@sirena.org.uk>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 28, 2014 at 12:36 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jul 28, 2014 at 12:33:57PM -0400, jonsmirl@gmail.com wrote:
>
>> So what do you want the device tree to look like?
>> Example with no external amp.
>> Example with external amp.
>
> To repeat what I said in a previous mail:

I see the aux binding in soc-core.c
Where is an example of how to use it in a device tree?

None of these are used in a device tree that I can spot..
omap/rx51.c:static struct snd_soc_aux_dev rx51_aux_dev[] = {
omap/rx51.c: .aux_dev = rx51_aux_dev,
omap/rx51.c: .num_aux_devs = ARRAY_SIZE(rx51_aux_dev),
omap/rx51.c: rx51_aux_dev[0].codec_name = NULL;
omap/rx51.c: rx51_aux_dev[0].codec_of_node = dai_node;
samsung/speyside.c:static struct snd_soc_aux_dev speyside_aux_dev[] = {
samsung/speyside.c: .aux_dev = speyside_aux_dev,
samsung/speyside.c: .num_aux_devs = ARRAY_SIZE(speyside_aux_dev),
samsung/neo1973_wm8753.c:static struct snd_soc_aux_dev neo1973_aux_devs[] = {
samsung/neo1973_wm8753.c: .aux_dev = neo1973_aux_devs,
samsung/neo1973_wm8753.c: .num_aux_devs = ARRAY_SIZE(neo1973_aux_devs),
samsung/neo1973_wm8753.c: neo1973.num_aux_devs = 1;




>
> | Just the same as any other card - allow a phandle to be provided to the
> | amplifier.
>
> | Assuming "jack populations" are DAPM links just do it the same way as
> | anything else and use snd_soc_of_parse_audio_routing().



-- 
Jon Smirl
jonsmirl@gmail.com
