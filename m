From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Mon, 03 Jun 2013 09:48:48 -0600
Message-ID: <51ACBAE0.1070406@wwwdotorg.org>
References: <1369983899-13580-1-git-send-email-bardliao@realtek.com>
 <1121E117AD4ECE49880A389A396215BB8A8969924B@rtitmbs7.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id D7B93261AE8
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 17:48:53 +0200 (CEST)
In-Reply-To: <1121E117AD4ECE49880A389A396215BB8A8969924B@rtitmbs7.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 05/31/2013 01:15 AM, Bard Liao wrote:
> Stephen,
> 
> I remove the DT support from this patch.
> Can you add the DT support as a separate patch?

Yes, I'll do that.

I assume you also want me to add the code to control the LDO1_EN GPIO,
since that seems missing from this patch. I thought you said you were
going to add it. I assume you tested this on Dalmore by manually setting
the GPIO from U-Boot before booting the kernel?

I'll try to get to this ASAP; perhaps not today though - we'll see how
long the other things I have stacked up take.
