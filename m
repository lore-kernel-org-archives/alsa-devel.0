From: Timur Tabi <timur@tabi.org>
Subject: Re: [alsa-devel][PATCH 2/2] ASoC: fsl_ssi: sound is wrong after suspend/resume
Date: Mon, 6 Jul 2015 21:35:12 -0400
Message-ID: <0CBF1167-B9A2-47DB-9E57-F3D55AEDD8A5@tabi.org>
References: <dc75cce800ec7465303b94e6a18abe616a35d739.1436172253.git.zidan.wang@freescale.com> <59abec18b5cf1d8e05ba3ae4aad89719bbeca052.1436172253.git.zidan.wang@freescale.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <59abec18b5cf1d8e05ba3ae4aad89719bbeca052.1436172253.git.zidan.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Jul 6, 2015, at 4:49 AM, Zidan Wang wrote:

> The register SFCSR is volatile, but some bits in it need to be
> recovered after suspend/resume.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>

Shouldn't this be part of patch #1?
