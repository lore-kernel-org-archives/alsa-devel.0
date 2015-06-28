From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH] ASoC: fsl_ssi: fix AC'97 mode
Date: Sun, 28 Jun 2015 14:39:15 +0200
Message-ID: <558FEAF3.8030308@maciej.szmigiero.name>
References: <558F28E1.7040204@maciej.szmigiero.name> <558F77B8.9060307@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <558F77B8.9060307@tabi.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@tabi.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

W dniu 28.06.2015 06:27, Timur Tabi pisze:
> Maciej S. Szmigiero wrote:
>> +    if (newbinding && fsl_ssi_is_ac97(ssi_private)) {
> 
> Is the "newbinding" necessary?  I thought only the original PowerPC device trees were the only one that have the old binding, and they never supported AC97.

If there isn't going to be new platforms added with old bindings then this won't be needed - I'll remove it.

Best regards,
Maciej Szmigiero
