From: undefined@vger.kernel.org
Subject: Re: [RESEND PATCH 1/1] ASoC: fsl_ssi: Fix checking of dai format for
 AC97 mode
Date: Fri, 18 Sep 2015 19:37:35 -0500
Message-ID: <55FCAE4F.9040904@tabi.org>
References: <409ab77432bd0553502b75ab98089bb7ecdb5018.1442394728.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <409ab77432bd0553502b75ab98089bb7ecdb5018.1442394728.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: alsa-devel@alsa-project.org

Adam Thomson wrote:
> Current code incorrectly treats dai format for AC97 as bit mask
> whereas it's actually an integer value. This causes DAI formats
> other than AC97 (e.g. DSP_B) to trigger AC97 related code,
> which is incorrect and breaks functionality. This patch fixes
> the code to correctly compare values to determine AC97 or not.
>
> Signed-off-by: Adam Thomson<Adam.Thomson.Opensource@diasemi.com>

Acked-by: Timur Tabi <timur@tabi.org>
