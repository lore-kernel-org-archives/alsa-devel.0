From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 6/7] ASoC: samsung: Drop uneeded RCLKSRC
 setting in the Snow driver
Date: Mon, 12 Mar 2018 08:35:19 +0100
Message-ID: <CAJKOXPeckmMestwPyChw=Cjj8TLGXSuCtV47G=T-xULwv=wpig@mail.gmail.com>
References: <CGME20180309175015epcas1p2ef43a122b650a7a420320ca619124dc6@epcas1p2.samsung.com>
 <20180309174858.24017-1-s.nawrocki@samsung.com>
 <20180309174858.24017-6-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 64C46266E43
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 08:35:24 +0100 (CET)
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0260521772
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 07:35:22 +0000 (UTC)
Received: by mail-wm0-f53.google.com with SMTP id e194so14322150wmd.3
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 00:35:21 -0700 (PDT)
In-Reply-To: <20180309174858.24017-6-s.nawrocki@samsung.com>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org, =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= <b.zolnierkie@samsung.com>, sbkim73@samsung.com, lgirdwood@gmail.com, robh+dt@kernel.org, javierm@redhat.com, broonie@kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 9, 2018 at 6:48 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> The RCLKSRC mux input 0 is a default configuration after reset, so
> there is no need for this explicit snd_soc_dai_set_sysclk() call.
> Also, this static mux clock configuration can be specified in DT.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v1:
>  - none.
> ---
>  sound/soc/samsung/snow.c | 5 -----
>  1 file changed, 5 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
