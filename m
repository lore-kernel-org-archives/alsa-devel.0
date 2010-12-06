From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Merge common code in DAI link and
 auxiliary codec probing/removal
Date: Mon, 06 Dec 2010 17:31:59 +0000
Message-ID: <1291656719.3281.60.camel@odin>
References: <1291645627-4311-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 06F7C103824
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 18:32:02 +0100 (CET)
Received: by wwi18 with SMTP id 18so4075194wwi.2
	for <alsa-devel@alsa-project.org>; Mon, 06 Dec 2010 09:32:01 -0800 (PST)
In-Reply-To: <1291645627-4311-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-12-06 at 16:27 +0200, Jarkko Nikula wrote:
> Commit 2eea392 "ASoC: Add support for optional auxiliary dailess codecs"
> added much of code that can be shared with DAI link codec probing/removal.
> Merge now this common code into new soc_probe_codec, soc_remove_codec and
> soc_post_component_init functions.
> 
> Error prints in these functions are converted to use dev_err and to print
> the error code.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
