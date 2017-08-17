From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 3/5] ASoC: codecs: msm8916-wcd-analog:
 add MBHC support
Date: Thu, 17 Aug 2017 11:15:48 +0100
Message-ID: <74790f28-4b65-329c-bf8a-350480fc323b@linaro.org>
References: <20170809164927.19663-1-srinivas.kandagatla@linaro.org>
 <20170809164927.19663-4-srinivas.kandagatla@linaro.org>
 <20170809211054.4owecfeoxxud5evh@workotop.localdomain>
 <76eb6edf-1754-6679-6218-028b12dce49a@linaro.org>
 <20170810133329.7lqcg3tucgp5jxii@workotop.localdomain>
 <20170814141222.rg3v3oqwt5xh3363@workotop.localdomain>
 <2731854d-c0fd-f8e3-456a-ba4d0d2e84c1@linaro.org>
 <20170816174840.sduoh2nm4hxye5jg@workotop.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f178.google.com (mail-wr0-f178.google.com
 [209.85.128.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 77810266DBE
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 12:15:50 +0200 (CEST)
Received: by mail-wr0-f178.google.com with SMTP id x43so39711498wrb.3
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 03:15:50 -0700 (PDT)
In-Reply-To: <20170816174840.sduoh2nm4hxye5jg@workotop.localdomain>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 16/08/17 18:48, Damien Riegel wrote:
> Correct me if I'm wrong, but if the design is the same, the values
> should be more a less the same as well, right? Moreover, the driver
> detects the right key press in normal use cases.
You are partly correct, but these values might change according to your 
board layout and there is button tuning procedure to derive these 
threshold values for each board according to OEM design requirements.

thanks,
srini
