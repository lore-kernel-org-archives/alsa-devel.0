From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/3] ASoC: codecs: adau1701: allow
 configuration of PLL mode pins
Date: Fri, 21 Jun 2013 10:18:08 +0200
Message-ID: <51C40C40.4000604@metafoo.de>
References: <1371749397-32238-1-git-send-email-zonque@gmail.com>
 <1371749397-32238-2-git-send-email-zonque@gmail.com>
 <51C3DAAF.9060007@st.com> <51C3ED78.8010703@gmail.com>
 <51C40B7E.1090508@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-183.synserver.de (smtp-out-183.synserver.de
 [212.40.185.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 81E0526556B
 for <alsa-devel@alsa-project.org>; Fri, 21 Jun 2013 10:17:55 +0200 (CEST)
In-Reply-To: <51C40B7E.1090508@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 06/21/2013 10:14 AM, Rajeev kumar wrote:
> On 6/21/2013 11:36 AM, Daniel Mack wrote:
>>>> >>         struct snd_soc_codec *codec = dai->codec;
>>>> >>  +    struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
>>>> >>         snd_pcm_format_t format;
>>>> >>         unsigned int val;
>>>> >>
>>>> >>  +    if (adau1701->sysclk) {
>>>> >>  +        unsigned int clkdiv = adau1701->sysclk / params_rate(params);
>>> >
>>> >  It will give warning.
>> Please elaborate.
> 
> you are declaring something (unsigned int clkdiv) in between code.
> 

It's at the beginning at a block, that's actually fine. Neither checkpatch
or gcc will generate a warning.
