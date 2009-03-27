From: =?ISO-8859-1?Q?Daniel_Gl=F6ckner?= <dg@emlix.com>
Subject: Re: [patch 2/2] alsa: s6105 IP camera machine specific
 ASoC code
Date: Fri, 27 Mar 2009 17:33:21 +0100
Message-ID: <49CCFFD1.7000705@emlix.com>
References: <1238074574-24734-1-git-send-email-dg@emlix.com>	<1238074574-24734-2-git-send-email-dg@emlix.com>
	<20090326142640.GE3771@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.emlix.com (mx1.emlix.com [193.175.82.87])
	by alsa0.perex.cz (Postfix) with ESMTP id 5865710385B
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2009 17:33:22 +0100 (CET)
In-Reply-To: <20090326142640.GE3771@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/26/2009 03:26 PM, Mark Brown wrote:
> Are you sure you're applying the correct configuration to the correct
> DAI here - S6105_CODEC_CLOCK is a CPU define, not a CODEC define?

In this case S6105 was referring to the S6105 reference design. It's a mach=
ine
define at the top of the file.

>> +static int snd_soc_dapm_set_endpoint(struct snd_soc_codec *codec, char =
*name,
>> +				     int status)
>> +{
>> +	if (status)
>> +		return snd_soc_dapm_enable_pin(codec, name);
>> +	else
>> +		return snd_soc_dapm_disable_pin(codec, name);
>> +}
> =

> This shouldn't be in a driver!

I know, but it was made static in soc-dapm.c when it was renamed to
snd_soc_dapm_set_pin.

> Hrm.  Given the fact that you can't have the stereo and differential
> outputs enabled simultaneously is it not safer to first disable the
> active output, then sync, then enable the new output?

The pins are connected via 0.47uF..
I'll insert the sync. Then I won't have to bug you about exporting
snd_soc_dapm_set_pin as well (as it will no longer result in shorter code).

  Daniel

-- =

Dipl.-Math. Daniel Gl=F6ckner, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax -11, Bahnhofsallee 1b, 37081 G=F6ttingen, Germany
Gesch=E4ftsf=FChrung: Dr. Uwe Kracke, Dr. Cord Seele, Ust-IdNr.: DE 205 198=
 055
Sitz der Gesellschaft: G=F6ttingen, Amtsgericht G=F6ttingen HR B 3160

emlix - your embedded linux partner
