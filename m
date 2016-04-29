From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 0/6] ASoC: fsl_ssi: Fixing various
 channel slips and bad samples insertions
Date: Thu, 28 Apr 2016 20:54:02 -0700
Message-ID: <20160429035402.GB1944@Asurada>
References: <1453130771-24419-1-git-send-email-arnaud.mouiche@invoxia.com>
 <CAOMZO5A0FRZ52UGeqLJaVF8BiWhzmpNSgQm4B0U1gc2wGU6KhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 by alsa0.perex.cz (Postfix) with ESMTP id A22BE265132
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2016 05:54:06 +0200 (CEST)
Received: by mail-pa0-f49.google.com with SMTP id bt5so40207531pac.3
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 20:54:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOMZO5A0FRZ52UGeqLJaVF8BiWhzmpNSgQm4B0U1gc2wGU6KhA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Caleb Crome <caleb@crome.org>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 29, 2016 at 12:44:16AM -0300, Fabio Estevam wrote:
> Hi Nicolin and Timur,
> 
> On Mon, Jan 18, 2016 at 1:26 PM, Arnaud Mouiche
> <arnaud.mouiche@invoxia.com> wrote:
> >
> > This series of patch is an attempt to fix the fsl_ssi driver to use it in TDM mode (DSP A or B) with a large number of channels/slots.
> 
> Any feedback about this series?
> 
> It addresses important fixes for the fsl_ssi driver.

Patches look fine to me. I thought there was going to be another version.

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
