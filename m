From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 11/11] ASoC: qdsp6: q6routing: add proper
	error check
Date: Tue, 26 Jun 2018 09:53:20 +0100
Message-ID: <f2ee3dfa-6844-074a-178a-094c02a1e130@linaro.org>
References: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
 <20180625143115.8346-12-srinivas.kandagatla@linaro.org>
 <20180625180454.GI10876@centauri.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CCA1267861
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 10:53:22 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id z137-v6so906297wmc.0
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 01:53:22 -0700 (PDT)
In-Reply-To: <20180625180454.GI10876@centauri.lan>
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



On 25/06/18 19:04, Niklas Cassel wrote:
> On Mon, Jun 25, 2018 at 03:31:15PM +0100, Srinivas Kandagatla wrote:
>> q6adm_open can return error pointer or a null in error cases.
>> Fix this check this.
> Instead of "Fix this check this.", how about "Fix the return handling."

Thanks,  I will reword this!
--srini
> 
