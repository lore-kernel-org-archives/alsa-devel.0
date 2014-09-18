From: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Remove unneeded 'i2s-slave'
	property
Date: Thu, 18 Sep 2014 18:46:42 +0000
Message-ID: <1411065995187.3341@freescale.com>
References: <1411063877-1552-1-git-send-email-fabio.estevam@freescale.com>
 <20140918183251.GE6432@Asurada>,<541B2678.8000401@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0117.outbound.protection.outlook.com [207.46.100.117])
 by alsa0.perex.cz (Postfix) with ESMTP id E28042654C5
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 20:46:50 +0200 (CEST)
In-Reply-To: <541B2678.8000401@tabi.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Sorry, I missed to add alsa-devel@alsa-project.org on Cc.
________________________________________
From: Timur Tabi <timur@tabi.org>
Sent: Thursday, September 18, 2014 3:37 PM
To: Nicolin Chen
Cc: Estevam Fabio-R49496; broonie@kernel.org; Xiubo Li-B47053
Subject: Re: [PATCH] ASoC: fsl_ssi: Remove unneeded 'i2s-slave' property

On 09/18/2014 01:32 PM, Nicolin Chen wrote:
> On Thu, Sep 18, 2014 at 03:11:17PM -0300, Fabio Estevam wrote:
>> There is no need to use 'i2s-slave' property, since master/slave configuration
>> are passed via machine layer.
>>
>> This change does not break existing users because they do check for slave
>> mode inside sound/soc/fsl/mpc8610_hpcd.c/p1022_ds.c and p1022_rdk.c
>
> Besides this change, I'm wondering if we can take a further step to drop
> this entire property from Device Tree binding document as newer platforms
> may no long need this property in their DT bindings.

I think the property is necessary if anyone takes a P1022 or MPC8610 and
uses it in a platform that doesn't support i2s-slave.  But currently,
the code doesn't support anything else.  So technically, we could remove
it, and if anyone does want to support another configuration, he will
have to add that support the "new" way.
