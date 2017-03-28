From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 2/2] ASoC: imx-wm8962: Fix codec_clk
 cleanup
Date: Tue, 28 Mar 2017 12:53:06 +0100
Message-ID: <20170328115306.GR6986@localhost.localdomain>
References: <1490691532-2086-1-git-send-email-daniel.baluta@nxp.com>
 <1490691532-2086-3-git-send-email-daniel.baluta@nxp.com>
 <20170328092103.GQ6986@localhost.localdomain>
 <CAEnQRZAx1o9xtbf3u1A_Zun7MSaJjdjunpJm1Q6=ZAA3beoFbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 62C3026648D
 for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2017 13:52:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAEnQRZAx1o9xtbf3u1A_Zun7MSaJjdjunpJm1Q6=ZAA3beoFbA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@tabi.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, fabio.estevam@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 28, 2017 at 01:47:04PM +0300, Daniel Baluta wrote:
> On Tue, Mar 28, 2017 at 12:21 PM, Charles Keepax
> <ckeepax@opensource.wolfsonmicro.com> wrote:
> > On Tue, Mar 28, 2017 at 11:58:52AM +0300, Daniel Baluta wrote:
> >> Resource managed devm_clk_get only works with platform's device dev.
> >>
> >
> > I feel like this could use an explaination of why not using devm
> > is the correct fix, rather than just using the platform device
> > for the call. Its not obvious to me, that using the platform
> > device would be an issue.
> 
> Hi Charles,
> 
> I see where the confusion comes from :) and I thought the explanation
> is obvious from the code, see inline comments.
> 
> Would an explanation like the one below, work better?
> 
> " We cannot use devm_clk_get with &codec_dev->dev device because
> the kernel uses pdev->dev to free the managed resources, so we will end
> up with a leaking codec_clk reference"
> 
> >> @@ -231,7 +231,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
> >>               goto fail;
> >>       }
> 
> pdev->dev from here:
> 
> >>
> >> -     codec_clk = devm_clk_get(&codec_dev->dev, NULL);
> >> +     codec_clk = clk_get(&codec_dev->dev, NULL);
> 
> is different from &codec_dev->dev.
> 

I get that they are different, I just don't get why changing
from a devm_clk_get to a clk_get is a better fix than changing
&codec->dev to &pdev->dev.

Thanks,
Charles
