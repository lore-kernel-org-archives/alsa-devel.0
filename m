From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: fsl_esai: Add driver suspend and
 resume to support MEGA Fast
Date: Mon, 6 Jul 2015 07:26:26 -0300
Message-ID: <CAOMZO5C1uY_qWAd_yEj+-yuXwGZgOOn=7Dcb+5ms16ouQRkmEw@mail.gmail.com>
References: <d626b0b7ad28a96fea0a60e7db29b894fb948166.1436176158.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d626b0b7ad28a96fea0a60e7db29b894fb948166.1436176158.git.zidan.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: Timur Tabi <timur@tabi.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 6, 2015 at 6:50 AM, Zidan Wang <zidan.wang@freescale.com> wrote:
> For i.MX6 SoloX, there is a mode of the SoC to shutdown all power source of
> modules during system suspend and resume procedure. Thus, SAI needs to save

You meant ESAI, not SAI.
