From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: lm49453: Fix analog and digital
 volume ranges
Date: Thu, 6 Dec 2012 15:48:43 +0100
Message-ID: <50C0B04B.5000701@ti.com>
References: <1354704529-12912-1-git-send-email-MR.Swami.Reddy@ti.com>
 <1354735742.7077.89.camel@vkoul-udesk3>
 <354ACD19F280E44381F0C302BC7A15A39DE2DF@DFLE08.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 683F02615D2
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2012 15:48:47 +0100 (CET)
In-Reply-To: <354ACD19F280E44381F0C302BC7A15A39DE2DF@DFLE08.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Reddy, M.R. Swami" <MR.Swami.Reddy@ti.com>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Deshpande A,
 Vishwas" <Vishwas.A.Deshpande@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Swami,

On 12/06/2012 09:07 AM, Reddy, M.R. Swami wrote:
> Thanks Vinod. Yes, the ADC tlvs missed... I will update the patch.  =


and while you are there, please fix the commit message as well.

> =

> Thanks
> Swami
> =

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul@linux.intel.com] =

> Sent: Thursday, December 06, 2012 12:59 AM
> To: Reddy, M.R. Swami
> Cc: broonie@opensource.wolfsonmicro.com; Girdwood, Liam; Deshpande A, Vis=
hwas; alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] [PATCH] ASoC: lm49453: Fix analog and digital v=
olume ranges
> =

> On Wed, 2012-12-05 at 16:18 +0530, MR.Swami.Reddy@ti.com wrote:
> =

>>  /* TLV Declarations */
>>  static const DECLARE_TLV_DB_SCALE(digital_tlv, -7650, 150, 1); =

>> -static const DECLARE_TLV_DB_SCALE(port_tlv, 0, 600, 0);
>> +static const DECLARE_TLV_DB_SCALE(analog_tlv, 0, 200, 1);
> The spec says your analog gain are 0 to 30dB in steps of 2dB, this doesnt=
 sound right to me.
>> +static const DECLARE_TLV_DB_SCALE(port_tlv, -1800, 600, 0);
>>  =

>>  static const struct snd_kcontrol_new =

>> lm49453_sidetone_mixer_controls[] =3D {
>>  /* Sidetone supports mono only */
>> @@ -516,9 +517,9 @@ SOC_DAPM_SINGLE_TLV("Sidetone DMIC2R Volume", =

>> LM49453_P0_STN_VOL_DMIC2R_REG,  static const struct snd_kcontrol_new lm4=
9453_snd_controls[] =3D {
>>  	/* mic1 and mic2 supports mono only */
>>  	SOC_SINGLE_TLV("Mic1 Volume", LM49453_P0_ADC_LEVELL_REG, 0, 6,
>> -			0, digital_tlv),
>> +			0, analog_tlv),
> now i see a  problem.
> You have hidden the MIC gains and exposed only ADC gains. The name is wro=
ng causing the confusion. Please make this ADC gain and add new control for=
 MIC gain!
> Your ADC gain is -76 to 18db, with 0.5dB steps, how does this reflect tha=
t?
> =

>>  	SOC_SINGLE_TLV("Mic2 Volume", LM49453_P0_ADC_LEVELR_REG, 0, 6,
>> -			0, digital_tlv),
>> +			0, analog_tlv),
> Ditto.....
>>  =

>>  	SOC_DOUBLE_R_TLV("DMIC1 Volume", LM49453_P0_DMIC1_LEVELL_REG,
>>  			  LM49453_P0_DMIC1_LEVELR_REG, 0, 6, 0, digital_tlv), =

>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> =

> =

> --
> ~Vinod
> =

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> =



-- =

P=E9ter
