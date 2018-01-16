From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 21/38] ASoC: fsl: asrc: replace platform to
 component
Date: Mon, 15 Jan 2018 16:55:56 -0800
Message-ID: <20180116005555.GA2421@Asurada-CZ80>
References: <87vag7gb9o.wl%kuninori.morimoto.gx@renesas.com>
 <871sivgav2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f67.google.com (mail-pl0-f67.google.com
 [209.85.160.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 010D1267626
 for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2018 01:56:02 +0100 (CET)
Received: by mail-pl0-f67.google.com with SMTP id bi12so4864657plb.6
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 16:56:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <871sivgav2.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 12, 2018 at 12:50:12AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Now platform can be replaced to component, let's do it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Tested-by: Nicolin Chen <nicoleotsuka@gmail.com>

Tested with the prerequisite patch:
 [PATCH 01/38] ASoC: remove rtd->platform checck
