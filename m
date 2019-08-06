From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] slimbus: qcom-ngd-ctrl: Add of_node_put()
	before return
Date: Tue, 6 Aug 2019 09:40:15 +0100
Message-ID: <a2eb9347-1568-c6e2-d9b7-e45669e192c6@linaro.org>
References: <20190804162201.5838-1-nishkadg.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62C6DF800F3
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2019 10:40:16 +0200 (CEST)
Received: by mail-wr1-x443.google.com with SMTP id r1so86966413wrl.7
 for <alsa-devel@alsa-project.org>; Tue, 06 Aug 2019 01:40:16 -0700 (PDT)
In-Reply-To: <20190804162201.5838-1-nishkadg.linux@gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Nishka Dasgupta <nishkadg.linux@gmail.com>, agross@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 04/08/2019 17:22, Nishka Dasgupta wrote:
> Each iteration of for_each_available_child_of_node puts the previous
> node, but in the case of a return from the middle of the loop, there is
> no put, thus causing a memory leak. Hence add an of_node_put before the
> return in two places.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>   drivers/slimbus/qcom-ngd-ctrl.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Applied Thanks,


--srini
