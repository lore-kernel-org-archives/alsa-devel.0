From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 1/3] ASoC: codecs: adau1701: allow
 configuration of PLL mode pins
Date: Fri, 21 Jun 2013 13:44:54 +0530
Message-ID: <51C40B7E.1090508@st.com>
References: <1371749397-32238-1-git-send-email-zonque@gmail.com>
 <1371749397-32238-2-git-send-email-zonque@gmail.com>
 <51C3DAAF.9060007@st.com> <51C3ED78.8010703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog111.obsmtp.com (eu1sys200aog111.obsmtp.com
 [207.126.144.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 717982654DD
 for <alsa-devel@alsa-project.org>; Fri, 21 Jun 2013 10:15:01 +0200 (CEST)
In-Reply-To: <51C3ED78.8010703@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

On 6/21/2013 11:36 AM, Daniel Mack wrote:
>>> >>     	struct snd_soc_codec *codec = dai->codec;
>>> >>  +	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
>>> >>     	snd_pcm_format_t format;
>>> >>     	unsigned int val;
>>> >>
>>> >>  +	if (adau1701->sysclk) {
>>> >>  +		unsigned int clkdiv = adau1701->sysclk / params_rate(params);
>> >
>> >  It will give warning.
> Please elaborate.

you are declaring something (unsigned int clkdiv) in between code.

~Rajeev
