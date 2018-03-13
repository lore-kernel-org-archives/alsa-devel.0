From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 2/2] ASoC: samsung: Add HDMI audio
	support for Snow
Date: Tue, 13 Mar 2018 08:28:39 +0100
Message-ID: <CAJKOXPdnEfi16D0=r6r6efnEBPxjVCeXzwvBGeb=UFu+AFDMCg@mail.gmail.com>
References: <20180312184939.11327-1-s.nawrocki@samsung.com>
 <CGME20180312185000epcas1p2ae13436139bee76311206ac3fd74267c@epcas1p2.samsung.com>
 <20180312184939.11327-2-s.nawrocki@samsung.com>
 <06ddf7cf-02dc-f50c-37bb-157f4d643c07@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 5198D266F68
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 08:28:43 +0100 (CET)
Received: from mail-wr0-f179.google.com (mail-wr0-f179.google.com
 [209.85.128.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 26B882176F
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 07:28:41 +0000 (UTC)
Received: by mail-wr0-f179.google.com with SMTP id l8so5181399wrg.5
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 00:28:41 -0700 (PDT)
In-Reply-To: <06ddf7cf-02dc-f50c-37bb-157f4d643c07@samsung.com>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org, =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= <b.zolnierkie@samsung.com>, sbkim73@samsung.com, lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 12, 2018 at 7:54 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> On 03/12/2018 07:49 PM, Sylwester Nawrocki wrote:
>> This patch updates the driver so, in addition to current DT bindings, it
>> also can also use the new DT bindings with cpu, codec subnodes which allow
>> to support sound on the HDMI interface.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>
> I've forgotten to add Krzysztof's tag:
>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Yes, thanks :)

Best regards,
Krzysztof
