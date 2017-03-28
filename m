From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: imx-wm8962: Fix codec_clk
	cleanup
Date: Tue, 28 Mar 2017 13:47:04 +0300
Message-ID: <CAEnQRZAx1o9xtbf3u1A_Zun7MSaJjdjunpJm1Q6=ZAA3beoFbA@mail.gmail.com>
References: <1490691532-2086-1-git-send-email-daniel.baluta@nxp.com>
 <1490691532-2086-3-git-send-email-daniel.baluta@nxp.com>
 <20170328092103.GQ6986@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
 [209.85.214.66])
 by alsa0.perex.cz (Postfix) with ESMTP id EBC6F266DE1
 for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2017 12:47:06 +0200 (CEST)
Received: by mail-it0-f66.google.com with SMTP id 76so2488055itj.0
 for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2017 03:47:06 -0700 (PDT)
In-Reply-To: <20170328092103.GQ6986@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@tabi.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, fabio.estevam@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 28, 2017 at 12:21 PM, Charles Keepax
<ckeepax@opensource.wolfsonmicro.com> wrote:
> On Tue, Mar 28, 2017 at 11:58:52AM +0300, Daniel Baluta wrote:
>> Resource managed devm_clk_get only works with platform's device dev.
>>
>
> I feel like this could use an explaination of why not using devm
> is the correct fix, rather than just using the platform device
> for the call. Its not obvious to me, that using the platform
> device would be an issue.

Hi Charles,

I see where the confusion comes from :) and I thought the explanation
is obvious from the code, see inline comments.

Would an explanation like the one below, work better?

" We cannot use devm_clk_get with &codec_dev->dev device because
the kernel uses pdev->dev to free the managed resources, so we will end
up with a leaking codec_clk reference"

>> @@ -231,7 +231,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
>>               goto fail;
>>       }

pdev->dev from here:

>>
>> -     codec_clk = devm_clk_get(&codec_dev->dev, NULL);
>> +     codec_clk = clk_get(&codec_dev->dev, NULL);

is different from &codec_dev->dev.

>>       if (IS_ERR(codec_clk)) {
>>               ret = PTR_ERR(codec_clk);
>>               dev_err(&codec_dev->dev, "failed to get codec clk: %d\n", ret);
>> @@ -239,6 +239,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
>>       }
>>
>>       data->clk_frequency = clk_get_rate(codec_clk);
>> +     clk_put(codec_clk);
>>
>>       data->dai.name = "HiFi";
>>       data->dai.stream_name = "HiFi";

thanks,
Daniel.
