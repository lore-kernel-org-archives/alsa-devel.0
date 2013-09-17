From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 2/2] ASoC: SPEAr spdif_out: Use
	devm_snd_soc_register_component
Date: Tue, 17 Sep 2013 12:14:44 +0530
Message-ID: <CAK9yfHyk2tdh3DZXjoA4VPRS6fpO19744toK2tSOab3AtvRv=g@mail.gmail.com>
References: <1379394697-19810-1-git-send-email-sachin.kamat@linaro.org>
 <1379394697-19810-2-git-send-email-sachin.kamat@linaro.org>
 <CAOh2x==NRbyPmYv-jBde2rrYm9b4Yz_Wok08szuxmt6EzEA4Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f51.google.com (mail-oa0-f51.google.com
 [209.85.219.51])
 by alsa0.perex.cz (Postfix) with ESMTP id A26DB26007E
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 08:44:47 +0200 (CEST)
Received: by mail-oa0-f51.google.com with SMTP id l6so911652oag.10
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 23:44:46 -0700 (PDT)
In-Reply-To: <CAOh2x==NRbyPmYv-jBde2rrYm9b4Yz_Wok08szuxmt6EzEA4Og@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "vipin.kumar" <vipin.kumar@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 17 September 2013 11:04, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On Tue, Sep 17, 2013 at 10:41 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> devm_snd_soc_register_component makes code simpler.
>>
>> +       ret = devm_snd_soc_register_component(&pdev->dev, &spdif_out_component,
>> +                                             &spdif_out_dai, 1);
>>         return ret;
>>  }
>>
>
> What about doing return devm_snd_soc_register_component(***) here?
> And same for the other patch?

The other patch already has it. I will do this as part of follow-on
cleanup patch as it makes 'ret'
unused after that.

>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks.

-- 
With warm regards,
Sachin
