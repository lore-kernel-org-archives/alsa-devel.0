From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 2/3] ASoC: fsl_ssi: mark some registers precious
Date: Sun, 10 Jan 2016 15:35:27 -0600
Message-ID: <5692CE9F.9020809@tabi.org>
References: <56771034.5080702@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56771034.5080702@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Maciej S. Szmigiero wrote:
> Mark some registers precious since their
> reads have side effects (like clearing flags).
>
> Signed-off-by: Maciej S. Szmigiero<mail@maciej.szmigiero.name>

Acked-by: Timur Tabi <timur@tabi.org>
