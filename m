From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH][ASoC v2] Update Freescale MPC8610HPCD
	fabric driver to support multiple codecs
Date: Thu, 12 Jun 2008 22:22:13 -0400
Message-ID: <9e4733910806121922h6a5e1e71l3707b5e7b8e6c62f@mail.gmail.com>
References: <1213315299-30592-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.243])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DADF24390
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 04:22:14 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so3450151rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2008 19:22:13 -0700 (PDT)
In-Reply-To: <1213315299-30592-1-git-send-email-timur@freescale.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

You're loading the fabric driver as a platform driver controlled via
Kconfig. Has any progress been made on a way to trigger loading it via
the device tree?

Why are you calling all of the mpc code fsl? Freescale makes other
processors that start with imx, mcp, mac, mmc, m68... I find calling
the mpc code fsl to be very confusing. Or is Freescale planning on
putting these ssi, dma, etc cells into all of their other processors?

-- 
Jon Smirl
jonsmirl@gmail.com
