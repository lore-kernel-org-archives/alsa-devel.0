From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] mfd: cros_ec: Add commands to control codec
Date: Fri, 14 Dec 2018 12:22:45 +0000
Message-ID: <20181214122245.GU4497@dell>
References: <20181206040540.84632-1-cychiang@chromium.org>
 <20181214122156.GT4497@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181214122156.GT4497@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, dgreid@chromium.org, tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 14 Dec 2018, Lee Jones wrote:

> On Thu, 06 Dec 2018, Cheng-Yi Chiang wrote:
> 
> > Add EC host commands to control codec on EC.
> > 
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> >  V2 fixed the wrong ancestor issue so the patch can be applied cleanly on mfd tree.
> >  Codec driver that uses these commands will be sent separately.
> >  Thanks!
> > 
> >  include/linux/mfd/cros_ec_commands.h | 94 ++++++++++++++++++++++++++++
> >  1 file changed, 94 insertions(+)
> 
> Would be good to have this reviewed by some more Chrome people.

See this for reference:

  https://lore.kernel.org/patchwork/patch/1024985/

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
