From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Question about SPDIF
Date: Tue, 28 Dec 2010 11:28:34 +0000
Message-ID: <20101228112834.GA31292@opensource.wolfsonmicro.com>
References: <w3pwrmu8owe.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 182BC10387F
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 12:28:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <w3pwrmu8owe.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 28, 2010 at 02:09:05PM +0900, Kuninori Morimoto wrote:

> I think this function can use SND_SOC_DAIFMT_xxx
> which have I2S / PCM etc...

> I wonder how is SPDIF selected ?

Normally S/PDIF interfaces can only do S/PDIF so there's no need to
explicitly set the DAI format when using them.
