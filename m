From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V2] ASoC: fsl_esai: Add pm runtime function
Date: Thu, 18 Apr 2019 12:48:58 -0700
Message-ID: <20190418194857.GB14885@Asurada-Nvidia.nvidia.com>
References: <8c78be27ef3795e9b870de7789c25454bd3774b3.1555586023.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8c78be27ef3795e9b870de7789c25454bd3774b3.1555586023.git.shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 18, 2019 at 11:34:15AM +0000, S.j. Wang wrote:
> Add pm runtime support and move clock handling there.
> fsl_esai_suspend is replaced by pm_runtime_force_suspend.
> fsl_esai_resume is replaced by pm_runtime_force_resume.

The change looks fine, yet I'd prefer to have a good justification
in the commit message. It could be simply some benefit of doing so
like what you have discussed with Mark.

> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Please add it in next version upon commit message update:

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks
