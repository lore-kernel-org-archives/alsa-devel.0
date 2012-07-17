From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] MFD: twl6040: Fix revision information
Date: Tue, 17 Jul 2012 15:01:46 +0200
Message-ID: <5005623A.10808@ti.com>
References: <1342432184-12046-1-git-send-email-peter.ujfalusi@ti.com>
 <1342432184-12046-2-git-send-email-peter.ujfalusi@ti.com>
 <500508B0.9010009@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog122.obsmtp.com (na3sys009aog122.obsmtp.com
 [74.125.149.147])
 by alsa0.perex.cz (Postfix) with ESMTP id CA265264FE7
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2012 15:01:31 +0200 (CEST)
Received: by obcva7 with SMTP id va7so566152obc.20
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2012 06:01:32 -0700 (PDT)
In-Reply-To: <500508B0.9010009@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 07/17/2012 08:39 AM, Rajeev kumar wrote:
>>   #define TWL6040_REV_ES1_0        0x00
>> -#define TWL6040_REV_ES1_1        0x01
>> -#define TWL6040_REV_ES1_2        0x02
>> +#define TWL6040_REV_ES1_1        0x01 /* Rev ES1.1 and ES1.2 */
>> +#define TWL6040_REV_ES1_3        0x02
>>
>>   #define TWL6040_IRQ_TH            0
>>   #define TWL6040_IRQ_PLUG        1
>> diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
>> index a36e9fc..2786de2 100644
>> --- a/sound/soc/codecs/twl6040.c
>> +++ b/sound/soc/codecs/twl6040.c
>> @@ -653,7 +653,7 @@ int twl6040_get_hs_step_size(struct snd_soc_codec *c=
odec)
>>   {
>>       struct twl6040 *twl6040 =3D codec->control_data;
>>
>> -    if (twl6040_get_revid(twl6040)<  TWL6040_REV_ES1_2)
>> +    if (twl6040_get_revid(twl6040)<  TWL6040_REV_ES1_3)
> =

> =

> Instead of doing this change why not you take a #define for revision and =
 do
> if (twl6040_get_revid(twl6040)<  TWL6040_REV)

ES1.1, ES1.2 of twl6040 have 2mV HS step. Newer revisions (ES1.3 of twl6040
and twl6041) have 1mV HS step.
Here the comment was correct, but the define name was incorrect.

> =

> ~Rajeev
> =

>>           /* For ES under ES_1.3 HS step is 2 mV */
>>           return 2;
>>       else
> =



-- =

P=E9ter
