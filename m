From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: pcm: allow backend hardware to be freed in pause
 state
Date: Fri, 7 Dec 2012 13:37:11 +0000
Message-ID: <50C1F107.1050404@ti.com>
References: <1354819199-28795-1-git-send-email-plai@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1354819199-28795-1-git-send-email-plai@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>
Cc: broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 06/12/12 18:39, Patrick Lai wrote:
> When front-end PCM session is in paused state, back-end
> PCM session will be put in paused state as well if given
> front-end PCM session is the only client of given back-end.
> Then, application closes front-end PCM session, DPCM
> framework will not allow back-end enters HW_FREE state
> so back-end will never get shutdown completely.
>
> Signed-off-by: Patrick Lai <plai@codeaurora.org>

Acked-by: Liam Girdwood <lrg@ti.com>
