From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [patch] ALSA: soc-cache: dereferencing before
 checking
Date: Mon, 07 Feb 2011 19:11:53 +0000
Message-ID: <1297105913.3331.356.camel@odin>
References: <20110207190141.GJ4384@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id AB792244F4
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 20:11:58 +0100 (CET)
Received: by wwe15 with SMTP id 15so4980917wwe.20
	for <alsa-devel@alsa-project.org>; Mon, 07 Feb 2011 11:11:58 -0800 (PST)
In-Reply-To: <20110207190141.GJ4384@bicker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <error27@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-02-07 at 22:01 +0300, Dan Carpenter wrote:
> The patch c358e640a66 "ASoC: soc-cache: Add trace event for
> snd_soc_cache_sync()" introduced a dereference of "codec->cache_ops"
> before we had checked it for NULL.
> 
> I pulled the check forward, and then pulled everything in an indent
> level.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
