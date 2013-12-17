From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH 2/2] ASoC: sgtl5000: clean up
 sgtl5000_enable_regulators()
Date: Tue, 17 Dec 2013 01:52:05 +0000
Message-ID: <5b801a9d62414d538c40b027121eb583@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
 <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
 <00a7a941be434caf829f9fd246879c6d@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131213125129.GV18380@S2101-09.ap.freescale.net>
 <892cbb07bd064f44b2af45f106aeb479@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131216112910.GB30671@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0188.outbound.protection.outlook.com [207.46.163.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 77D4F260816
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 02:52:10 +0100 (CET)
In-Reply-To: <20131216112910.GB30671@S2101-09.ap.freescale.net>
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
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


> > Well, the regulator_get_optional() is still needed to improve.
> > For instance, if dts is not used for one platform and the external
> > VDDD supply is absent. The regulator_get_optional() will return
> > -EPROBE_DEFER, so the SGTL5000's probe, and then the SGTL5000 will do
> > the deferral probe, and this time the same -EPROBE_DEFER error will
> return again.
> 
> Yea, it seems in non-DT that regulator core can not figure out the -ENODEV
> case like it does in DT, so it simply returns -EPROBE_DEFER no matter
> whether the regulator is absent or it's present but just not registered yet.
> IOW, it can not distinguish between these two cases in non-DT case.
> 
> Neither am I aware of any non-DT SGTL5000 users in the tree, nor I care.
> I'm not concerned by this issue.
> 
> > Where should this special handling be dealt with ? Is here or
> > regulator_get_optional() will be better ?
> 
> Anyway, this is another issue which should be addressed in regulator core,
> IMO.
> 

Yes, agree.
