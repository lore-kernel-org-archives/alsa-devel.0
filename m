From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 06/11] ASoC: rt5651: Improve headphone vs
 headset detection
Date: Wed, 21 Feb 2018 21:22:13 +0100
Message-ID: <68d4cfb3-0b7a-64fb-35af-61912bf678f5@redhat.com>
References: <20180220221511.22861-1-hdegoede@redhat.com>
 <20180220221511.22861-6-hdegoede@redhat.com>
 <20180221120557.GE8334@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
 [209.85.128.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B7F626762A
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 21:22:16 +0100 (CET)
Received: by mail-wr0-f196.google.com with SMTP id v65so8018495wrc.11
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 12:22:16 -0800 (PST)
In-Reply-To: <20180221120557.GE8334@sirena.org.uk>
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
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 21-02-18 13:05, Mark Brown wrote:
> On Tue, Feb 20, 2018 at 11:15:06PM +0100, Hans de Goede wrote:
> 
>> This commit ports my work to make this reliable on the rt5640 over to the
>> rt5651, making the following OVCD changes, each of which has been tested
>> individually and each of which has shown to be necessary on the rt5651:
> 
> It's a big rewrite everything commit :(

Yes your right, given that the headphone vs headset detection was pretty
broken before this commit I just ported my pending rt5640 work over
in one go. I will split this up better for the next version.

>> +/*
>> + * Note we do not toggle the RT5651_MIC1_OVCD_EN bit in these 2 functions,
>> + * to ensure reliable OVCD operation it *must* be enabled before enabling
>> + * the supplies, which may already be enabled.
>> + */
>> +static void rt5651_enable_micbias1_ovcd(struct snd_soc_codec *codec)
>> +{
> 
> I'm finding this comment pretty confusing - it would probably be clearer
> if it said something like "since the supplies may also be enabled by
> other DAPM operations we toggle the bit in $PLACE instead and only make
> sure the supplies are enabled here".

Ok I will update the comment.

>> +static bool rt5651_jack_inserted(struct snd_soc_codec *codec)
>> +{
> 
> BTW all these changes are in terms of snd_soc_codec not
> snd_soc_component, we're trying to move everytihng up a level so that
> all devices are components.  A bunch of refactoring went in just after
> the merge window doing that.

Ugh, just my luck to hit a refactoring like that with a big series.
Ah well I will rebase everything on top of your -next and try to use
component instead of codec everywhere.

Regards,

Hans
