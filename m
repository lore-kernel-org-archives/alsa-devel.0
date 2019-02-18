From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] ASoC: samsung: i2s: Prevent potential NULL
	platform data dereference
Date: Mon, 18 Feb 2019 09:24:55 +0100
Message-ID: <CAJKOXPdu7y-kn3KM_Bf0s47N30YczDgfg95SVRRzqGY9rxYdjw@mail.gmail.com>
References: <CGME20190214155852epcas1p30dd461a0c14cadd70b487e908978ce3a@epcas1p3.samsung.com>
 <20190214155840.3764-1-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id E7FC4266A9D
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 09:25:09 +0100 (CET)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 61C3D218AD
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 08:25:08 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id f24-v6so13579976ljk.0
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 00:25:08 -0800 (PST)
In-Reply-To: <20190214155840.3764-1-s.nawrocki@samsung.com>
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
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 14 Feb 2019 at 16:58, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> When np is NULL i2s_pdata could also be NULL but i2s_pdata is now being
> dereferenced without proper check. Fix this and shorten the error message
> so we don't exceed 80 characters limit.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
