From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/5] ASoC: twl6040: Prevent extra power
 transitions during resume
Date: Fri, 11 Jan 2013 14:55:53 +0100
Message-ID: <50F019E9.3030805@ti.com>
References: <1357900355-5055-1-git-send-email-peter.ujfalusi@ti.com>
 <1357900355-5055-3-git-send-email-peter.ujfalusi@ti.com>
 <20130111115207.GW20956@opensource.wolfsonmicro.com> <50F01644.30703@ti.com>
 <20130111134601.GA20956@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 56A6A264EF3
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2013 14:55:56 +0100 (CET)
In-Reply-To: <20130111134601.GA20956@opensource.wolfsonmicro.com>
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

On 01/11/2013 02:46 PM, Mark Brown wrote:
> On Fri, Jan 11, 2013 at 02:40:20PM +0100, Peter Ujfalusi wrote:
> =

>> Since the core saves the previous bias_level in before suspend I can jus=
t do
>> this here:
> =

>> 	twl6040_set_bias_level(codec, codec->dapm.suspend_bias_level);
> =

>> If we were in _OFF before it is going to do nothing, but if we were in
>> _STANDBY it brings the codec back.
> =

> That'll work, yes (though removing the function when idle_bias_off is
> implemented would obviously be better).

True. Along with the suspend function since I'm not doing anything fancy th=
ere
and if idle_bias_off is set the core will not call suspend of the driver if=
 it
is not already in _OFF.
I'll keep this in mind for the future and resend with only with

	twl6040_set_bias_level(codec, SND_SOC_BIAS_STANDBY);

in the resume.
But I wait if you have other comments for the rest for the series.

-- =

P=E9ter
