From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [linux-sunxi] [PATCH v2 07/12] dmaengine: sun6i:
	support V3s SoC variant
Date: Mon, 6 Mar 2017 11:58:17 +0800
Message-ID: <CAGb2v64RG2YVFk18MrKikutOA-4P8DtD3hHy1gZ3bth95PkuYg@mail.gmail.com>
References: <20170305133709.6288-1-icenowy@aosc.xyz>
 <20170305133709.6288-8-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw [140.112.30.61])
 by alsa0.perex.cz (Postfix) with ESMTP id 0533F266871
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 04:58:40 +0100 (CET)
Received: from mail-io0-f178.google.com (mail-io0-f178.google.com
 [209.85.223.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: b93043)
 by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 5747D22598
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 11:58:39 +0800 (CST)
Received: by mail-io0-f178.google.com with SMTP id 90so105488222ios.1
 for <alsa-devel@alsa-project.org>; Sun, 05 Mar 2017 19:58:39 -0800 (PST)
In-Reply-To: <20170305133709.6288-8-icenowy@aosc.xyz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Icenowy Zheng <icenowy@aosc.xyz>
Cc: devicetree <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 5, 2017 at 9:37 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> Allwinner V3s has a DMA engine similar to the ones from A31, but with
> fewer channels and DRQs.
>
> Add support for it.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Acked-by: Chen-Yu Tsai <wens@csie.org>
