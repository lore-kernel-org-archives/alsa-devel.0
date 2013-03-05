From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: Re: am335x: mcasp in DIT mode
Date: Tue, 5 Mar 2013 06:33:36 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED3C47D@DBDE01.ent.ti.com>
References: <CAGm1_kt83A2i-ew_gUaySRZpMeuQPEpTvEH_xX9BvfpUKob_Ug@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3B63C@DBDE01.ent.ti.com>
 <51345389.2030502@gmail.com>
 <CAGm1_kuZ1XL9ubfQf4SePK9DNEWXeB1e5Cpc_rzU+6ki57KMXQ@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3B924@DBDE01.ent.ti.com>
 <CAGm1_ksJiVZVLLp_B==fyS0K6iMg1gVoxBvh7PynaME7SphprQ@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3BA43@DBDE01.ent.ti.com>
 <CAGm1_kvC7qzx3khq_JA37YzVRUOCVZd1GuEMFveanmQsyWXwLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 1510C2651A0
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2013 07:33:40 +0100 (CET)
In-Reply-To: <CAGm1_kvC7qzx3khq_JA37YzVRUOCVZd1GuEMFveanmQsyWXwLQ@mail.gmail.com>
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
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: "Porter, Matt" <mporter@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Fernandes,
 Joel A" <joelagnel@ti.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 04, 2013 at 21:26:25, Yegor Yefremov wrote:
> 
> I've made test with XSSZ == 0x7 (16-bit) and I heard sound. So the
> initial version could be functional, because only XSSZ was touched.
> Later came settings for mask and rotation. It seems like rotation is
> the most important setting for DIT. So the Technical Reference Manual
> should be thoroughly revised:
> 
> 1. XSSZ 32-bit is not mandatory
> 2. rotation for right-aligned data must properly specified (0x6 -
> 24-bit and not 0x0)
> 

Thanks for the confirmation. I'll try chasing down the h/w guys to
get this sorted out and also raise a bug on the Technical Reference
Manual.

Thanks,
Vaibhav 
