From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4] ASoC: samsung: i2s: Null pointer dereference on
 samsung_i2s_remove
Date: Tue, 15 Aug 2017 19:29:58 +0200
Message-ID: <20170815172958.q2kd75w2p2seypsa@kozik-lap>
References: <1502799594-596-1-git-send-email-vasilyev@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502799594-596-1-git-send-email-vasilyev@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vasilyev <vasilyev@ispras.ru>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 15, 2017 at 03:19:54PM +0300, Anton Vasilyev wrote:
> If (quirks & QUIRK_SEC_DAI == 0) then samsung_i2s_probe() doesn't allocate
> sec_dai and pri_dai->sec_dai remains Null, but samsung_i2s_remove()
> performs pri_dai->sec_dai dereference in any case.
> 
> The patch removes useless reinitialization of sec_dai at
> samsung_i2s_remove(), because resources are under devm control.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
> ---
> v2: Drop initialization of sec_dai by NULL at samsung_i2s_remove
> as Sylwester Nawrocki suggest.
> ---
> v3: Fix typo in the comment
> ---
> v4: Change comment based on Krzysztof review.
> ---
>  sound/soc/samsung/i2s.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
