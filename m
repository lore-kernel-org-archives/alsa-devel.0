From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: fsi: Add spin lock operation for
 accessing shared area
Date: Thu, 28 Jan 2010 10:23:27 +0000
Message-ID: <1264674207.3044.0.camel@odin>
References: <uhbq66d2m.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 238DB103822
	for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2010 11:23:31 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 19so199530fgg.2
	for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2010 02:23:30 -0800 (PST)
In-Reply-To: <uhbq66d2m.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-01-28 at 13:46 +0900, Kuninori Morimoto wrote:
> fsi_master_xxx function should be protected by spin lock,
> because it are used from both FSI-A and FSI-B.
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---

Acked-by: Liam Girdwood <lrg@slimlgic.co.uk>
