From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/5] ASoC: twl6040: Prevent extra power
 transitions during resume
Date: Fri, 11 Jan 2013 14:40:20 +0100
Message-ID: <50F01644.30703@ti.com>
References: <1357900355-5055-1-git-send-email-peter.ujfalusi@ti.com>
 <1357900355-5055-3-git-send-email-peter.ujfalusi@ti.com>
 <20130111115207.GW20956@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 1661C264EBE
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2013 14:40:23 +0100 (CET)
In-Reply-To: <20130111115207.GW20956@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/11/2013 12:52 PM, Mark Brown wrote:
> On Fri, Jan 11, 2013 at 11:32:32AM +0100, Peter Ujfalusi wrote:
> =

>> -	twl6040_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
>> -	twl6040_set_bias_level(codec, codec->dapm.suspend_bias_level);
>> +	if (codec->dapm.bias_level !=3D codec->dapm.suspend_bias_level) {
>> +		twl6040_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
>> +		twl6040_set_bias_level(codec, codec->dapm.suspend_bias_level);
>> +	}
> =

> The device should always be in either _STANDBY or _OFF (depending on if
> it supports idle_bias_off) before it tries to suspend so
> suspend_bias_level ought to be redundant.  We should really get round to
> killing it...

Yes, that's true. At the moment I can just send the codec to _STANDBY in
resume since I don't have idle_bias_off support ready (due to external
dependencies, but I'm working on it). But when we have idle_bias_off support
we want to avoid sending the codec to _STANDBY here just that ASoC core will
put us back to _OFF later on. On/Off is a bit expensive on twl6040.
Since the core saves the previous bias_level in before suspend I can just do
this here:

	twl6040_set_bias_level(codec, codec->dapm.suspend_bias_level);

If we were in _OFF before it is going to do nothing, but if we were in
_STANDBY it brings the codec back.

-- =

P=E9ter
