From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] ASoC: madera: Read device tree
 configuration
Date: Tue, 23 Jul 2019 16:01:25 +0100
Message-ID: <20190723150125.GP54126@ediswmail.ad.cirrus.com>
References: <20190722135209.30302-1-ckeepax@opensource.cirrus.com>
 <7a6ca46b-9ca7-6c91-6aa9-d1be785c64c5@intel.com>
 <20190723081706.GL54126@ediswmail.ad.cirrus.com>
 <026ea350-db7b-d78c-cae5-e03cf735607c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E37C2F803D0
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 17:01:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <026ea350-db7b-d78c-cae5-e03cf735607c@intel.com>
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

On Tue, Jul 23, 2019 at 04:21:41PM +0200, Cezary Rojewski wrote:
> On 2019-07-23 10:17, Charles Keepax wrote:
> >On Tue, Jul 23, 2019 at 12:07:32AM +0200, Cezary Rojewski wrote:
> >>On 2019-07-22 15:52, Charles Keepax wrote:
> >>>+static void madera_prop_get_inmode(struct madera_priv *priv)
> >>>+
> >>>+	n = madera_get_variable_u32_array(madera->dev, "cirrus,inmode",
> >>>+					  tmp, ARRAY_SIZE(tmp),
> >>>+					  MADERA_MAX_MUXED_CHANNELS);
> >>>+	if (n < 0)
> >>>+		return;
> >>
> >>Hmm, madera_get_variable_u32_array calls are not permissive within
> >>madera_prop_get_inmode yet here they are. Is this intentional?
> >>
> >
> >Apologies but could you clarify what you mean by "not
> >permissive"?
> >
> >I can't see anything that would prevent the function from
> >being called (indeed it builds and works), and the binding
> >documentation does specify that this field can be of variable
> >size.
> >
> >Thanks,
> >Charles
> 
> No worries. By "permissive" I described the usage of
> _get_variable_u32_array within madera_prop_get_pdata. In
> madera_prop_get_inmode you do care about the return value. In
> madera_prop_get_pdata however, you ignore all of them. From
> _get_variable_u32_array declaration, it seems function may fail.
> Sometimes it's desired to be permissive, simply asking if that's
> intentional.
> 

Ah.. yes I follow. Yes this is intentional, all the DT fields in
question are optional so the driver should proceed if even if they
are corrupt or missing.

madera_prop_get_inmode checks the return value because additional
code is required to insert the values into the pdata structure, so
that code should be skipped in the case cirrus,inmode is not
present/fails. Most of the calls in madera_prop_get_pdata are
self-contained not requiring further handling other than reading
the data directly into the pdata structure. Uou can see the same
on the read of cirrus,out-mono the additional processing is
skipped in the case of an error.

Thanks,
Charles
