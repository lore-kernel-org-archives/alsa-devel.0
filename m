From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC/MFD: twl4030: Fix dependencies for
	audio codec
Date: Mon, 05 Sep 2011 13:43:51 +0300
Message-ID: <1904434.zs3M0Tebna@barack>
References: <1315214793-661-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog125.obsmtp.com (na3sys009aog125.obsmtp.com
	[74.125.149.153])
	by alsa0.perex.cz (Postfix) with ESMTP id E63E0243F4
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Sep 2011 12:43:58 +0200 (CEST)
Received: by mail-bw0-f44.google.com with SMTP id r4so5310265bka.31
	for <alsa-devel@alsa-project.org>; Mon, 05 Sep 2011 03:43:55 -0700 (PDT)
In-Reply-To: <1315214793-661-1-git-send-email-weber@corscience.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Thomas Weber <weber@corscience.de>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, tiwai@suse.de, broonie@opensource.wolfsonicro.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Monday 05 September 2011 11:26:33 Thomas Weber wrote:
> The codec for Devkit8000 (TWL4030)  was not detected except
> when build with CONFIG_SND_SOC_ALL_CODECS.
> 
> twl-core.c still uses the CONFIG_TWL4030_CODEC for
> twl_has_codec().

acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
