From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: am335x: mcasp in DIT mode
Date: Tue, 5 Mar 2013 08:20:22 +0100
Message-ID: <CAGm1_ku0P2ifV_2faUas7RXihh9kb2_BsccuN+Nhwxd6NGja+g@mail.gmail.com>
References: <CAGm1_kt83A2i-ew_gUaySRZpMeuQPEpTvEH_xX9BvfpUKob_Ug@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3B63C@DBDE01.ent.ti.com>
 <51345389.2030502@gmail.com>
 <CAGm1_kuZ1XL9ubfQf4SePK9DNEWXeB1e5Cpc_rzU+6ki57KMXQ@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3B924@DBDE01.ent.ti.com>
 <CAGm1_ksJiVZVLLp_B==fyS0K6iMg1gVoxBvh7PynaME7SphprQ@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3BA43@DBDE01.ent.ti.com>
 <CAGm1_kvC7qzx3khq_JA37YzVRUOCVZd1GuEMFveanmQsyWXwLQ@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3C47D@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
 [74.125.82.173])
 by alsa0.perex.cz (Postfix) with ESMTP id DA1F6264F8B
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2013 08:20:42 +0100 (CET)
Received: by mail-we0-f173.google.com with SMTP id r5so5516106wey.32
 for <alsa-devel@alsa-project.org>; Mon, 04 Mar 2013 23:20:42 -0800 (PST)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ED3C47D@DBDE01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "Porter, Matt" <mporter@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Fernandes,
 Joel A" <joelagnel@ti.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 5, 2013 at 7:33 AM, Bedia, Vaibhav <vaibhav.bedia@ti.com> wrote:
> On Mon, Mar 04, 2013 at 21:26:25, Yegor Yefremov wrote:
>>
>> I've made test with XSSZ == 0x7 (16-bit) and I heard sound. So the
>> initial version could be functional, because only XSSZ was touched.
>> Later came settings for mask and rotation. It seems like rotation is
>> the most important setting for DIT. So the Technical Reference Manual
>> should be thoroughly revised:
>>
>> 1. XSSZ 32-bit is not mandatory
>> 2. rotation for right-aligned data must properly specified (0x6 -
>> 24-bit and not 0x0)
>>
>
> Thanks for the confirmation. I'll try chasing down the h/w guys to
> get this sorted out and also raise a bug on the Technical Reference
> Manual.

Thanks for your help and feedback. Could you please pull both mcasp
patches into http://arago-project.org/git/projects/?p=linux-am33x.git;a=shortlog;h=refs/heads/v3.2-staging
too?

Yegor
