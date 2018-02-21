From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 04/11] ASoC: rt5651: Simplify
	set_bias_level()
Date: Wed, 21 Feb 2018 21:11:34 +0100
Message-ID: <92dc88f0-c928-3c15-3295-b77a5dedbd58@redhat.com>
References: <20180220221511.22861-1-hdegoede@redhat.com>
 <20180220221511.22861-4-hdegoede@redhat.com>
 <20180221114328.GC8334@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f176.google.com (mail-wr0-f176.google.com
 [209.85.128.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 08DE4267634
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 21:11:36 +0100 (CET)
Received: by mail-wr0-f176.google.com with SMTP id u49so7944489wrc.10
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 12:11:36 -0800 (PST)
In-Reply-To: <20180221114328.GC8334@sirena.org.uk>
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

On 21-02-18 12:43, Mark Brown wrote:
> On Tue, Feb 20, 2018 at 11:15:04PM +0100, Hans de Goede wrote:
>> There is no need to set the LDO voltage to 1.2 volt each time we enter
>> standby, instead always leave it 1.2 volt on BIAS_OFF. Note we do a
>> snd_soc_codec_force_bias_level(BIAS_OFF) on probe, so this will configure
>> it correctly right from the start.
> 
> That force on probe sounds like a problem...  if this is being done once
> at startup it should be done in the probe function, not in the bias
> level configuration.

This is more like "we do a snd_soc_codec_force_bias_level(BIAS_OFF)
on probe anyways and that already sets the level to 1.2 volt, so
we don't need to do this explicitly at probe time".

> Also, are you sure this is a good fix?  If the bias voltage is being
> configured all the time does that perhaps indicate that for better
> performance or something it should have been being set to some other
> voltage when the device is in standby?

We switch the LDO off when in the bias level is BIAS_OFF and on
at 1.2 volt when in standby or higher. Before this commit we would
unconditionally write 0 to PWR_ANLG1 not only turning off all
supplies, but additionally changing the LDO voltage control bits
to 00, which requires reprogramming them when we go back to
standby. The value of the LDO voltage controls bits when in
BIAS_OFF does not matter as the LDO on/off bit is set to off,
so the purpose of this commit is to replace the blindly setting
of PWR_ANLG1 to 0 with setting all the bits in PWR_ANLG1 to 0,
while leaving the 2 LDO voltage-control bits as-is, so that
we don't need to reprogram these 2 bits when entering standby.

Regards,

Hans
