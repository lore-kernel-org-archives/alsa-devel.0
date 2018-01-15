From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] ASoC: au1x: Fix timeout tests in au1xac97c_ac97_read()
Date: Mon, 15 Jan 2018 09:25:15 +0100
Message-ID: <CAOLZvyGXxOdpF9kx6FcHKgVEogAkb4q0QoncH6fPS_B2nae=QQ@mail.gmail.com>
References: <20180115080838.q6nupi7rs7k5pdky@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20180115080838.q6nupi7rs7k5pdky@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Manuel Lauss <manuel.lauss@googlemail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel <alsa-devel@alsa-project.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 15, 2018 at 9:08 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> The loop timeout doesn't work because it's a post op and ends with "tmo"
> set to -1.  I changed it from a post-op to a pre-op and I changed the
> initial the starting value from 5 to 6 so we still iterate 5 times.  I
> left the other as it was because it's a large number.
>
> Fixes: b3c70c9ea62a ("ASoC: Alchemy AC97C/I2SC audio support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Ackey-by: Manuel Lauss <manuel.lauss@gmail.com>

I didn't notice any failures with latest -git though, I've never
actually hit these
timeouts, even under maximum CPU load.

Manuel
