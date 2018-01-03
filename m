From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/6] ASoC: rt5645: change micbias widget
	type to supply.
Date: Wed, 3 Jan 2018 12:01:38 +0100
Message-ID: <f2b24e22-6e4c-cd9d-e6c1-e9546d98b8c4@redhat.com>
References: <20180102185314.17189-1-hdegoede@redhat.com>
 <20180102185314.17189-2-hdegoede@redhat.com>
 <20180103105053.GA5603@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C75C2668F0
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 12:01:40 +0100 (CET)
Received: by mail-wm0-f47.google.com with SMTP id b76so2032162wmg.1
 for <alsa-devel@alsa-project.org>; Wed, 03 Jan 2018 03:01:40 -0800 (PST)
In-Reply-To: <20180103105053.GA5603@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 03-01-18 11:50, Mark Brown wrote:
> On Tue, Jan 02, 2018 at 07:53:09PM +0100, Hans de Goede wrote:
> 
>> Register "micbias1" and "micbias2" to supply widegts as modern drivers do.
> 
>> -	SND_SOC_DAPM_MICBIAS("micbias1", RT5645_PWR_ANLG2,
>> -			RT5645_PWR_MB1_BIT, 0),
>> -	SND_SOC_DAPM_MICBIAS("micbias2", RT5645_PWR_ANLG2,
>> -			RT5645_PWR_MB2_BIT, 0),
>> +	SND_SOC_DAPM_SUPPLY("micbias1", RT5645_PWR_ANLG2,
>> +			RT5645_PWR_MB1_BIT, 0, NULL, 0),
>> +	SND_SOC_DAPM_SUPPLY("micbias2", RT5645_PWR_ANLG2,
>> +			RT5645_PWR_MB2_BIT, 0, NULL, 0),
> 
> This is a good change to make but we have machines with the rt5645, are
> we sure none of them use microphones?  The two widget types work
> differently so it needs some checking and possibly machine driver
> updates to convert.

Right, we have existing machines with a rt5645 and an internal
analog mic, but those have been broken sofar (I can confirm
this for Cherry Trail based devices, I assume it applies
elsewhere) because without the next patch in this series we
were never actually enabling micbias. So this change should be
fine as analog mic support has been broken sofar anyways AFAIK.

Regards,

Hans
