From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH V2 2/9] sound:asoc: Add support for STA529
	Audio Codec
Date: Fri, 22 Jun 2012 11:56:41 +0530
Message-ID: <4FE41021.3060605@st.com>
References: <cover.1340273261.git.rajeev-dlh.kumar@st.com>
	<d06e4180229ac4aa0e0f27aa4d444dd7a9634afd.1340273261.git.rajeev-dlh.kumar@st.com>
	<20120621122540.GV4037@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog117.obsmtp.com (eu1sys200aog117.obsmtp.com
	[207.126.144.143])
	by alsa0.perex.cz (Postfix) with ESMTP id A5C1324369
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2012 07:05:35 +0200 (CEST)
In-Reply-To: <20120621122540.GV4037@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello Mark

On 6/21/2012 5:55 PM, Mark Brown wrote:
>> +static int sta529_resume(struct snd_soc_codec *codec)
>> >  +{
>> >  +	snd_soc_cache_sync(codec);
> You're not using the ASoC cache code.
>

Point is not clear to me, you mean to say I need to use
regcache_sync(sta529->regmap), please confirm.

Best Regards
Rajeev
