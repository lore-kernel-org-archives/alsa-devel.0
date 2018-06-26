From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 04/11] ASoC: qdsp6: q6adm: use
 of_platform_populate/depopulate()
Date: Tue, 26 Jun 2018 09:56:54 +0100
Message-ID: <7912fa0c-b677-3206-51ac-e870c00ff4f8@linaro.org>
References: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
 <20180625143115.8346-5-srinivas.kandagatla@linaro.org>
 <20180625180329.GG10876@centauri.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f175.google.com (mail-wr0-f175.google.com
 [209.85.128.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A23B2676B4
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 10:56:56 +0200 (CEST)
Received: by mail-wr0-f175.google.com with SMTP id c5-v6so5212233wrs.10
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 01:56:56 -0700 (PDT)
In-Reply-To: <20180625180329.GG10876@centauri.lan>
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
To: Niklas Cassel <niklas.cassel@linaro.org>
Cc: rohkumar@qti.qualcomm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org, tiwai@suse.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org



On 25/06/18 19:03, Niklas Cassel wrote:
> You can remove pdev_routing from struct q6adm,
> since it is no longer in use.
yep, I thought I removed this, but it looks like its still there.
Will fix this in next version.

thanks,
srini
