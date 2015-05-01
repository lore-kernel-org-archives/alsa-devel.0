From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: Add gtm601 codec driver
Date: Fri, 1 May 2015 22:34:26 +0200
Message-ID: <CAAfyv34FJvBmCqUnZhiNMRMn2X+_4gbh=GJpV3ySmUeGaTSxyQ@mail.gmail.com>
References: <1430429283-27907-1-git-send-email-marek@goldelico.com>
	<1430429283-27907-2-git-send-email-marek@goldelico.com>
	<20150501110311.GV22845@sirena.org.uk>
	<CAAfyv36Bi_Em=PUUf1n0nk6AAR65QLzr_R2SenHs_C5Q3Ggjmg@mail.gmail.com>
	<20150501140225.GY22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150501140225.GY22845@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: perex@perex.cz, tiwai@suse.de, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 1, 2015 at 4:02 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, May 01, 2015 at 01:36:48PM +0200, Belisko Marek wrote:
>> On Fri, May 1, 2015 at 1:03 PM, Mark Brown <broonie@kernel.org> wrote:
>> > On Thu, Apr 30, 2015 at 11:28:01PM +0200, Marek Belisko wrote:
>
>> >> +/*
>> >> + * Note this is a simple chip with no configuration interface, sample rate is
>> >> + * determined automatically by examining the Master clock and Bit clock ratios
>> >> + */
>> >
>> >> +#define GTM601_RATES  (SNDRV_PCM_RATE_8000)
>
>> > Does it or doesn't it support multiple sample rates?
>
>> It support only 8kHz rate. I'll remove define and use SNDRV_PCM_RATE_8000
>> only in gtm601_dai struct.
>
> I was more commenting on the fact that the comment immediately above
> says that the sample rate is determined automatically which suggests
> that multiple sample rates are supported.
OK I see. Checked with gtm601 datasheet max master clock is 2.048MHz so
it is 8kHz LRCLK. Sorry for confusing comment.

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
