From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: [PATCH] asoc: add dummy codec
Date: Thu, 11 Apr 2013 08:48:08 -0700
Message-ID: <5166DB38.1010706@gmail.com>
References: <51669249.8090100@list.ru> <51669353.7090903@metafoo.de>
 <5166D295.2070400@list.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
 [209.85.192.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A5BA2610AF
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 17:48:12 +0200 (CEST)
Received: by mail-pd0-f179.google.com with SMTP id x11so916781pdj.38
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 08:48:12 -0700 (PDT)
In-Reply-To: <5166D295.2070400@list.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stas Sergeev <stsp@list.ru>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Steve Chen <schen@mvista.com>
List-Id: alsa-devel@alsa-project.org

On 04/11/2013 08:11 AM, Stas Sergeev wrote:
>> There is already a dummy codec driver.
>>
>> Please take a look at sound/soc/soc-utils.c
>>
>> - Lars
> Lars, indeed, this codec is present in a git kernel and
> it wasn't in mine android kernel.
> But, that driver is too dummy to even work at all.
> 
> The attached patch adds a playback stream for the dummy
> codec. Would it be possible to apply this?

No... not like that.

Instead, wouldn't it be better to extend it by defining some platform data?  Maybe something like:

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index fe4541d..9d22718 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -96,9 +96,14 @@ static struct snd_soc_dai_driver dummy_dai = {
 
 static int snd_soc_dummy_probe(struct platform_device *pdev)
 {
+       struct snd_soc_dummy_dai_pdata *pdata = dev_get_platdata(&pdev->dev);
        int ret;
 
-       ret = snd_soc_register_codec(&pdev->dev, &dummy_codec, &dummy_dai, 1);
+       if (pdata->n_dai > 0)
+               ret = snd_soc_register_codec(&pdev->dev, &dummy_codec,
+                                            &pdata->dai, &pdata->n_dai);
+       else
+               ret = snd_soc_register_codec(&pdev->dev, &dummy_codec, &dummy_dai, 1);
        if (ret < 0)
                return ret;
 

...then you can define whatever kind of DAI you want in the machine driver.

-gabriel
