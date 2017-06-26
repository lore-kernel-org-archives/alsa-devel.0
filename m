From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH][sound-next] ASoC: zx_aud96p22: make aud96p22_dt_ids static
Date: Mon, 26 Jun 2017 19:07:09 +0800
Message-ID: <CAAQ0ZWR5apOX3D-7TiFSauo6=nMHpngFp6ex_-khAea8Se8rig@mail.gmail.com>
References: <20170626090014.8977-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170626090014.8977-1-colin.king@canonical.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Baoyou Xie <baoyou.xie@linaro.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, kernel-janitors@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 26, 2017 at 5:00 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The structure aud96p22_dt_ids does not need to be in global scope,
> so make it static.
>
> Cleans up sparse warning:
> "warning: symbol 'aud96p22_dt_ids' was not declared. Should it be static?"
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
