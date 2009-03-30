From: =?ISO-8859-1?Q?Daniel_Gl=F6ckner?= <dg@emlix.com>
Subject: Re: [patch] tlv320aic3x: disable ADC/DAC while
 changing clock
Date: Mon, 30 Mar 2009 14:48:09 +0200
Message-ID: <49D0BF89.4050100@emlix.com>
References: <1238073706-23821-1-git-send-email-dg@emlix.com>
	<20090326134528.GC3771@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.emlix.com (mx1.emlix.com [193.175.82.87])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E8A31037FD
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Mar 2009 14:48:10 +0200 (CEST)
In-Reply-To: <20090326134528.GC3771@sirena.org.uk>
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

On 03/26/2009 02:45 PM, Mark Brown wrote:
> On Thu, Mar 26, 2009 at 02:21:46PM +0100, Daniel Gl??ckner wrote:
>> The aforementioned rule implies that we can not disable the PLL in
>> stand-by bias level.
> =

> Could you go into more detail on why you believe that this is the case?
> The DACs and ADCs won't be operational when the bias is held at standby
> which means that at most standby needs to wait for them to go idle.

This is based on the fact that soc_pcm_prepare calls
snd_soc_dapm_stream_event(..., SND_SOC_DAPM_STREAM_START) before
snd_soc_dapm_set_bias_level(..., SND_SOC_BIAS_ON).

In addition there is a block of code in tlv320aic3x.c that explicitly disab=
les
the ADC/DAC in SND_SOC_BIAS_OFF. It may be superfluous, though.

>> +static u8 aic3x_power_codec(struct snd_soc_codec *codec, u8 new)
>> +{
> =

> This really needs some comments explaining what it's doing; it's not
> really clear what effect it's trying to achieve or how it interacts with
> DAPM.

This function takes a bitmask of the desired power state of the ADC/DAC blo=
cks
and configures the device accordingly. It returns a bitmask of the previous
power state, suitable for input.

  Daniel


-- =

Dipl.-Math. Daniel Gl=F6ckner, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax -11, Bahnhofsallee 1b, 37081 G=F6ttingen, Germany
Gesch=E4ftsf=FChrung: Dr. Uwe Kracke, Dr. Cord Seele, Ust-IdNr.: DE 205 198=
 055
Sitz der Gesellschaft: G=F6ttingen, Amtsgericht G=F6ttingen HR B 3160

emlix - your embedded linux partner
