From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 6/8] ASoC: samsung: i2s: Update
 clock-output-names property documentation
Date: Tue, 6 Feb 2018 13:59:47 +0100
Message-ID: <CAJKOXPcXLwiB_bxQtBp-1PhM7yrA5fGM7t6kZtASXdFCgEHC=g@mail.gmail.com>
References: <CGME20180205154529epcas2p3478546ef61294ac06cd9d8ed3d7e12c9@epcas2p3.samsung.com>
 <20180205154403.13520-1-s.nawrocki@samsung.com>
 <20180205154403.13520-7-s.nawrocki@samsung.com>
 <CAJKOXPcT-C8t-1i0n5JE23udfKfdURRbyvaCbA1KGKxdZ1+Y=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id E0CAF26755C
 for <alsa-devel@alsa-project.org>; Tue,  6 Feb 2018 13:59:50 +0100 (CET)
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7F8B82178F
 for <alsa-devel@alsa-project.org>; Tue,  6 Feb 2018 12:59:49 +0000 (UTC)
Received: by mail-wm0-f42.google.com with SMTP id v123so3647948wmd.5
 for <alsa-devel@alsa-project.org>; Tue, 06 Feb 2018 04:59:49 -0800 (PST)
In-Reply-To: <CAJKOXPcT-C8t-1i0n5JE23udfKfdURRbyvaCbA1KGKxdZ1+Y=A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org, =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= <b.zolnierkie@samsung.com>, sbkim73@samsung.com, jcsing.lee@samsung.com, lgirdwood@gmail.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 6, 2018 at 1:59 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Mon, Feb 5, 2018 at 4:44 PM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>> The clock-output-names property is marked as deprecated. While at it,
>> #clock-cells property's value is corrected in the example snippet
>> and few typos are fixed.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---
>>  .../devicetree/bindings/sound/samsung-i2s.txt          | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> As with all bindings, this should go before changing the driver.

Ah, too fast in pressing return. I missed:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
