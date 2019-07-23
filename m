From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] ASoC: madera: Read device tree
 configuration
Date: Tue, 23 Jul 2019 09:17:06 +0100
Message-ID: <20190723081706.GL54126@ediswmail.ad.cirrus.com>
References: <20190722135209.30302-1-ckeepax@opensource.cirrus.com>
 <7a6ca46b-9ca7-6c91-6aa9-d1be785c64c5@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BCBD0F80227
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 10:17:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7a6ca46b-9ca7-6c91-6aa9-d1be785c64c5@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 23, 2019 at 12:07:32AM +0200, Cezary Rojewski wrote:
> On 2019-07-22 15:52, Charles Keepax wrote:
> >+static void madera_prop_get_inmode(struct madera_priv *priv)
> >+{
> >+	struct madera *madera = priv->madera;
> >+	struct madera_codec_pdata *pdata = &madera->pdata.codec;
> >+	u32 tmp[MADERA_MAX_INPUT * MADERA_MAX_MUXED_CHANNELS];
> >+	int n, i, in_idx, ch_idx;
> >+
> >+	BUILD_BUG_ON(ARRAY_SIZE(pdata->inmode) != MADERA_MAX_INPUT);
> >+	BUILD_BUG_ON(ARRAY_SIZE(pdata->inmode[0]) != MADERA_MAX_MUXED_CHANNELS);
> >+
> >+	n = madera_get_variable_u32_array(madera->dev, "cirrus,inmode",
> >+					  tmp, ARRAY_SIZE(tmp),
> >+					  MADERA_MAX_MUXED_CHANNELS);
> >+	if (n < 0)
> >+		return;
> >+
> >+	in_idx = 0;
> >+	ch_idx = 0;
> >+	for (i = 0; i < n; ++i) {
> >+		pdata->inmode[in_idx][ch_idx] = tmp[i];
> >+
> >+		if (++ch_idx == MADERA_MAX_MUXED_CHANNELS) {
> >+			ch_idx = 0;
> >+			++in_idx;
> >+		}
> >+	}
> >+}
> >+
> >+static void madera_prop_get_pdata(struct madera_priv *priv)
> >+{
> >+	struct madera *madera = priv->madera;
> >+	struct madera_codec_pdata *pdata = &madera->pdata.codec;
> >+	u32 out_mono[ARRAY_SIZE(pdata->out_mono)];
> >+	int i, n;
> >+
> >+	madera_prop_get_inmode(priv);
> 
> Hmm, madera_get_variable_u32_array calls are not permissive within
> madera_prop_get_inmode yet here they are. Is this intentional?
> 

Apologies but could you clarify what you mean by "not
permissive"?

I can't see anything that would prevent the function from
being called (indeed it builds and works), and the binding
documentation does specify that this field can be of variable
size.

Thanks,
Charles
