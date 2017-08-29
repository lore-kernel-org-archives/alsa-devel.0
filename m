From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3] ASoC: fsl_dma: remove dma_object path
	member
Date: Tue, 29 Aug 2017 09:46:55 -0300
Message-ID: <CAOMZO5B7b61AR21M8MHdPg2dX6Pz3jfH6+CskOH70RrwTKQbJQ@mail.gmail.com>
References: <20170829123755.9496-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 276C5266C6D
 for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2017 14:46:56 +0200 (CEST)
Received: by mail-oi0-f67.google.com with SMTP id b184so2884361oih.4
 for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2017 05:46:56 -0700 (PDT)
In-Reply-To: <20170829123755.9496-1-robh@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 29, 2017 at 9:37 AM, Rob Herring <robh@kernel.org> wrote:
> dma_object.path is unused, so rather than fix it to work with DT
> full_name changes, just remove it.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
