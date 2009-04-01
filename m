From: =?ISO-8859-1?Q?Daniel_Gl=F6ckner?= <dg@emlix.com>
Subject: Re: [PATCH v2] tlv320aic3x: disable ADC/DAC while
 changing clock
Date: Wed, 01 Apr 2009 18:21:19 +0200
Message-ID: <49D3947F.3010805@emlix.com>
References: <1238073706-23821-1-git-send-email-dg@emlix.com>
	<1238583415-19543-1-git-send-email-dg@emlix.com>
	<20090401121032.GA21294@sirena.org.uk> <49D374CD.20401@emlix.com>
	<20090401152421.GC21294@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.emlix.com (mx1.emlix.com [193.175.82.87])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CC9C24351
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Apr 2009 18:21:20 +0200 (CEST)
In-Reply-To: <20090401152421.GC21294@sirena.org.uk>
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

On 04/01/2009 05:24 PM, Mark Brown wrote:
> In that case rather than using a trigger to check if the device is
> running it should be possible to use constraints to prevent
> reconfiguration of the device when it's not supported - this is more
> friendly to apps since they know they won't be allowed to change the
> configuration.

It was my impression that it is up to the pcm part to install these
constraints as this is where SNDRV_PCM_INFO_JOINT_DUPLEX can be put into
the snd_pcm_hardware structure.

>>> It's especially suspicious since the power of the DAC and ADC is managed
>>> via DAPM; the only current user should be safe since it saves then
>>> restores the state but it does raise alarm bells.
> =

>> How about making it a function that always disables the four components =
and
>> referring to snd_soc_dapm_sync to restore the state?
> =

> Hrm.  For the ADC that's probably OK but powering off the DAC does risk
> being audible in the output; that does depend on the hardware, though.
> It should do the right thing, I think, but checking for audio artefacts
> would be advisable.

I can't hear any artefacts with my cheap headphones.
The delayed close is audible, though.

> It'd probably also help to only do reconfiguration if actually required
> rather than always powering down the ADCs and DACs.

That's what is done in these lines at the very first in aic3x_hw_params:

+	if (aic3x->format =3D=3D params_format(params) &&
+	    aic3x->rate =3D=3D params_rate(params))
+		return 0;


>> One could reorder aic3x_hw_params to detect the error before the
>> first registers are written..
> =

> Yes.

I'll make it three patches then:
- one to remove the redundant actions on bias level off
- one to reorder hw_params
- and one to fix the bug

  Daniel

-- =

Dipl.-Math. Daniel Gl=F6ckner, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax -11, Bahnhofsallee 1b, 37081 G=F6ttingen, Germany
Gesch=E4ftsf=FChrung: Dr. Uwe Kracke, Dr. Cord Seele, Ust-IdNr.: DE 205 198=
 055
Sitz der Gesellschaft: G=F6ttingen, Amtsgericht G=F6ttingen HR B 3160

emlix - your embedded linux partner
