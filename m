From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [RESEND PATCH v2 14/15] ASoC: qcom: apq8096: Add
 db820c machine driver
Date: Wed, 3 Jan 2018 12:04:54 -0800
Message-ID: <20180103200454.GC478@tuxbook>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-15-srinivas.kandagatla@linaro.org>
 <20180103001654.GU478@tuxbook>
 <3acca412-4ef7-6e61-d250-2b35c1fe9fe8@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f51.google.com (mail-pl0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 399872676A9
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 21:04:58 +0100 (CET)
Received: by mail-pl0-f51.google.com with SMTP id b12so1873888plm.3
 for <alsa-devel@alsa-project.org>; Wed, 03 Jan 2018 12:04:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <3acca412-4ef7-6e61-d250-2b35c1fe9fe8@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, sboyd@codeaurora.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, David Brown <david.brown@linaro.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Andy Gross <andy.gross@linaro.org>, linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed 03 Jan 08:27 PST 2018, Srinivas Kandagatla wrote:

> Thanks for the review comments.
> 
> 
> On 03/01/18 00:16, Bjorn Andersson wrote:
> > On Thu 14 Dec 09:34 PST 2017, srinivas.kandagatla@linaro.org wrote:
> > 
> > > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > 
> > > uThis patch adds support to DB820c machine driver.
> > 
> > Drop 'u' and expand the message to claim that this is the machine driver
> > for 8996, used by the db820c.
> > 
> > [..]
> > > +static struct snd_soc_dai_link msm8996_dai_links[] = {
> > 
> > Are there any differences between the DAI links of apq8096 and msm8996?
> > 
> This driver is more of board specific,
> Am not 100% sure about msm8996, on apq8096 in particularly on db820c we got
> hdmi and analog audio connected via slimbus and also I2S on lowspeed
> connector.
> 

Can this be kept platform specific and the board specific routing put in
DT?

I don't think we want to have a machine-driver for each board. Right now
you have 25 dtbs in mainline, that's going to be a lot of machine
drivers...

Regards,
Bjorn
