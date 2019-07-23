From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH v2] ASoC: madera: Read device tree
 configuration
Date: Tue, 23 Jul 2019 16:21:41 +0200
Message-ID: <026ea350-db7b-d78c-cae5-e03cf735607c@intel.com>
References: <20190722135209.30302-1-ckeepax@opensource.cirrus.com>
 <7a6ca46b-9ca7-6c91-6aa9-d1be785c64c5@intel.com>
 <20190723081706.GL54126@ediswmail.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 419DAF800E8
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 16:21:48 +0200 (CEST)
In-Reply-To: <20190723081706.GL54126@ediswmail.ad.cirrus.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 2019-07-23 10:17, Charles Keepax wrote:
> On Tue, Jul 23, 2019 at 12:07:32AM +0200, Cezary Rojewski wrote:
>> On 2019-07-22 15:52, Charles Keepax wrote:
>>> +static void madera_prop_get_inmode(struct madera_priv *priv)
>>> +{
>>> +	struct madera *madera = priv->madera;
>>> +	struct madera_codec_pdata *pdata = &madera->pdata.codec;
>>> +	u32 tmp[MADERA_MAX_INPUT * MADERA_MAX_MUXED_CHANNELS];
>>> +	int n, i, in_idx, ch_idx;
>>> +
>>> +	BUILD_BUG_ON(ARRAY_SIZE(pdata->inmode) != MADERA_MAX_INPUT);
>>> +	BUILD_BUG_ON(ARRAY_SIZE(pdata->inmode[0]) != MADERA_MAX_MUXED_CHANNELS);
>>> +
>>> +	n = madera_get_variable_u32_array(madera->dev, "cirrus,inmode",
>>> +					  tmp, ARRAY_SIZE(tmp),
>>> +					  MADERA_MAX_MUXED_CHANNELS);
>>> +	if (n < 0)
>>> +		return;
>>> +
>>> +	in_idx = 0;
>>> +	ch_idx = 0;
>>> +	for (i = 0; i < n; ++i) {
>>> +		pdata->inmode[in_idx][ch_idx] = tmp[i];
>>> +
>>> +		if (++ch_idx == MADERA_MAX_MUXED_CHANNELS) {
>>> +			ch_idx = 0;
>>> +			++in_idx;
>>> +		}
>>> +	}
>>> +}
>>> +
>>> +static void madera_prop_get_pdata(struct madera_priv *priv)
>>> +{
>>> +	struct madera *madera = priv->madera;
>>> +	struct madera_codec_pdata *pdata = &madera->pdata.codec;
>>> +	u32 out_mono[ARRAY_SIZE(pdata->out_mono)];
>>> +	int i, n;
>>> +
>>> +	madera_prop_get_inmode(priv);
>>
>> Hmm, madera_get_variable_u32_array calls are not permissive within
>> madera_prop_get_inmode yet here they are. Is this intentional?
>>
> 
> Apologies but could you clarify what you mean by "not
> permissive"?
> 
> I can't see anything that would prevent the function from
> being called (indeed it builds and works), and the binding
> documentation does specify that this field can be of variable
> size.
> 
> Thanks,
> Charles

No worries. By "permissive" I described the usage of 
_get_variable_u32_array within madera_prop_get_pdata. In 
madera_prop_get_inmode you do care about the return value. In 
madera_prop_get_pdata however, you ignore all of them. From 
_get_variable_u32_array declaration, it seems function may fail.
Sometimes it's desired to be permissive, simply asking if that's 
intentional.

Czarek
