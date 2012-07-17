From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: [PATCH 1/2] MFD: twl6040: Fix revision information
Date: Tue, 17 Jul 2012 06:55:12 -0500
Message-ID: <500552A0.7020301@gmail.com>
References: <1342432184-12046-1-git-send-email-peter.ujfalusi@ti.com>
 <1342432184-12046-2-git-send-email-peter.ujfalusi@ti.com>
 <500508B0.9010009@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 438A9264FC1
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2012 13:55:37 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so425657obb.38
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2012 04:55:38 -0700 (PDT)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 07/17/2012 01:39 AM, Rajeev kumar wrote:
>> diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
>> index a36e9fc..2786de2 100644
>> --- a/sound/soc/codecs/twl6040.c
>> +++ b/sound/soc/codecs/twl6040.c
>> @@ -653,7 +653,7 @@ int twl6040_get_hs_step_size(struct snd_soc_codec
>> *codec)
>>   {
>>       struct twl6040 *twl6040 = codec->control_data;
>>
>> -    if (twl6040_get_revid(twl6040)<  TWL6040_REV_ES1_2)
>> +    if (twl6040_get_revid(twl6040)<  TWL6040_REV_ES1_3)
>
>
> Instead of doing this change why not you take a #define for revision and
>   do
> if (twl6040_get_revid(twl6040)<  TWL6040_REV)

I disagree.  The driver isn't just for one revision... it's for all of 
them.  Peter's code is pretty clear as to what the situation is.  Your 
suggestion hides it.

-gabriel
